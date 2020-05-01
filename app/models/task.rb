class Task < ApplicationRecord
  # Task.all.order(created_at: :desc)
  # Task.order(created_at: :desc)
  # Task.order(:updated_at,:created_at).reverse_order
  # default_scope -> { order(created_at: :desc) }
  # Task.unscope(:end_date)
  validates :name, presence: true
  validates :description, presence: true
  validates :end_date, presence: true
  validates :status, presence: true

  # def self.search(search)
  #   return Task.all unless search
  #   Task.where(['name LIKE ?', "%#{search}%"])
  # end

  # enum gender: { unknown: 0, male: 1, female: 2, other: 9 }
  # ユーザー名による絞り込み
  scope :get_by_name, ->(name) {
    where("name like ?", "%#{name}%")
  }
  # 性別による絞り込み
  scope :get_by_status, ->(status) {
    where(status: status)
  }
end
