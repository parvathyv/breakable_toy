class Article < ActiveRecord::Base

has_many :reviews
belongs_to :user
belongs_to :category

validates :name, presence: true
validates :name, length: {
  minimum: 5,
  maximum: 50
}

validates :url, presence: true
validates :url, :format => URI::regexp(%w(http https))
validates :url, uniqueness: true

validates :description, presence: true
validates :description, length: { maximum: 500 }
end
