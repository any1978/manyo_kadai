class Task < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validate :pretend_ago

  def pretend_ago
    errors.add(:end_date, ' 過去の日付は入力できません') if end_date.nil? || end_date < Date.today
  end



  # enum status: { unknown: 0, 未着手: 1, 着手中: 2, 完了: 3 }
  # ユーザー名による絞り込み
  scope :get_by_name, ->(name) {
    where("name like ?", "%#{name}%")
  }
  # ステータスによる絞り込み
  scope :get_by_status, ->(status) {
    where(status: status)
  }

  enum priority: %i[High Middle Low]


end
