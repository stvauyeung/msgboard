class Post < ActiveRecord::Base
  belongs_to :user

  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :comments
  has_many :votes, :as => :voteable
  
  accepts_nested_attributes_for :categorizations, :allow_destroy => true

  validates :title, :presence => true
  validates :url, :presence => true
  after_validation :generate_slug

  def total_votes
    self.votes.where(value: true).size - self.votes.where(value: false).size
  end

  def generate_slug
    # strip and downcase title
    ret = self.title.strip.downcase

    # remove apostraphes, commas and periods
    ret.gsub! /['`,.]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with dash
     ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  

    #convert double dash to single
    ret.gsub! /-+/,"-"

    #strip off leading/trailing dash
    ret.gsub! /\A[-\.]+|[-\.]+\z/,""

    self.slug = ret
  end

  def to_param
    self.slug
  end
end