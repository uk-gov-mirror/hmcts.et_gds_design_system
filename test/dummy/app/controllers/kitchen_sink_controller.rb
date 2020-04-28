class KitchenSinkController < ApplicationController
  def new
    @kitchen_sink = KitchenSink.new
  end

  def create
  end
end
