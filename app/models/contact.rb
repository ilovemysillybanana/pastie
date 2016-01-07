class Contact < ActiveRecord::Base
  attr_accessor :name, :email, :phone, :subject, :content

  # Validations
  validates :name, :presence => true,
    :length => { :minimum => 1, :maximum => 25, :message => 'Name should between 1 and 40 characters'}

  validates :email, :presence => true,
    :format => { :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ , :message => 'Not a valid email'}

  validates :phone, allow_nil: true,
          length: { :minimum => 0, :maximum => 12, :message => 'Please double check phone number, include country and area code if necessary'}

  validates :subject, :presence => true,
    :length => { :minimum => 5, :maximum => 150, :message => 'should be between 5 and 150 characters'}

  validates :content, :presence => true,
    :length => { :maximum => 400, :message => 'Message should contain less than 400 characters.' }
end
