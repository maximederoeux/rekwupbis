class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @user = current_user
    @myevents = @events.where(:creator_id => current_user.id) | @events.where(:organizer_id => current_user.id)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @user = current_user
    @event = Event.find(params[:id])
    @creator = @event.creator
    @organizer = @event.organizer
    @new_offer = Offer.new
    @thiseventoffers = Offer.where(:event_id => @event.id)
    unless current_user.admin or current_user == @creator or current_user == @organizer
      redirect_to :back, :alert => t("notice.access")
    end
  end

  # GET /events/new
  def new
    @event = Event.new
    @user = current_user
  end

  # GET /events/1/edit
  def edit
    @user = current_user
    @event = Event.find(params[:id])
    @creator = @event.creator
    @organizer = @event.organizer
    unless current_user.admin or current_user == @creator or current_user == @organizer
      redirect_to :back, :alert => t("notice.access")
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @user = current_user
    @creator = @event.creator

    respond_to do |format|
      if @event.save
        if @event.creatorganizer
          @event.update_attribute(:organizer_id, current_user.id)
          format.html { redirect_to @event, notice: t("notice.event_created") }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { redirect_to edit_event_path(@event), notice: t("notice.event_created") }
          format.json { render :show, status: :created, location: @event }
        end
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: t("notice.event_updated") }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: t("notice.event_destroyed") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_name, :event_start_date, :event_end_date, :expected_pax, :last_pax, :post_code, :city, :country, :comment, :cuptwenty, :cuptwentyfive, :cupforty, :cupfifty, :cuplitre, :cupwine, :cupcava, :cupshot, :creator_id, :creatorganizer, :organizer_id, :party, :dinner, :last_consumption, :address, :delivery_date, :return_date, :contact, :phone, :is_complete, :bar, :beertap, :is_lln, :lln_year, :is_bep)
    end
end
