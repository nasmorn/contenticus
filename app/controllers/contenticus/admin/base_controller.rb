class Contenticus::Admin::BaseController < ApplicationController

  private

  def save_and_close?
    params.fetch(:close_after_save) == "close"
  end

end