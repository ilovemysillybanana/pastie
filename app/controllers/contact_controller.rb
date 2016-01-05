class ContactController < ApplicationController

  def index
    @contact = Contact.new
  end

  def contactus
    @contact = Contact.new(contact_params)
    if @contact.valid?
      flash[:success] = "Message Sent!"
      #this is where the mailer will go

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
