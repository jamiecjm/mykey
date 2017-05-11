class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  if respond_to?(:before_action)
      before_action :login_required
      before_action :first_login
    else
      before_action :login_required
      before_action :first_login
    end

  def login_required
    if current_user.blank?
      redirect_to('/sign_in') unless request.fullpath == "/sign_in"
    end
  end

  def admin
    if signed_in?
      if current_user.email != "admin"
        redirect_to "/" unless request.fullpath == "/"
      end
    end
  end

  def first_login
    if signed_in?
      if current_user.birthday == nil
        redirect_to "/first_login" unless request.fullpath == "/first_login" || current_user.email == "admin" || request.fullpath == "/sign_out"
      end
    end
  end
end
