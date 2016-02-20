class ContactController < ApplicationController
  respond_to :html, :js

  def index
    @contact = Contact.new
  end

  def contactus
    @contact = Contact.new(contact_params)

    @contact.valid?
    if verify_recaptcha(:model => @contact, :Message => "Please enter the correct captcha.")
      flash[:success] = "Message Sent!"
      UserNotifier.send_contact_email(@contact).deliver_now
      redirect_to root_path
    else
      flash[:error] = @contact.errors.messages

      if @contact.errors.any?
        @contact.errors.full_messages.each do |msg|
          flash[:error] = "#{msg}\n"
        end
      end
      redirect_to contact_path
    end


  end

  private
  def contact_params
    params.permit(:name, :phone, :subject, :email, :content)
  end

end
