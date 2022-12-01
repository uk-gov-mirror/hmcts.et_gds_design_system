import Dropzone from "dropzone";
import axios from "axios";
import { v4 as uuidv4 } from 'uuid';
import SparkMD5 from 'spark-md5';
import previewTemplate from "./DropzoneUploader/preview-template.html";
Dropzone.autoDiscover = false

let uploadKey, dropzoneUploadForm;

function setUploadUrl(url) {
  dropzoneUploadForm.options.url = url;
}

function buildUpload(cb) {
  axios.post(
    "/api/v2/build_blob",
    {
      uuid: uuidv4(),
      command: "BuildBlob",
      async: false,
      data: {
        preventEmptyData: true
      }
    },
    {
      responseType: 'json',
      headers: {
        'Accept': 'application/json'
      }
    }
  )
    .then((response) => {
      cb.apply(this, [response.data]);
    })
    .catch(onGetPresignedError)
}

function onGetPresignedError(error) {
  /* TODO: RST-1220:
      Anticipate and handle errors:
      - Network issue to API (no response)
      - Network issue to/from Azure/S3 (API responds with bad data)
  */
}

function hideButton() {
  document.querySelector("*[data-auto-hide]").style.display = 'none';
}

function showButton() {
  document.querySelector("*[data-auto-hide]").style.display = '';
}


function setupAzure(file, presignedData, done) {
  dropzoneUploadForm.options.method = 'put';
  dropzoneUploadForm.options.headers = {"x-ms-blob-type": "BlockBlob"};
  getFileHash(file, function (hash) {
    dropzoneUploadForm.options.headers["Content-MD5"] = hash;
    uploadKey = presignedData.data.fields.key;
    setUploadUrl(presignedData.data.url);
    hideButton();
    done();
  })
}

function getFileHash(file, headerCallback) {
  let blobSlice = File.prototype.slice || File.prototype.mozSlice || File.prototype.webkitSlice,
    chunkSize = 2097152,                             // Read in chunks of 2MB
    chunks = Math.ceil(file.size / chunkSize),
    currentChunk = 0,
    spark = new SparkMD5.ArrayBuffer(),
    fileReader = new FileReader();

  fileReader.onload = function (e) {
    spark.append(e.target.result);                   // Append array buffer
    currentChunk++;

    if (currentChunk < chunks) {
      loadNext();
    } else {
      const hash = btoa(spark.end(true));
      headerCallback(hash);
    }
  };

  fileReader.onerror = function () {
    console.warn('oops, something went wrong.');
  };

  function loadNext() {
    let start = currentChunk * chunkSize,
      end = ((start + chunkSize) >= file.size) ? file.size : start + chunkSize;

    fileReader.readAsArrayBuffer(blobSlice.call(file, start, end));
  }

  loadNext();
}

/**
 *
 * @param node
 * @param type - The content type - for ET3 was 'application/rtf'
 * @param acceptedFiles - The accepted files - for ET3 was ".rtf"
 * @param removeFileButtonText - Self explanatory
 * @param attributeName - The attribute name from rails
 * @returns {}
 */
const initDropzone = (node, type, acceptedFiles, attributeName) => {
  let provider;
  const extractPreviewContent = () => {
    const templateContainer = node.querySelector('*[data-gds-dropzone-uploader-preview-template]')
    templateContainer.parentElement.removeChild(templateContainer)
    return templateContainer.innerHTML
  }

  const DROPZONE_OPTIONS = {
    url: '/api/v2/create_blob',
    init: function () {
      this.on("maxfilesexceeded", function (file) {
        // TODO: RST-1220 - Error Handling:
        // Build a proper warning system for "too many files" warning.
        alert("Too many files")
      });
      this.on("removedfile", function () {
        node.querySelectorAll("*[data-submit-key]").forEach((inputEl) => inputEl.removeAttribute('value'))
      });
      this.on('sending', (file, xhr) => {
        // Source: https://github.com/enyo/dropzone/issues/590#issuecomment-51498225
        if (provider === 'azure') {
          const send = xhr.send;
          xhr.send = function () {
            send.call(xhr, file);
            xhr.send = send;
          };
        }
      });
      this.on('success', (file, decodedResponse, event) => {
        node.querySelector("*[data-submit-key=path]").setAttribute('value', decodedResponse.data.key)
        node.querySelector("*[data-submit-key=filename]").setAttribute('value', decodedResponse.data.filename)
        node.querySelector("*[data-submit-key=content_type]").setAttribute('value', decodedResponse.data.content_type)
        showButton();
      })
      this.on('error', (file, decodedResponse, xhr) => {
        if(decodedResponse.status !== 'not_accepted') { return }

        const message = decodedResponse.errors.map((error) => error.title).join('<br />')
        document.querySelector("*[data-dz-errormessage]").textContent = message;
      })

      let filenameElement = node.querySelector("*[data-submit-key=filename]");
      let filenameValue = filenameElement.getAttribute('value');
      if (filenameValue) {
        let existingFile = {name: filenameValue, type: type};
        this.options.addedfile.call(this, existingFile);
        existingFile.previewElement.classList.add('dz-success');
        existingFile.previewElement.classList.add('dz-complete');
      }
    },
    // Only one file goes to the bucket via the URL
    parallelUploads: 1,
    uploadMultiple: false,
    // Set acceptance criteria, one .rtf file
    maxFiles: 1,
    acceptedFiles: acceptedFiles,
    clickable: '*[data-gds-dropzone-upload-button]',
    previewTemplate: extractPreviewContent(),
    // Use POST by default for AWS
    // TODO: RST-1676 Default this to 'put' and remove the assignment within the buildUpload if statement
    method: "post",
    // Add a link to remove files that were erroneously uploaded
    addRemoveLinks: false,
    canceled: function (file) {
      showButton()
      node.querySelectorAll("*[data-submit-key]").forEach((inputEl) => inputEl.setAttribute('value', null))
    }
  };

  dropzoneUploadForm = new Dropzone(node, DROPZONE_OPTIONS)
  return dropzoneUploadForm
}

/**
 * @param uploadKeyId
 * @param fileNameId
 * @param type - The content type - for ET3 was 'application/rtf'
 * @param acceptedFiles - The accepted files - for ET3 was ".rtf"
 */
const DropzoneUploader = {
  init: () => {
    const nodes = Array.from(document.querySelectorAll('[data-module="et-gds-design-system-dropzone-uploader"]'));
    nodes.forEach((node) => {
      const type = node.getAttribute('data-type')
      const acceptedFiles = node.getAttribute('data-accepted-files')
      const attributeName = node.getAttribute('data-attribute-name')
      initDropzone(node, type, acceptedFiles, attributeName);
    })
  }
}
export default DropzoneUploader;
