class Listing < ActiveRecord::Base
  searchkick

  belongs_to :user
  has_many :comments

  before_create :randomize_id
  private
  def randomize_id
    begin
      self.id = SecureRandom.hex(15)
    end while Listing.where(id: self.id).exists?
  end
end
