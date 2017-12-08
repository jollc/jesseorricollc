class Admin::AlertsController < ApplicationController
  before_action :set_active_link,
    only: %w(index new edit)

  skip_before_action :require_admin!
  skip_before_action :require_sysadmin!

  def index
    @alerts = Alert.all
  end

  def new
    @alert = Alert.new
  end

  def create
    @alert = Alert.new(alert_params)

    @alert.save
    redirect_to edit_alert_url(@alert)
  end

  def edit
    @alert = Alert.find(params[:id])
  end

  def update
    @alert = Alert.find(params[:id])

    if @alert.update(alert_params)
      redirect_to edit_alert_url(@alert)
    else
      render :edit
    end
  end

  def destroy
    @alert = Alert.find(params[:id])

    @alert.destroy
    respond_to do |format|
      format.html { redirect_to alerts_url, notice: 'Alert was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def alert_params
      params.require(:alert).permit(
      :content, :start_date, :end_date, :link, :notes, :archive
      )
    end
end
