require 'scrapper'

class AlertsController < ApplicationController

  before_filter :logged_in?

  before_filter :authorize!, except: [:new, :create, :process_alerts]

  # GET /alerts
  # GET /alerts.json
  def index
    @alerts = Alert.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @alerts }
    end
  end

  # GET /alerts/1
  # GET /alerts/1.json
  def show
    @alert = Alert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @alert }
    end
  end

  # GET /alerts/new
  # GET /alerts/new.json
  def new
    @alert = Alert.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @alert }
    end
  end

  # GET /alerts/1/edit
  def edit
    @alert = Alert.find(params[:id])
  end

  # POST /alerts
  # POST /alerts.json
  def create
    @alert = Alert.new(params[:alert])
    @alert.sent = false

    if @alert.save
      if @alert.hit_web
        @alert.update_attribute(:sent, true)
        redirect_to new_alert_url, notice: "¡Hey! Ya hay trenes para esta fecha. Visita <a href='http://www.renfe.com'>Renfe</a>".html_safe
      else
        AlertMailer.created(@alert).deliver
        redirect_to new_alert_url, notice: 'Nueva alerta configurada. Recibirás email cuando haya disponibilidad de trenes'
      end
    else
      render action: "new"
    end
  end

  # PUT /alerts/1
  # PUT /alerts/1.json
  def update
    @alert = Alert.find(params[:id])

    respond_to do |format|
      if @alert.update_attributes(params[:alert])
        format.html { redirect_to @alert, notice: 'Alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.json
  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy

    respond_to do |format|
      format.html { redirect_to alerts_url }
      format.json { head :no_content }
    end
  end

  def process_alerts
    Scrapper.perform_async
  end

  def unsubscribe
    @alert = Alert.find(params[:id])
    @alert.update_attribute(:sent, true)

    redirect_to new_alert_url, notice: 'No recibirás más emails sobre esa alerta.'
  end
end
