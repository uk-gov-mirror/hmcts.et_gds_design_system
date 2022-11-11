Rails.application.routes.draw do
  mount EtGdsDesignSystem::ApiProxy.new(backend: "#{Rails.application.config.et_gds_design_system.api_url}", streaming: false), at: "/api/v2/create_blob"
  mount EtGdsDesignSystem::ApiProxy.new(backend: "#{Rails.application.config.et_gds_design_system.api_url}", streaming: false), at: "/api/v2/blobs/:signed_id/*filename"
end
