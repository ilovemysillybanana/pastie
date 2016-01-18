class Listing < ActiveRecord::Base
  searchkick

  belongs_to :user
  has_many :comments

  validates :name, :presence => true,
    :length => { :minimum => 1, :maximum => 25}
  validates :language, :allow_nil => true,
    :length => { :minimum => 1, :maximum => 25}
  validates :code, :presence => true,
    :length => { :minimum => 1, :maximum => 4000}

  before_create :randomize_id
  private
  def randomize_id
    begin
      self.id = SecureRandom.hex(15)
    end while Listing.where(id: self.id).exists?
  end
end
