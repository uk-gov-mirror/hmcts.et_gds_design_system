Rails.application.routes.draw do
  mount EtGdsDesignSystem::ApiProxy.new(backend: "#{Rails.application.config.et_gds_design_system.api_url}/build_blob", streaming: false), at: "/api/v2/build_blob"
end
