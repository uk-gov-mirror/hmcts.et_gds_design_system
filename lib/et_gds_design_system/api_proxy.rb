require 'rack-proxy'

module EtGdsDesignSystem
  class ApiProxy < Rack::Proxy
    def rewrite_env(env)
      et_api_uri = URI.parse(Rails.application.config.et_gds_design_system.api_url)
      env.merge 'HTTP_HOST' => et_api_uri.host,
                'REQUEST_URI' => "#{et_api_uri}/build_blob",
                'REQUEST_PATH' => "/api/v2/build_blob",
                'SCRIPT_NAME' => "/api/v2/build_blob",
                'PATH_INFO' => ''
    end
  end
end
