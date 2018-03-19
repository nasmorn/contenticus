class Contenticus::Admin::BaseController < Contenticus.config.admin_base_controller.to_s.constantize
  layout 'contenticus/admin'

  private

  def save_and_close?
    params.fetch(:close_after_save) == "close"
  end

end
