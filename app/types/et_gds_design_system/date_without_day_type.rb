module EtGdsDesignSystem
  class DateWithoutDayType < ActiveRecord::Type::Date
    private

    def fallback_string_to_date(string)
      new_date(*::Date._parse(string, false).values_at(:year, :mon), 1)
    end

    def value_from_multiparameter_assignment(value)
      super(value.merge(3 => 1))
    end
  end
end
