class KitchenSink
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :text_field_value, :string

  def add_example_errors
    errors.add :text_field_value, 'An error for Text Field Value'
  end
end
