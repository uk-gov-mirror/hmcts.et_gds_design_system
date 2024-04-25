module EtGdsDesignSystem
  class Deprecator
    def deprecation_warning(deprecated_method_name, message, caller_backtrace = nil)
      message = "#{deprecated_method_name} is deprecated and will be removed from et-gds-design-system | #{message}"
      Kernel.warn message
    end
  end
end