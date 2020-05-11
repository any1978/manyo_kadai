class User < ApplicationRecord

  before_destroy :do_not_destroy_last_admin

  # validation
  validates :user_name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
  before_validation { email.downcase! }
  validates :password, presence: true, length: { minimum: 6 }, on: :new

  has_secure_password
  has_many :tasks, dependent: :destroy

  private

  def do_not_destroy_last_admin
    if self.admin? && User.where(admin: :true).count == 1
      throw :abort
    end
  end

  enum priority: %i[High Middle Low]
end
