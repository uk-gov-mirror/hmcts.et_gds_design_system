require 'rack-proxy'

module EtGdsDesignSystem
  class ApiProxy < Rack::Proxy
    def rewrite_env(env)
      env.merge 'REQUEST_URI' => modified_url_for(env),
                'HTTP_HOST' => "#{et_api_uri.host}:#{et_api_uri.port}",
                'PATH_INFO' => ''
    end

    private

    def modified_url_for(env)
      uri = et_api_uri.clone
      uri.path = env['REQUEST_PATH']
      uri.to_s
    end

    def et_api_uri
      @et_api_uri ||= URI.parse(Rails.application.config.et_gds_design_system.api_url)
    end
  end
end
