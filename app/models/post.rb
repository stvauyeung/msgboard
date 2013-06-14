class Post < ActiveRecord::Base
  belongs_to :user

  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :comments
  
  accepts_nested_attributes_for :categorizations, :allow_destroy => true

  validates :title, :presence => true
  validates :url, :presence => true

  # def categories_attributes=(attributes)
  #   attributes.each do |attribute|
  #     self.categories << attribute
  #   end
  # end
end