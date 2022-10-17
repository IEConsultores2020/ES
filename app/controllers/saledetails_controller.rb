class SaledetailsController < ApplicationController
  layout false , except: [:index, :new, :show, :edit ]
  before_action :set_saledetail, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource

  # GET /saledetails
  # GET /saledetails.json
  def index
    @saledetails = Saledetail.all
  end

  # GET /saledetails/1
  # GET /saledetails/1.json
  def show
  end

  # GET /saledetails/new
  def new
    @saledetail = Saledetail.new
    compra = params[:value].to_f * params[:quantity].to_f
  end

  # GET /saledetails/1/edit
  def edit
  end
   def saleheader_inkardex
    @Saleheader = Saleheader.find(params[:id])
    @saledetail = Saledetail.new
  end

  # POST /saledetails
  # POST /saledetails.json
  def create
    @saledetail = Saledetail.new(saledetail_params)
    
    respond_to do |format|
      if @saledetail.save
        format.html { redirect_to @saledetail, notice: 'Saledetail was successfully created.' }
        format.json { render :show, status: :created, location: @saledetail }
      else
        format.html { render :new }
        format.json { render json: @saledetail.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /saledetails/1
  # PATCH/PUT /saledetails/1.json
  def update
    respond_to do |format|
      if @saledetail.update(saledetail_params)
        format.html { redirect_to @saledetail, notice: 'Saledetail was successfully updated.' }
        format.json { render :show, status: :ok, location: @saledetail }
      else
        format.html { render :edit }
        format.json { render json: @saledetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saledetails/1
  # DELETE /saledetails/1.json
  def destroy
    @saledetail.destroy
    respond_to do |format|
      format.html { redirect_to saledetails_url, notice: 'Saledetail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saledetail
      @saledetail = Saledetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def saledetail_params
    
      params.require(:saledetail).permit(:articulo_id, :line, :quantity, :total, :discountpercent)
    end
end
