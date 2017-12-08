class Admin::DocumentsController < ApplicationController

  before_action :set_active_link,
    only: %w(index new edit)

  skip_before_action :require_sysadmin!
  skip_before_action :require_admin!

  def index
    @documents = Simplec::Document.order(name: :asc).
      page(params[:page])
  end

  def new
    @document = Simplec::Document.new
  end

  def create
    @document = Simplec::Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to edit_document_url(@document), notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @document = Simplec::Document.find(params[:id])
  end

  def update
    @document = Simplec::Document.find(params[:id])

    respond_to do |format|
      if @document.update(document_params(@document))
        format.html { redirect_to edit_document_url(@document), notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document = Simplec::Document.find(params[:id])

    if current_user.sysadmin? || !@document.required?
      @document.destroy!
      redirect_to documents_url
    else
      redirect_to edit_document_url(@document)
    end
  end

  private

  def document_params(document=nil)
    attrs = [
      :name, :description,
      :file, :removed_file, :retained_file
    ]
    attrs += [
      :document_set_id,
      subdomain_ids: []
    ] if current_user.sysadmin? || document.nil? || !document.required?
    attrs += [
      :slug, :required
    ] if current_user.sysadmin?
    params.require(:document).permit(attrs)
  end

end
