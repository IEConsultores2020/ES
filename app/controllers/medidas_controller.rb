class MedidasController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /unidad_medidas
  # GET /unidad_medidas.json
  def index
    @medidas = Medida.where(user_id: current_user.id).order("nombre ASC")
  end



  # GET /unidad_medidas/1
  # GET /unidad_medidas/1.json
  def show
  end

  # GET /unidad_medidas/new
  def new
  end

  # GET /unidad_medidas/1/edit
  def edit
  end

  # POST /unidad_medidas
  # POST /unidad_medidas.json
  def create
    @medida.user_id = current_user.id
    respond_to do |format|
      if @medida.save
        format.html { redirect_to @medida, notice: 'Unidad medida was successfully created.' }
        format.json { render :show, status: :created, location: @medida }
      else
        format.html { render :new }
        format.json { render json: @medida.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unidad_medidas/1
  # PATCH/PUT /unidad_medidas/1.json
  def update
    respond_to do |format|
      if @medida.update(medida_params)
        format.html { redirect_to @medida, notice: 'Unidad medida was successfully updated.' }
        format.json { render :show, status: :ok, location: @medida }
      else
        format.html { render :edit }
        format.json { render json: @medida.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unidad_medidas/1
  # DELETE /unidad_medidas/1.json
  def destroy
    @medida.destroy
    respond_to do |format|
      format.html { redirect_to medidas_url, notice: 'Unidad medida was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medida
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medida_params
      params.require(:medida).permit(:codigo, :nombre, :descripcion, :user_id)
    end
end
