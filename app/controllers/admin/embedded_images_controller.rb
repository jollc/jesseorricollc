class Admin::EmbeddedImagesController < ApplicationController

  skip_before_action :require_sysadmin!

  def create
    @embedded_image = EmbeddedImage.new(embedded_image_params)
    if @embedded_image.save
      respond_to do |format|
        format.json {
          render :show, status: 201, location: @embedded_image.url
        }
      end
    else
      respond_to do |format|
        format.json {
          render status: 422, json: @embedded_image.errors
        }
      end
    end
  end

  private

  def embedded_image_params
    params.permit(:asset_url, :asset_name)
  end

end
