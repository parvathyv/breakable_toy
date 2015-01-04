class Review < ActiveRecord::Base
belongs_to :article
belongs_to :user

validates :body, length: { minimum: 25 }, presence: true
validates :article, :user, presence: true
end
