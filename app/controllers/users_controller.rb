class UsersController < Clearance::UsersController
	if respond_to?(:before_action)
	    skip_before_action :require_login, only: [:create, :new], raise: false
	    skip_before_action :authorize, only: [:create, :new], raise: false
	  else
	    skip_before_filter :require_login, only: [:create, :new], raise: false
	    skip_before_filter :authorize, only: [:create, :new], raise: false
	  end

	# before_filter :admin, only: :new

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_signup_params)
		@user.save
		redirect_to "/"
	end

	def index
		@users = User.all
	end

	def show
		@user = current_user 
	end

	def edit
	end

	def update
		current_user.update(user_update_params)
		redirect_to user_path(current_user)
	end

	def first_login
	end

	def first_update
		current_user.update(first_update_params)
		redirect_to "/"
	end

	def change_password
		@user = current_user
	end

	def update_password
		user = User.find(params[:user_id])
		if user = User.authenticate(user.email,params[:original_password])
			user.update(password: params[:password],password_confirmation: params[:password_confirmation])
		else
		byebug
		end
	end

	private

	def user_signup_params
	    params.require(:user).permit(:title,:name,:email,:password,:mobile_no)
	end

	def user_update_params
	    params.require(:user).permit(:title,:name,:email,:mobile_no,:birthday,:address)
	end

	def redirect_signed_in_users
	end

	def first_update_params
		params.permit(:title,:name,:email,:mobile_no,:birthday,:address,:password,:password_confirmation)
	end
end