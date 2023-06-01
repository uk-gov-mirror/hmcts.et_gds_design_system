module EtGdsDesignSystem
  module Api
    class ShowBlobService < ::EtGdsDesignSystem::ApiService
      def call(headers:, signed_id:, filename:, format:)
        path = "/blobs/#{signed_id}/#{filename}.#{format}"
        send_request(path: path,
                     headers: { 'Accept': 'application/json',
                                'Content-Type': headers['CONTENT_TYPE'],
                                'Content-Length': headers['CONTENT_LENGTH'] },
                     subject: :blob)
      end

      private

      def send_request(path:,
                       subject:,
                       api_base: ENV.fetch('ET_API_URL',
                                           'http://api.et.127.0.0.1.nip.io:3100/api/v2'),
                       headers: {})

        request = Typhoeus::Request.new "#{api_base}#{path}",
                                verbose: true, method: :get,
                                headers: default_headers.merge(headers)
        perform_requests(request)
        self.response = request.response
        log_response
        self.response = request.response
        generate_custom_errors
        response
      end

      def generate_custom_errors
        return if response.success?

        case response.code
        when 404
          errors.add(:base, :file_not_found, message: 'File not found')
        else
          errors.add(:base, :unknown_error, message: 'Unknown error')
        end
      end
    end
  end
end
