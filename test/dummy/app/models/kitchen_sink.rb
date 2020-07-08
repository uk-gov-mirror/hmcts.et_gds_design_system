class KitchenSink
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :text_field_value, :string
  attribute :file_field_value, :string
  attribute :text_area_value, :string
  attribute :date_field_value, :date
  attribute :collection_radio_buttons_value, :boolean
  attribute :phone_field_value, :string
  attribute :email_field_value, :string
  attribute :collection_check_boxes_value, :boolean
  attribute :collection_select_value

  def add_example_errors
    errors.add :text_field_value, 'Text field error'
    errors.add :file_field_value, 'File field error'
    errors.add :text_area_value, 'Text area error'
    errors.add :date_field_value, 'Date field error'
    errors.add :collection_radio_buttons_value, 'Collection radio buttons error'
    errors.add :phone_field_value, 'Phone field error'
    errors.add :email_field_value, 'Email field error'
    errors.add :collection_check_boxes_value, 'Collection check boxes error'
    errors.add :collection_select_value, 'Collection select error'
  end
end
