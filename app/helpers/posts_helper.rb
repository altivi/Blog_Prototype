module PostsHelper

	def search?
		params[:q] == nil
	end
	
end