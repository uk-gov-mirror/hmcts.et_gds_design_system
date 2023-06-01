// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
import { EtGdsDesignSystem, Components } from "et_gds_design_system"
import "et_gds_design_system/stylesheet"
EtGdsDesignSystem.initAll();

const { DropzoneUploader } = Components;
window.DropzoneUploader = DropzoneUploader;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
//const images = require.context('et_gds_design_system/dist/packs/media/images', true)
//const fonts = require.context('et_gds_design_system/dist/packs/media/fonts', true)
