class Contenticus::Admin::BaseController < ApplicationController

  layout 'contenticus/admin'

  private

  def save_and_close?
    params.fetch(:close_after_save) == "close"
  end

end