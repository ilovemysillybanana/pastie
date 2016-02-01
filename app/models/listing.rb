class Listing < ActiveRecord::Base
  searchkick

  belongs_to :user
  has_many :comments
  acts_as_votable

  validates :name, :presence => true,
    :length => { :minimum => 1, :maximum => 25}
  validates :language, :allow_nil => true,
    :length => { :minimum => 1, :maximum => 25}
  validates :code, :presence => true,
    :length => { :minimum => 1, :maximum => 4000}

  before_create :randomize_id

  LANGUAGES = [
    'Ruby',
    'Bash',
    'Python',
    'Java',
    'C++',
    'C',
    'JavaScript',
    'CSS',
    'PHP',
    'SQL',
    'C#',
    'XML',
    'Apache',
    'JSON',
    'CoffeeScript',
    'Perl',
    'HTML'
  ]
  private
  def randomize_id
    begin
      self.id = SecureRandom.hex(15)
    end while Listing.where(id: self.id).exists?
  end
end
