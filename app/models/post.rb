class Post < ApplicationRecord
  validates :title,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }
  validates :body, presence: true
end
