class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :resumes

  def admin?
    is_admin
  end

  def has_applied?(job)
  applied_jobs.include?(job)
end

def apply!(job)
  applied_jobs << job
end
end
