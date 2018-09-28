class Contenticus::Admin::PagesController < Contenticus::Admin::BaseController
  layout "contenticus/admin"

  before_action :provide_layouts, only: [:new, :edit, :update]

  def index
    @pages = Contenticus::Slug.where(sluggable_type: "Contenticus::Page").includes(sluggable: :block).arrange(order: "position")
  end

  def new
    build_page
    @slug = ::Contenticus::Slug.new
    @page.slug.parent_id = params[:parent_id] if params[:parent_id]
  end

  def create
    @page = ::Contenticus::Admin::CreatePage.call(slug_params: create_slug_params, block_params: create_block_params)
    redirect_to contenticus_admin_pages_path
  end

  def show
    redirect_to edit_contenticus_admin_page_path(id: params[:id])
  end

  def edit
    @page = Contenticus::Page.find(params[:id])
    @block = @page.block
    @meta = @page.meta
  end

  def update
    @page = ::Contenticus::Admin::UpdatePage.call(id: params[:id], tag_params: page_params)
    @meta = @page.meta.reload
    @block = @page.block.reload
    if @page.errors.empty? && params[:close_after_save] == "close"
      redirect_to contenticus_admin_pages_path
    else
      render 'edit'
    end
  end

  def change_template
    @page = Contenticus::Page.find(params[:id])
    ::Contenticus::Admin::ChangeTemplate.call(block: @page.block, template: params.fetch(:template))
    redirect_to contenticus_admin_pages_path
  end

  def destroy
    success = ::Contenticus::Admin::DestroyPage.call(page_id: params[:id])
    flash[:danger] = 'Cannot delete page with children.' unless success
    redirect_to contenticus_admin_pages_path
  end

  def reorder
    (params[:contenticus_slug] || []).each_with_index do |id, index|
      ::Contenticus::Slug.where(:id => id).update_all(:position => index)
    end
    render :nothing => true
  end

  private

  def provide_layouts
    @layouts = ['redirect'] + ::Contenticus::Layout.available_for('pages')
  end

  def create_slug_params
    page_params.fetch(:slug).permit(:slug, :label, :parent_id)
  end

  def create_block_params
    page_params.fetch(:block).permit(:layout)
  end

  def page_params
    params.fetch(:contenticus_page).permit!
  end

  def build_page
    @page = Contenticus::Page.new
    @page.build_block
    @page.build_slug
  end

end
