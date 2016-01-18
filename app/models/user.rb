class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  has_many :listings, dependent: :destroy
  has_many :comments, dependent: :destroy

  attr_accessor :login

  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }

  before_create :randomize_id
  private
  def randomize_id
    begin
      self.id = SecureRandom.hex(15)
    end while Listing.where(id: self.id).exists?
  end
end
