class Listing < ActiveRecord::Base
  searchkick

  belongs_to :user
  has_many :comments

  before_create :randomize_id
  private
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000)
    end while Listing.where(id: self.id).exists?
  end
end
