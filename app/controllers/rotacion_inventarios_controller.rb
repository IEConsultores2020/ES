class RotacionInventariosController < ApplicationController
	

	def index
    
    if params[:arti] and params[:fecha_inicio]  and params[:fecha_final] 
      @articulo = Articulo.where(user_id: current_user.id).search2(params[:arti],
        params[:fecha_inicio], 
        params[:fecha_final]).order("nombre ASC") 

       
    else
       @compras = Compra.where(user_id: current_user.id).order("articulo_id ASC")
    end    
     respond_to do |format|
      format.html
      format.pdf
      format.xls 
     end
  end  



end
