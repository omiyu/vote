class Voting < ApplicationRecord
  belongs_to :make ,class_name: 'Make',foreign_key: 'make_id'
  belongs_to :user ,class_name: 'User',foreign_key: 'user_id'
end
