require 'active_support/deprecation'

class PasswordsController < Clearance::PasswordsController
  if respond_to?(:before_action)
    skip_before_action :require_login,
      only: [:create, :edit, :new, :update],
      raise: false
    skip_before_action :authorize,
      only: [:create, :edit, :new, :update],
      raise: false
    skip_before_action :login_required,
      only: [:create, :edit, :new, :update]
    skip_before_action :first_login,
      only: [:create, :edit, :new, :update]
    before_action :ensure_existing_user, only: [:edit, :update]
  else
    skip_before_filter :require_login,
      only: [:create, :edit, :new, :update],
      raise: false
    skip_before_filter :authorize,
      only: [:create, :edit, :new, :update],
      raise: false
    skip_before_filter :login_required,
      only: [:create, :edit, :new, :update]
    skip_before_filter :first_login,
      only: [:create, :edit, :new, :update]
    before_filter :ensure_existing_user, only: [:edit, :update]
  end

  def create
    if user = find_user_for_create
      user.forgot_password!
      UserMailer.change_password(user).deliver
      flash.now[:info] = "Please check your email for the instructions"
      render template: 'sessions/new'
    else
      flash.now[:info] = "Email not found"
      render template: 'passwords/new'
    end 
  end

  def edit
    @user = find_user_for_edit
    if params[:token]
      render template: 'passwords/edit'
    end
  end

  def new
    render template: 'passwords/new'
  end

  def update
    @user = find_user_for_update
    if @user.update_password password_reset_params
      sign_in @user
      redirect_to url_after_update
      session[:password_reset_token] = nil
    else
      flash_failure_after_update
      render template: 'passwords/edit'
    end
  end

  private

  def deliver_email(user)
    mail = ::ClearanceMailer.change_password(user)

    if mail.respond_to?(:deliver_later)
      mail.deliver_later
    else
      mail.deliver
    end
  end

  def password_reset_params
    if params.has_key? :user
      ActiveSupport::Deprecation.warn %{Since locales functionality was added, accessing params[:user] is no longer supported.}
      params[:user][:password]
    else
      params[:password_reset][:password]
    end
  end

  def find_user_by_id_and_confirmation_token
    user_param = Clearance.configuration.user_id_parameter
    token = session[:password_reset_token] || params[:token]
    Clearance.configuration.user_model.
      find_by_id_and_confirmation_token params[user_param], token.to_s
  end

  def find_user_for_create
    Clearance.configuration.user_model.
      find_by_normalized_email params[:password][:email]
  end

  def find_user_for_edit
    find_user_by_id_and_confirmation_token
  end

  def find_user_for_update
    find_user_by_id_and_confirmation_token
  end

  def ensure_existing_user
    user=User.find(params[:user_id])
    unless user.confirmation_token == params[:token]
      flash_failure_when_forbidden
      render template: "passwords/new"
    end
  end

  def flash_failure_when_forbidden
    flash.now[:danger] = translate(:forbidden,
      scope: [:clearance, :controllers, :passwords],
      default: t('flashes.failure_when_forbidden'))
  end

  def flash_failure_after_update
    flash.now[:danger] = translate(:blank_password,
      scope: [:clearance, :controllers, :passwords],
      default: t('flashes.failure_after_update'))
  end

  def url_after_create
    sign_in_url
  end

  def url_after_update
    Clearance.configuration.redirect_url
  end
end