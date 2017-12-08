class Admin::PagesController < ApplicationController

  before_action :set_active_link,
    only: %w(index new edit)

  skip_before_action :require_admin!,
    only: %w(index edit update) # TODO check logic here
  skip_before_action :require_sysadmin!

  def index
    @pages = AdminPage.accessible_by(current_user).
      includes(:subdomain).
      order("simplec_subdomains.name ASC, simplec_pages.path ASC").
      page(params[:page])

    # Admin subdomain filter
    #@pages = @pages.filter_subdomain(params[:subdomain_id]) if params[:subdomain_id].present?
  end

  def new
    @page = Page.type(params[:type] || "Page::Home").new
  end

  def create
    @page = Page.type(params[:page][:type]).new(page_params)

    if @page.save
      redirect_to edit_admin_page_url(@page)
    else
      render :new
    end
  end

  def edit
    @page = Page.accessible_by(current_user).find(params[:id])
  end

  def update
    @page = Page.accessible_by(current_user).find(params[:id])

    if @page.update(page_params)
      redirect_to edit_admin_page_url(@page)
    else
      render :edit
    end
  end

  def destroy
    @page = Page.accessible_by(current_user).find(params[:id])
    if @page.destroy
      redirect_to admin_pages_url
    else
      render :edit
    end
  end

  private

  def page_params
    cls = Page.type(params[:page][:type])
    attributes = [
      :type, :subdomain_id, :parent_id, :slug,
      :title, :meta_description, :layout
    ] +
    cls.field_names +
    cls.field_names(:file).inject(Array.new) {|memo, name|
      memo << :"remove_#{name}"
      memo << :"retained_#{name}"
      memo
    }
    # add file field names plus remove and retained
    attributes += [permissible_user_ids: []] if current_user.admin? ||
      current_user.sysadmin?
    params.require(:page).permit(*attributes)
  end
end
