class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			flash[:success] = "Welcome to Private Events!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def index
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
	end

	def update
	end

	def delete
	end

	def destroy
	end

	private

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end
end
