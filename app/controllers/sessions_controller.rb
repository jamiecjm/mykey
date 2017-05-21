class SessionsController < Clearance::SessionsController
  if respond_to?(:before_action)
      skip_before_action :login_required, only: [:create, :new], raise: false
      skip_before_action :first_login, only: [:create, :new], raise: false
    else
      skip_before_filter :login_required, only: [:create, :new], raise: false
      skip_before_filter :first_login, only: [:create, :new], raise: false
    end

  def create
    @user = authenticate(params)
    sign_in(@user) do |status|
      if status.success?
        if current_user.email == "admin"
          redirect_to root_path
        else
          redirect_to "/user_projects"
        end
      else
        flash.now[:danger] = "Incorrect Email or Password"
        render template: "sessions/new", status: :unauthorized
      end
    end
  end


end