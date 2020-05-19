class KitchenSink
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :text_field_value, :string
  attribute :text_area_value, :string
  attribute :date_field_value, :date

  def add_example_errors
    errors.add :text_field_value, 'Text field error'
    errors.add :text_area_value, 'Text area error'
    errors.add :date_field_value, 'Date field error'
  end
end
