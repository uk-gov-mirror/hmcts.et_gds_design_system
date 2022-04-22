Rails.application.config.to_prepare do
  ActiveRecord::Type.register(:date_without_day, EtGdsDesignSystem::DateWithoutDayType)
  ActiveRecord::Type.register(:gds_azure_file, EtGdsDesignSystem::AzureFile)
end
