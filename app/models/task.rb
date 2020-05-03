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
  validates :priority, presence: true
  validate :pretend_ago

  def pretend_ago
    errors.add(:end_date, ' 過去の日付は入力できません') if end_date.nil? || end_date < Date.today
  end

  # def self.search(search)
  #   return Task.all unless search
  #   Task.where(['name LIKE ?', "%#{search}%"])
  # end

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
  # PRIORITIES = {
  #   :High => 3,
  #   :Middle  => 2,
  #   :Low  => 1,
  #   }
    
  #   def <=> (other)
  #   PRIORITIES[self.priority] <=> PRIORITIES[other.priority]
  #   end

end
