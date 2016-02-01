class UserNotifier < ApplicationMailer

  def send_contact_email(contact)
    @contact_info = contact
    mail(
      to: @contact_info.email,
      subject: @contact_info.subject
    )

  end

  def comment_reply_email(comment)
    @comment_info = comment
    mail(
      to: @comment_info.listing.user.email,
      subject: "A user replied to: #{@comment_info.listing.name}"
    )
  end

end
