class Post < ActiveRecord::Base
  belongs_to :user

  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :comments
  has_many :votes, :as => :voteable
  
  accepts_nested_attributes_for :categorizations, :allow_destroy => true

  validates :title, :presence => true
  validates :url, :presence => true

  def total_votes
    self.votes.where(value: true).size - self.votes.where(value: false).size
  end

  # def categories_attributes=(attributes)
  #   attributes.each do |attribute|
  #     self.categories << attribute
  #   end
  # end
end