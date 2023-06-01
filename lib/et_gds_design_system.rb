require 'et_gds_design_system/engine'
require 'et_gds_design_system/form/builder'
require 'typhoeus'
module EtGdsDesignSystem
  def self.form_builder_class
    Form::Builder
  end
end
