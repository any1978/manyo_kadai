class Task < ApplicationRecord

  belongs_to :user, optional: true
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  
  validates :name, presence: true
  validates :description, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validate :pretend_ago

  def pretend_ago
    errors.add(:end_date, ' 過去の日付は入力できません') if end_date.nil? || end_date < Date.today
  end

  scope :get_by_name, ->(name) {
    where("name like ?", "%#{name}%")
  }
  
  scope :get_by_status, ->(status) {
    where(status: status)
  }

  scope :search_with_label, -> (label) {
    return if label.blank?
    joins(:labels).where('labels.id = ?', label)
  }


  enum priority: %i[High Middle Low]


end
