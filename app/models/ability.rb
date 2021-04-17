class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      # user ||= User.new # guest user (not logged in)
      #user asigned for Input (Entradas) and Output (Salidas). IEOS
   

      #Users asigned for Diary Register On Terrain (DROT)      
       if user.admin?
          can :manage, :all
          can :import, User
       elsif user.seller?

          can :read, User
          can :read, Role
          can :read, Ciudad
          can :read, Articulo
          can :read, Modelo
          can :read, Componente
          can :read, Medida
          can :read, Inventario
          can :read, Compra
          can :read, Conteo
          can :read, Inkardex
          can :read, Einvoice
          can :read, Saleheader
          can :read, Saledetail

          can :update, Articulo #do |articulo|
            #Articulo.try(:user) == user
          #end
          can :update, Modelo
          can :update, Componente
          can :update, Medida
          can :update, Inventario
          can :update, Compra          
          can :update, Conteo
          can :update, Inkardex
          can :update, Einvoice
          can :update, Saleheader
          can :update, Saledetail          

          can :create, Articulo
          can :create, Modelo
          can :create, Componente
          can :create, Medida   
          can :create, Inventario 
          can :create, Compra          
          can :create, Tienda 
          can :create, Conteo
          can :create, Inkardex
          can :create, Einvoice
          can :create, Saleheader
          can :create, Saledetail

          can :destroy, Inventario
          can :destroy, Compra
          can :destroy, Conteo
          can :destroy, Articulo #do |articulo|
           # Articulo.try(:user) == user
          #end
          can :destroy, Inkardex
          can :destroy, Einvoice
          can :destroy, Saleheader
          can :destroy, Saledetail

          can :import, [Articulo, Inventario, Conteo, Compra]

        elsif user.regular?
          can :read, User
          can :read, Role
          can :read, Ciudad
          can :read, Region
          can :read, Articulo

          can :read, Planvisitum
          can :read, Visitum
          can :read, Ventum
        end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
