module EtGdsDesignSystem
  module Api
    class CreateBlobService < ::EtGdsDesignSystem::ApiService
      def call(body, headers:)
        send_request(body,
                     path: '/create_blob',
                     headers: { 'Accept': 'application/json',
                                'Content-Type': headers['CONTENT_TYPE'],
                                'Content-Length': headers['CONTENT_LENGTH'] },
                     subject: :blob)
      end

      private

      def send_request(body,
                       path:,
                       subject:,
                       api_base: ENV.fetch('ET_API_URL',
                                           'http://api.et.127.0.0.1.nip.io:3100/api/v2'),
                       headers: {})
        log_body(body, url: "#{api_base}#{path}", subject: subject)

        request = Typhoeus::Request.new "#{api_base}#{path}",
                                        verbose: true, method: :post, body: body,
                                        headers: default_headers.merge(headers)
        perform_requests(request)
        self.response = request.response
        parse_response
        log_response
        response
      end

      def parse_response
        self.response_data = JSON.parse(response.body)
      rescue JSON::ParserError
        self.response_data = {
          status: 'internal_server_error',
          uuid: '',
          errors: [
            {
              status: 500,
              code: 'invalid_json',
              title: 'An error occured parsing the JSON from the API',
              detail: 'An error occured parsing the JSON from the API',
              options: {}, source: '', command: '', uuid: ''

            }
          ]
        }
      end
    end
  end
end
