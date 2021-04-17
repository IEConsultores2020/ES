class ConteosController < ApplicationController
  layout false , except: [:index, :new, :show, :edit ]
  before_filter :authenticate_user!
  load_and_authorize_resource  
  skip_authorize_resource :only => [:download]  

  def import
    Conteo.import(params[:file], current_user.id)
    redirect_to conteos_url, notice: "Importados importados. Verifique el registro de errores"
  end
  
  def download
    ruta = File.join(Rails.root, "public","output")
    archivo = "errors_conteo" + current_user.id + ".txt"
    #send_file (File.join(ruta,archivo))
    send_file(File.join(ruta,archivo))
  end


  # GET /conteos/1
  # GET /conteos/1.json
  def show
  end

  # GET /conteos/new
  def new
    @conteo = Conteo.new
  end

  # GET /conteos/1/edit
  def edit
  end

  # POST /conteos
  # POST /conteos.json
  def create
    @conteo = Conteo.new(conteo_params)

    respond_to do |format|
      if @conteo.save
        format.html { redirect_to @conteo, notice: 'Conteo was successfully created.' }
        format.json { render :show, status: :created, location: @conteo }
      else
        format.html { render :new }
        format.json { render json: @conteo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conteos/1
  # PATCH/PUT /conteos/1.json
  def update
    respond_to do |format|
      if @conteo.update(conteo_params)
        format.html { redirect_to @conteo, notice: 'Conteo was successfully updated.' }
        format.json { render :show, status: :ok, location: @conteo }
      else
        format.html { render :edit }
        format.json { render json: @conteo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conteos/1
  # DELETE /conteos/1.json
  def destroy
    @conteo.destroy
    respond_to do |format|
      format.html { redirect_to conteos_url, notice: 'Conteo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    # GET /conteos
  # GET /conteos.json
  def index
    #@conteos = Conteo.all

    if params[:datefilter] 
      @conteos = Conteo.where(user_id: current_user.id).search(params[:datefilter]).paginate(page: params[:page], per_page: 50)   
    else
      #@conteos = Conteo.all
      @conteos = Conteo.where(user_id: current_user.id).order("created_at desc").paginate(page: params[:page], per_page: 50)
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conteo
      @conteo = Conteo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conteo_params
      params.require(:conteo).permit(:cantidad, :codbarras, :inventario_id)
    end
end
