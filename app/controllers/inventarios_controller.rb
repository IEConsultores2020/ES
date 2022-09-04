class InventariosController < ApplicationController 
  layout false , except: [:index, :new, :show, :edit ]
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource :only => [:imprimir_datos, :imprimir_codbarras, :download]  


  def download
    ruta = File.join(Rails.root, "public","output")
    archivo = "errors_inventory" + current_user.id + ".txt"
    #send_file (File.join(ruta,archivo))
    send_file(File.join(ruta,archivo))
  end
  # GET /inventarios
  # GET /inventarios.json
  #def index
    #@inventarios = Inventario.all.order("fecha_ingreso ASC")
  #end

  # GET /inventarios/1
  # GET /inventarios/1.json
  def show
  end

  # GET /inventarios/new
  def new
    inventario =  params[:cantidad_integer].to_f * params[:valor_unidad].to_i
  end

  # GET /inventarios/1/edit
  def edit
  end

  # POST /inventarios
  # POST /inventarios.json
  def create
    @inventario.user_id = current_user.id
    respond_to do |format|
      if @inventario.save
        format.html { redirect_to @inventario, notice: 'Inventario was successfully created.' }
        format.json { render :show, status: :created, location: @inventario }
      else
        format.html { render :new }
        format.json { render json: @inventario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventarios/1
  # PATCH/PUT /inventarios/1.json
  def update
    respond_to do |format|
      if @inventario.update(inventario_params)
        format.html { redirect_to @inventario, notice: 'Inventario was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventario }
      else
        format.html { render :edit }
        format.json { render json: @inventario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventarios/1
  # DELETE /inventarios/1.json
  def destroy
    @inventario.destroy
    respond_to do |format|
      format.html { redirect_to inventarios_url, notice: 'Inventario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


   def index
     if format = "xls" then
        total_per_page = 9999999
     else
      total_per_page = 50
    end
     if params[:search] and params[:filter] and params[:datefilter] 
       @inventarios = Inventario.where(user_id: current_user.id).search(params[:search], params[:filter]).order("nombre ASC").paginate(page: params[:page], per_page: total_per_page)
       #@reportes = Inventario.search(params[:search], params[:filter], params[:datefilter]).order("nombre ASC")
     else
       @inventarios = Inventario.where(user_id: current_user.id).order("articulo_id ASC").paginate(page: params[:page], per_page: total_per_page)
     end
     respond_to do |format|
      format.html
      format.csv { send_data @inventarios.to_csv }
      format.xls 
     end
  end

  def imprimir_datos
    
    if params[:search] and params[:filter]  and params[:datefilter] 
       @inventarios = Inventario.where(user_id: current_user.id).search(params[:search],params[:filter]).order("nombre ASC")   
    else
       @inventarios = Inventario.where(user_id: current_user.id).order("articulo_id ASC")
    end    
     respond_to do |format|
      format.html
      format.pdf
      format.xls 
     end
  end  
  
  def imprimir_codbarras
    if params[:search] and params[:filter] and params[:datefilter] 
       @inventarios = Inventario.where(user_id: current_user.id).search(params[:filter], params[:datefilter]).order("nombre ASC")   
    else
       @inventarios = Inventario.where(user_id: current_user.id).order("articulo_id ASC")
    end
     respond_to do |format|
      format.html
      format.xls 
     end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventario
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventario_params
      params.require(:inventario).permit(:valor_venta, :moneda, :cantidad_integer,  :tienda_id, :articulo_id, :user_id)
    end
end
