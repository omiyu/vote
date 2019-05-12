class Make < ApplicationRecord
  has_many :votings, dependent: :destroy
  has_one :make_summary, dependent: :destroy
  belongs_to :user ,class_name: 'User', foreign_key: 'user_id'
  belongs_to :category, class_name: 'Category', foreign_key: 'category_id'

#questionカラム
  validates :question, presence: true
#category_idカラム
  validates :category_id, presence: true
#answer_1~10カラム
  validates :answer_1, presence: true
  validates :answer_2, presence: true
  validates :answer_3, presence: true
  validates :answer_4, presence: true
  validates :answer_5, presence: true
  validates :answer_6, presence: true
  validates :answer_7, presence: true
  validates :answer_8, presence: true
  validates :answer_9, presence: true
  validates :answer_10, presence: true

end
