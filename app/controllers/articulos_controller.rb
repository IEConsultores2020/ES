class ArticulosController < ApplicationController
  before_action :authenticate_user!   #202106
  before_action :set_articulo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! 
  load_and_authorize_resource  
  skip_authorize_resource :only => [:show_inkardexes] 

  def import
    Articulo.import(params[:file],current_user.id)
    redirect_to articulos_path, notice: "Articulos importados correctamente."
  end

  # GET /articulos
  # GET /articulos.json
  #def index
  #@articulos = Articulo.all.order("nombre ASC").paginate(page: params[:page], per_page: 50)
  #end
  def reporte
    @articulos = Articulo.where(user_id: current_user.id).order("descripcion ASC")
  end
  
  def show_inkardexes
    @articulo = Articulo.find(params[:id]) 
    @inkardexes = @Articulo.find(params[:id]).inkardexes.order("created_at DESC")
  end  
  
  def index
    if params[:search]
      @articulos = Articulo.where(user_id: current_user.id).search(params[:search]).paginate(page: params[:page], per_page: 50)
    else
      if params[:search_componente]
        @articulos = Articulo.where(user_id: current_user.id).filter(params[:search_componente]).paginate(page: params[:page], per_page: 50)
      else
        @articulos = Articulo.where(user_id: current_user.id).order("descripcion ASC")
      end 
    end
    respond_to do |format|
      
      format.html
      format.csv { send_data @articulos.to_csv }
      format.xls 
    end
  end


  

  # GET /articulos/1
  # GET /articulos/1.json
  def show
    
  end

  def show_inkardexes
    @articulo = Articulo.find(params[:id])
    @inkardexes = Articulo.find(params[:id])
  end 

  # GET /articulos/new
  def new
    
  end

  # GET /articulos/1/edit
  def edit
    @articulo.inkardexes.build
  end
  


  # POST /articulos
  # POST /articulos.json
  def create   
    @articulo.user_id = current_user.id
    respond_to do |format|
      if @articulo.save
        format.html { redirect_to @articulo, notice: 'Articulo was successfully created.' }
        format.json { render :show, status: :created, location: @articulo }
      else
        format.html { render :new }
        format.json { render json: @articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articulos/1
  # PATCH/PUT /articulos/1.json
  def update
    respond_to do |format|
      if @articulo.update(articulo_params)
        format.html { redirect_to @articulo, notice: 'Articulo was successfully updated.' }
        format.json { render :show, status: :ok, location: @articulo }
      else
        format.html { render :edit }
        format.json { render json: @articulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articulos/1
  # DELETE /articulos/1.json
  def destroy
    @articulo.destroy
    respond_to do |format|
      format.html { redirect_to articulos_url, notice: 'Articulo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_articulo
      @articulo = Articulo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def articulo_params
      params.require(:articulo).permit(:nombre, :descripcion, :foto, :barcode, :medida_id, :componente_id, :modelo_id, :user_id, :ptax)
    end

end
