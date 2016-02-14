class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
    @offers = Offer.all.order('id ASC')
    @new_invoice = Invoice.new
    @new_offer = Offer.new
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @offer = @invoice.offer
    @prices = Price.all
    @regular_prices = @prices.where(:regular => true)
    @boxes = Box.all.order('box_name ASC')
    @articles = Article.all.order('article_name ASC')

    @offer_boxes = OfferBox.all
    @thisofferboxes = @offer_boxes.where(:offer_id => @offer.id)
    @boxdetails = @invoice.boxdetails

    @circles = User.is_lln.is_circle.order('lln_id ASC')

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
          if @invoice.confirmation
            @invoice.update_attributes(:doc_number => @invoice.invoice_number, :total_htva => @invoice.total_htva_deposit, :total_tva => @invoice.total_tva_deposit, :total_tvac => @invoice.total_tvac_deposit)
          elsif @invoice.after_event
            @invoice.update_attributes(:doc_number => @invoice.invoice_number, :total_htva => @invoice.total_htva_final, :total_tva => @invoice.total_tva_final, :total_tvac => @invoice.total_tvac_final)
          end
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
