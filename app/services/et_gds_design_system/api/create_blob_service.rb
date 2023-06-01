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
    end
  end
end
