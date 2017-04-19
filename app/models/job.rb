class Job < ApplicationRecord
  has_many :resumes
  belongs_to :user

  has_many :job_relationships
  has_many :members, through: :job_relationships, source: :user

  validates :title, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }
  scope :high, -> { order('wage_upper_bound DESC')}
  scope :low, -> { order('wage_lower_bound DESC')}

end
