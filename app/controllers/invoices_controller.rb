class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
    @confirmedoffers = Offer.where(:client_confirmation => true)
    @confirmed = @confirmedoffers.where(:admin_confirmation => true)
    @new_invoice = Invoice.new
    @new_offer = Offer.new
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @offer = @invoice.offer
    @prices = Price.all
    @regular_prices = @prices.where(:regular => true)

    @offer_boxes = OfferBox.all
    @thisofferboxes = @offer_boxes.where(:offer_id => @offer.id)
    @boxdetails = @invoice.boxdetails
    @articles = @invoice.articles

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "#{@invoice.pdf_name}", :layout => 'layouts/pdf.html.erb', :template => 'invoices/show.html.erb'
      end
    end

  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save

        if @invoice.doc_invoice
          @invoice.update_attributes(:doc_number => @invoice.invoice_number, :total_htva => @invoice.total_htva, :total_tva => @invoice.total_tva, :total_tvac => @invoice.total_tvac)
        elsif @invoice.doc_credit
          @invoice.update_attributes(:doc_number => @invoice.credit_number)
        end
          
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:doc_number, :offer_id, :client_id, :doc_invoice, :doc_credit, :total_htva, :total_tva, :total_tvac, :confirmation, :confirmation_paid, :after_event, :after_event_paid)
    end
end
