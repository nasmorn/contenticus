class Contenticus::Admin::SnippetsController < Contenticus::Admin::BaseController
  layout "contenticus/admin"

  def index
    @snippets = Contenticus::Snippet.order(:label)
  end

  def new
    @layouts = Contenticus::Layout.available_for('snippets') + Contenticus::Layout.available_for('blocks')
    build_snippet
  end

  def create
    @snippet = ::Contenticus::Admin::CreateSnippet.call(label: snippet_params.fetch(:label), key: snippet_params.fetch(:key), block_params: create_block_params)
    if save_and_close?
      redirect_to contenticus_admin_snippets_path
    else
      redirect_to edit_contenticus_admin_snippet_path(@snippet)
    end
  end

  def edit
    @snippet = Contenticus::Snippet.find(params[:id])
    @tags = @snippet.block.tags
  end

  def update
    @snippet, @tags = ::Contenticus::Admin::UpdateSnippet.call(id: params[:id], tag_params: snippet_params)
    if save_and_close?
      redirect_to contenticus_admin_snippets_path
    else
      render 'edit'
    end
  end

  def destroy
    ::Contenticus::Snippet.find(params[:id]).destroy
    redirect_to contenticus_admin_pages_path
  end

  private

  def create_block_params
    snippet_params.fetch(:block).permit(:layout)
  end

  def snippet_params
    params.fetch(:contenticus_snippet)
  end

  def build_snippet
    @snippet = Contenticus::Snippet.new
    @snippet.build_block
  end

end