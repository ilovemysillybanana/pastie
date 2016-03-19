class User < ActiveRecord::Base
  acts_as_votable
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  has_many :listings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :identities

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
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
