class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  acts_as_votable

  validates :body, :presence => true,
    :length => { :minimum => 5, :maximum => 200}

end
