class KitchenSinksController < ApplicationController
  helper_method :show_hint?

  def new
    @kitchen_sink = KitchenSink.new
    add_errors
  end

  def create
  end

  def add_errors
    return unless params[:render_with_errors] == 'true'

    @kitchen_sink.add_example_errors
  end

  def show_hint?
    params[:render_with_hint] == 'true'
  end
end
