class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :authentications
  has_many :user_assessments, :class_name => "UserAssessments", :foreign_key => "user_id", :primary_key => "id"
  has_many :learning_objectives, :through => :user_assessments

  attr_accessible :email, :password, :password_confirmation, :remember_me, :approved, :admin

  scope :pending, where(:approved => false)

  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def admin?
    admin
  end

  def get_assessment learning_objective_id
    get_first UserAssessments.where(:user_id => self.id, :learning_objective_id => learning_objective_id)
  end
end
