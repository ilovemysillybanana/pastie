class UserNotifier < ApplicationMailer

  def send_contact_email(contact)
    @contact_info = contact
    mail(
      to: @contact_info.email,
      subject: @contact_info.subject
    )

  end

end
