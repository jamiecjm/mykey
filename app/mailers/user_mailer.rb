class UserMailer < ApplicationMailer
  def change_password(user)
    @user = user
    email = @user.email
    email = "jamiecjm@gmail.com" if @user.email == "admin"
    mail(
      from: Clearance.configuration.mailer_sender,
      to: email,
      subject: I18n.t(
        :change_password,
        scope: [:clearance, :models, :clearance_mailer]
      ),
    )
  end
end
