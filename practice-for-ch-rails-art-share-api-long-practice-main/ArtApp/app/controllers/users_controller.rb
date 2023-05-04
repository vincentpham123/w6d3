class UsersController < ApplicationController

    def index  
        
        if params.has_key?(:name)
            name = "%#{params[:name]}%"
            @users = User.where("LOWER(name) LIKE ? ", name.downcase)
        else
            @users = User.all
        end
        render json: @users 

    end        

    def create
        user = User.new(user_params)
        # replace the `user_attributes_here` with the actual attribute keys
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show 
        @user = User.find(params[:id])
        render json: @user
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_url
    end

    def update
        #right now the user_params require that the info is nested in a user:
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_url(@user)
        else
            render json: @user.errors.full_messages, status: 422
        end
    end

    private
    def user_params
        params.require(:user).permit(:name)
    end

end
