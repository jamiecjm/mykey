class UsersController < Clearance::UsersController
	if respond_to?(:before_action)
		before_action :admin, only: [:new,:create,:index]
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
		if @user.save
			flash[:success] = "Client profile created"
			redirect_to "/"
		else
			flash.now[:danger] = @user.errors.full_messages.first
			render "new"
		end
	end

	def index
		@users = User.all
	end

	def show
		@user = current_user 
	end

	def edit
		@user = User.find(params[:id])
		if current_user != @user && current_user.email != "admin"
			@user = current_user
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_update_params)
			flash[:success] = "Profile updated"
			redirect_to user_path(@user)
		else
			flash.now[:danger] = @user.errors.full_messages.first
			render "edit"
		end
	end

	def first_login
	end

	def first_update
		if User.authenticate(current_user.email,params[:original_password])
			if current_user.update(first_update_params)
				redirect_to "/"
			else
				flash.now[:danger] = current_user.errors.full_messages.first
				render 'first_login'
			end
		else
			flash.now[:danger] = "Incorrect password"
			render 'first_login'
		end
	end

	def change_password
		@user = current_user
	end

	def update_password
		user = User.find(params[:user_id])
		if user = User.authenticate(user.email,params[:original_password])
			if user.update(password: params[:password],password_confirmation: params[:password_confirmation])
				flash[:success] = "Password updated"
				redirect_to user_path(user)
			elsif user.email == "admin"
				user.attributes = {password: params[:password],password_confirmation: params[:password_confirmation]}
				user.save(validate: false)
				flash[:success] = "Profile updated"
				redirect_to user_path(user)
			else
				flash.now[:danger] = user.errors.full_messages.first
				render "change_password"
			end
		else
			flash.now[:danger] = "Incorrect password"
			render "change_password"
		end
	end

	def destroy
		user = User.find(params[:id])
		user.destroy
		redirect_to "/users"
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