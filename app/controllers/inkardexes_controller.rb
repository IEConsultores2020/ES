class InkardexesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /inkardexes
  # GET /inkardexes.json
  def index
    @inkardexes = Inkardex.where(user_id: current_user.id).order("created_at DESC")
  end

  # GET /inkardexes/1
  # GET /inkardexes/1.json
  def show
  end

  # GET /inkardexes/new
  def new
    @inkardex = Inkardex.new
  end

  def articulo_inkardex
    @articulo = Articulo.find(params[:id])
    @inkardex = Inkardex.new
  end

  # GET /inkardexes/1/edit
  def edit
  end

  # POST /inkardexes
  # POST /inkardexes.json
  def create
    @inkardex = Inkardex.new(inkardex_params)
    @inkardex.user_id = current_user.id
    @articulo = @inkardex.articulo
    respond_to do |format|
      if @inkardex.save
        format.html { redirect_to @inkardex, notice: 'Inkardex was successfully created.' }
        format.json { render :show, status: :created, location: @inkardex }
      else
        format.html { render :new }
        format.json { render json: @inkardex.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inkardexes/1
  # PATCH/PUT /inkardexes/1.json
  def update
    respond_to do |format|
      if @inkardex.update(inkardex_params)
        format.html { redirect_to @inkardex, notice: 'Inkardex was successfully updated.' }
        format.json { render :show, status: :ok, location: @inkardex }
      else
        format.html { render :edit }
        format.json { render json: @inkardex.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inkardexes/1
  # DELETE /inkardexes/1.json
  def destroy
    @inkardex.destroy
    respond_to do |format|
      format.html { redirect_to inkardexes_url, notice: 'Inkardex was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inkardex
      @inkardex = Inkardex.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inkardex_params
      params.require(:inkardex).permit(:infecha, :numdocumento, :cantidad, :existencia, :valorcompra, :moneda)
    end
end
