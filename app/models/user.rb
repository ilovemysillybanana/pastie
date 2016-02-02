class User < ActiveRecord::Base
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:login]
  has_many :listings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :identities

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
  end

  
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
