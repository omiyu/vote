class User < ApplicationRecord
  has_secure_password
  has_many :votings, dependent: :destroy
  has_many :makes, dependent: :destroy


  MAN = 0
  WOMAN = 1
  OTHER = 2
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  #nameカラム
  validates :name, presence: true

  #emailカラム
  validates :email, presence: true,  format: { with: VALID_EMAIL_REGEX }

  #account_nameカラム
  validates :account_name, presence: true

  #ageカラム
  validates :age, presence: true

  #sexカラム
  validates :sex, presence: true

  #professionカラム
  #address_prefカラム


  private

  def self.devide_sex(sex)
    case sex
    when MAN then
      user_sex = "男"
    when WOMAN then
      user_sex = "女"
    when OTHER then
      user_sex = "その他"
    else
      user_sex = "未選択"
    end
    return user_sex
  end
end
