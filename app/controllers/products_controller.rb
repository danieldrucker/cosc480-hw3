class ProductsController < ApplicationController
    def index
        if params.has_key?(:age) and params.has_key?(:age) and params.has_key?(:sort)
            @products = Product.all.filter_by(params[:age], params[:price])
            @products = @products.sorted_by(params[:sort])
            return @products
        else
            if params.has_key?(:age)
                age = params[:age]
                session[:age] = params[:age]
            elsif session.has_key?(:age)
                age = session[:age]
            else
                age = ""
            end

            if params.has_key?(:price)
                price = params[:price]
                session[:price] = params[:price]
            elsif session.has_key?(:price)
                price = session[:price]
            else
                price = ""
            end

            if params.has_key?(:sort)
                sort = params[:sort]
                session[:sort] = params[:sort]
            elsif session.has_key?(:sort)
                sort = session[:sort]
            else
                sort = "name"
            end
        end
        flash.keep
        redirect_to products_path :age => age, :price => price, :sort => sort
    end
            

    def show
        id = params[:id]
        @product = Product.find(id)
    end
 
    def new 

    end

    def edit
        id = params[:id]
        @product = Product.find(id)

    end

    def create
        p = Product.new(create_update_params) # "mass assignment" of attributes!
        if p.save
            flash[:notice] = "New product #{p.name} created successfully"
            redirect_to products_path :age => '', :price => '', :sort => ''
        else
            flash[:alert] = "Product couldn't be created"
            redirect_to new_product_path
        end
    end
 
    def update
        @product = Product.find params[:id]
        #@product.assign_attributes(create_update_params)
        if (@product.update(create_update_params))
            flash[:notice] = "#{@product.name} was successfully updated."
            redirect_to product_path(@product) 
        else
            flash[:alert] = "Product could not be updated"
            redirect_to edit_product_path(@product)
        end
    end

    def create_update_params
        params.require(:product).permit(:name, :description, :price, :minimum_age_appropriate, :maximum_age_appropriate, :image)
    end

end
