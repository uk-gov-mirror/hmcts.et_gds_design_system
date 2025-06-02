require 'et_gds_design_system/api_proxy'
module EtGdsDesignSystem
  class Engine < ::Rails::Engine
    config.et_gds_design_system = ::Rails::Application::Configuration::Custom.new
    config.et_gds_design_system.api_url = 'http://api.et.127.0.0.1.nip.io:3100/api'
    initializer 'et_gds_design_system.assets' do |app|
      app.config.assets.paths << Rails.root.join('node_modules', 'govuk-frontend', 'dist', 'govuk', 'assets', 'images')
      app.config.assets.paths << Rails.root.join('node_modules', 'govuk-frontend', 'dist', 'govuk', 'assets', 'fonts')
    end
  end
end
