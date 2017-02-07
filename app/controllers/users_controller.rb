class UsersController < ApplicationController
	before_action :logged_in, only: [:show, :index, :edit, :destroy]
	before_action :correct_user, only: [:edit]

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
		@users = User.all.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def logged_in
		unless logged_in?
			store_location
			flash[:danger] = "Please log in"
			redirect_to login_url
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to current_user unless current_user?(@user)
	end

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end
end
