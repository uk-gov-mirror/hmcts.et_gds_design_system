class KitchenSinksController < ApplicationController
  helper_method :show_hint?

  def new
    @kitchen_sink = KitchenSink.new
    add_errors
  end

  def create
    @kitchen_sink = KitchenSink.new(my_attrs)
    @from_create = true

    render :new
  end

  def add_errors
    return unless params[:render_with_errors] == 'true'

    @kitchen_sink.add_example_errors
  end

  def show_hint?
    params[:render_with_hint] == 'true'
  end

  private

  def my_attrs
    my_params = params[:kitchen_sink].to_unsafe_hash
    my_params['date_field_value']
    my_params
  end
end
