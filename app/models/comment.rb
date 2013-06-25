class Comment<ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  has_many :votes, :as => :voteable

  validates :content, :presence => true

  def total_votes
    self.votes.where(value: true).size - self.votes.where(value: false).size
  end
end