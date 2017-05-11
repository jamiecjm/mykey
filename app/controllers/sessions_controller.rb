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
        redirect_to root_path
      else
        flash.now.notice = status.failure_message
        render template: "sessions/new", status: :unauthorized
      end
    end
  end


end