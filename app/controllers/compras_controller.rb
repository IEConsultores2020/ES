class ComprasController < ApplicationController
  layout false , except: [:index, :new, :show, :edit ]
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource :only => [:imprimir_datos, :imprimir_codbarras, :download] 

  def import
    Compra.import(params[:file], current_user.id)
    redirect_to compras_path, warning: "Facturas importadas. Verifique el registro de errores"
  end
  
  def download
    ruta = File.join(Rails.root, "public","output")
    archivo = "errors_compra" + current_user.id + ".txt"
    #send_file (File.join(ruta,archivo))
    send_file(File.join(ruta,archivo))
  end

  def imprimir_datos
    #Compra.where(:user_id => 30).sum('cantidad * valor_unidad')
    if params[:search] and params[:filter]  and params[:datefilter] 
       @compras = Compra.where(user_id: current_user.id).search(params[:search],params[:filter], params[:datefilter]).order("nombre ASC")   
    else
       @compras = Compra.where(user_id: current_user.id).order("articulo_id ASC")
    end    
     respond_to do |format|
      format.html
      format.pdf
      format.xls 
     end
  end  

  def imprimir_codbarras
    if params[:search] and params[:filter] and params[:datefilter] 
       @compras = Compra.where(user_id: current_user.id).search(params[:search],  params[:filter], params[:datefilter]).order("nombre ASC")   
    else
       @compras = Compra.where(user_id: current_user.id).order("articulo_id ASC")
    end
     respond_to do |format|
      format.html
      format.xls 
     end
  end  

  # GET /compras
  # GET /compras.json
   def index
     if params[:search] and params[:filter] and params[:datefilter] 
       @compras = Compra.where(user_id: current_user.id).search(params[:search], params[:filter], params[:datefilter]).order("fecha_ingreso desc, num_factura desc").paginate(page: params[:page], per_page: 9999999)   
       #@reportes = Compra.search(params[:search], params[:filter], params[:datefilter]).order("nombre ASC")
     else
       @compras = Compra.where(user_id: current_user.id).order("created_at desc, fecha_ingreso desc, num_factura desc").paginate(page: params[:page], per_page: 50)  
     end
     respond_to do |format|
      format.html
      format.csv { send_data @compras.to_csv }
      format.xls 
     end
  end

  # GET /compras/1
  # GET /compras/1.json
  def show
  end

  # GET /compras/new
  def new
    compra = params[:cantidad].to_f * params[:valor_unidad].to_f
  end

  # GET /compras/1/edit
  def edit
  end

  # POST /compras
  # POST /compras.json
  def create
    @compra.user_id = current_user.id
    tienda = Tienda.where(["nombre = ?", 'UNIQUE']).first
    @compra.tienda_id = tienda.id
    respond_to do |format|
      if @compra.save
        Compra.registrarin(@compra)
        format.html { redirect_to @compra, notice: 'Compra was successfully created.' }
        format.json { render :show, status: :created, location: @compra }
      else
        format.html { render :new }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /compras/1
  # PATCH/PUT /compras/1.json
  def update
    respond_to do |format|
      if @compra.update(compra_params)
        format.html { redirect_to @compra, notice: 'Compra was successfully updated.' }
        format.json { render :show, status: :ok, location: @compra }


      else
        format.html { render :edit }
        format.json { render json: @compra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compras/1
  # DELETE /compras/1.json
  def destroy
    @compra.destroy
    respond_to do |format|
      format.html { redirect_to compras_url, notice: 'Compra was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compra
      @compra = Compra.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compra_params
      params.require(:compra).permit(:num_factura, :fecha_ingreso, :cantidad, :valor_unidad, :moneda, :valor_total, :valor_venta, :tienda_id, :articulo_id, :user_id)
    end
end
