class User < ActiveRecord::Base
	has_secure_password
	has_many :comments

	def admin?
		self.role == 'admin'
	end

	def editor?
		self.role == 'editor'
	end

end
