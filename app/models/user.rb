class User < ActiveRecord::Base
	has_secure_password
	has_many :comments, dependent: :destroy
	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with:  VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 7 }, allow_nil: true
	
	def admin?
		self.role == 'admin'
	end

	def editor?
		self.role == 'editor'
	end

end
