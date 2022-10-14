require 'rack-proxy'

module EtGdsDesignSystem
  class ApiProxy < Rack::Proxy
    def rewrite_env(env)
      env.merge 'REQUEST_URI' => correct_host(env['REQUEST_URI']),
                'HTTP_HOST' => "#{et_api_uri.host}:#{et_api_uri.port}",
                'PATH_INFO' => ''
    end

    private

    def correct_host(url)
      uri = URI.parse(url)
      uri.scheme = et_api_uri.scheme
      uri.host = et_api_uri.host
      uri.port = et_api_uri.port
      uri.to_s
    end

    def et_api_uri
      @et_api_uri ||= URI.parse(Rails.application.config.et_gds_design_system.api_url)
    end
  end
end
