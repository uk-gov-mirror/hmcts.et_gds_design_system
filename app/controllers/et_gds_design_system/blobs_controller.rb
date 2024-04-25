module EtGdsDesignSystem
  class BlobsController < ::ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      service = Api::CreateBlobService.new
      request.body.rewind
      response = service.call(request.body.read, headers: request.headers)
      respond_to do |format|
        if response.success?
          format.json { render json: service.response_data }
        else
          format.json { render json: service.response_data, status: response.code }
        end
      end
    end

    def show
      service = Api::ShowBlobService.new
      response = service.call(headers: request.headers, signed_id: params[:signed_id], filename: params[:filename],
                              format: params[:format])
      if service.valid?
        send_data response.body, filename: "#{params[:filename]}.#{params[:format]}", type: response.headers['Content-Type']
      else
        render body: response.body, content_type: response.headers['Content-Type'], status: response.code
      end
    end
  end
end
