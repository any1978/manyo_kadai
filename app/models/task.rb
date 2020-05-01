class Task < ApplicationRecord
  # Task.all.order(created_at: :desc)
  # Task.order(created_at: :desc)
  # Task.order(:updated_at,:created_at).reverse_order
  # default_scope -> { order(created_at: :desc) }
  # Task.unscope(:end_date)
  validates :name, presence: true
  validates :description, presence: true
end
