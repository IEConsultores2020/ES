class SaleheadersController < ApplicationController
  before_action :set_saleheader, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource 


  # GET /saleheaders
  # GET /saleheaders.json
  def index
    @saleheaders = Saleheader.all
  end

  # GET /saleheaders/1
  # GET /saleheaders/1.json
  def show
  end

  # GET /saleheaders/new
  def new
    @saleheader = Saleheader.new
    @saleheader.saledetails.build
  end  

  # GET /saleheaders/1/edit
  def edit
    @saleheader.saledetails.build
  end

  # POST /saleheaders
  # POST /saleheaders.json
  def show_saledetails
    @saleheader = Saleheader.find(params[:id])
  end 

  def create
    @saleheader = Saleheader.new(saleheader_params)

    respond_to do |format|
      if @saleheader.save
        format.html { redirect_to @saleheader, notice: 'Saleheader was successfully created.' }
        format.json { render :show, status: :created, location: @saleheader }
      else
        format.html { render :new }
        format.json { render json: @saleheader.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saleheaders/1
  # PATCH/PUT /saleheaders/1.json
  def update
    respond_to do |format|
      if @saleheader.update(saleheader_params)
        format.html { redirect_to @saleheader, notice: 'Saleheader was successfully updated.' }
        format.json { render :show, status: :ok, location: @saleheader }
      else
        format.html { render :edit }
        format.json { render json: @saleheader.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saleheaders/1
  # DELETE /saleheaders/1.json
  def destroy
    @saleheader.destroy
    respond_to do |format|
      format.html { redirect_to saleheaders_url, notice: 'Saleheader was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saleheader
      @saleheader = Saleheader.find(params[:id])
      
    end
    def set_saledetail
      @saledetail = Saledetail.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def saleheader_params
      params.require(:saleheader).permit(:typeID, :citizenship, :allname, :email, :expeditionDate, :grossvalue, :tax, :netvalue, :state, :num_id, :invoice_num, saledetails_attributes: [:id, :articulo_id, :line, :value, :quantity, :total, :discount_percent, :user_id])
    end
end
