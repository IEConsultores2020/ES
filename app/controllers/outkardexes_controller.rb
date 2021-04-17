class OutkardexesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /outkardexes
  # GET /outkardexes.json
  def index
    @outkardexes = Outkardexes.where(user_id: current_user.id).order("outfecha ASC")
  end

  # GET /outkardexes/1
  # GET /outkardexes/1.json
  def show
  end

  # GET /outkardexes/new
  def new
    @outkardex = Outkardex.new
  end

  # GET /outkardexes/1/edit
  def edit
  end

  # POST /outkardexes
  # POST /outkardexes.json
  def create
    @outkardex = Outkardex.new(outkardex_params)

    respond_to do |format|
      if @outkardex.save
        format.html { redirect_to @outkardex, notice: 'Outkardex was successfully created.' }
        format.json { render :show, status: :created, location: @outkardex }
      else
        format.html { render :new }
        format.json { render json: @outkardex.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outkardexes/1
  # PATCH/PUT /outkardexes/1.json
  def update
    respond_to do |format|
      if @outkardex.update(outkardex_params)
        format.html { redirect_to @outkardex, notice: 'Outkardex was successfully updated.' }
        format.json { render :show, status: :ok, location: @outkardex }
      else
        format.html { render :edit }
        format.json { render json: @outkardex.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outkardexes/1
  # DELETE /outkardexes/1.json
  def destroy
    @outkardex.destroy
    respond_to do |format|
      format.html { redirect_to outkardexes_url, notice: 'Outkardex was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outkardex
      @outkardex = Outkardex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outkardex_params
      params.require(:outkardex).permit(:outfecha, :numdocumento, :cantidad, :valorventa, :moneda)
    end
end
