class UsersController < ApplicationController

    # skip_before_action :verify_authenticity_token
    # skip_before_action :verify_authenticity_token
    # skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, except: :create

	def index
      @users = User.all
      render json: @users ,status: :ok
	end

	def show
      render json: @user, status: :ok
    end

    def create
    	
    	@user = User.new(user_params)

    	if @user.save
    		render json: @user , status: :created

    	else
    		render json: {errors: @user.errors.full_messages},
    		status: :unprocessable_entity
    	end
    end


     def update
      if  @user&.update(user_params)
          render json: {notice: "user has been updated successfully"}
      else
          render json: {notice: "user is not present"},
          status: :unprocessable_entity   
      end
    end
     

    # def update
    # 	unless  @user.update(user_params)
    # 		render json: {errors: @user.errors.full_messages},
    # 		status: :unprocessable_entity
    		
    # 	end
    # end


def destroy
      # @product = Product.find_by(id: params[:id])
    
        
      if @product&.destroy
      # redirect_to root_path, status: :see_other

        render json: {notice: "product has been destroy successfully"}
      else
        render json: { message: "Couldn't find Product id = #{params[:id]}"}
     end
   end

    # def destroy
    # 	@user.destroy
    # end


    private

    def user_params
        params.permit(:name,:username, :email, :password)

    end

    def set_user
    	@user = User.find_by(id: params[:id])
    end
end
