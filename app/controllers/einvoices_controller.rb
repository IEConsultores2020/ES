class EinvoicesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_einvoice, only: [:show, :edit, :update, :destroy]
  skip_authorize_resource 
 
  # GET /einvoices
  # GET /einvoices.json
  def index
    @einvoices = Einvoice.all
  end

  # GET /einvoices/1
  # GET /einvoices/1.json
  def show
  end

  # GET /einvoices/new
  def new
    @einvoice = Einvoice.new
  end

  #GET /einvoices/1/edit
  def edit

  end

  # POST /einvoices
  # POST /einvoices.json
  
  def create
    @einvoice.user_id = current_user.id
    respond_to do |format|
      if @einvoice.save
        
        format.html { redirect_to @einvoice, notice: 'Einvoice was successfully created.' }
        format.json { render :show, status: :created, location: @einvoice }
      else
        format.html { render :new }
        format.json { render json: @einvoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /einvoices/1
  # PATCH/PUT /einvoices/1.json
  def update
    respond_to do |format|
      if @einvoice.update(einvoice_params)
        format.html { redirect_to @einvoice, notice: 'Einvoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @einvoice }
      else
        format.html { render :edit }
        format.json { render json: @einvoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /einvoices/1
  # DELETE /einvoices/1.json
  def destroy
    @einvoice.destroy
    respond_to do |format|
      format.html { redirect_to einvoices_url, notice: 'Einvoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_einvoice
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def einvoice_params
      params.require(:einvoice).permit(:organizationtype, :name, :identification,  :autorization, :init_date_allow, :end_date_allow, :invoice_code, :prefix, :from, :to, :currency, :ptax2)
    end
end
