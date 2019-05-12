class Category < ApplicationRecord
  has_one :make, foreign_key: 'category_id', dependent: :destroy
end
