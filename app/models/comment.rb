class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :body => presence: true,
    :length => { :minimum => 5, :message => 'Comment should be at least 5 letters long.'}

end
