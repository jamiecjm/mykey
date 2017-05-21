class UserMailer < ApplicationMailer
  def change_password(user)
    @user = user
    email = @user.email
    email = ENV["email_address"] if @user.email == "admin"
    mail(
      from: 'jamiecjm@gmail.com',
      to: email,
      subject: 'MyKeyOffice: Change Password'
    )
  end
end
