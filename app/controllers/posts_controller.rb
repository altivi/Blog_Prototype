class PostsController < ApplicationController

	
	def index
		@posts = @search.result
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		@new_comment = Comment.new(post: @post)
		respond_to do |format|
			format.html
			format.json { render :json => comments_to_json_hash(@comments) }
			format.js
		end
	end

	# .select(:id, :text, :user_id)
	# 	@new = @comments.each { 
	# 		|c| c[:user_id] = User.find(c[:user_id]).email 
	# 	}

	def new
		@post = Post.new
	end

	def create
		@post = Post.create(post_params)
		respond_to do |format|
			format.html { redirect_to posts_url }
			format.js
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to root_url
	end

	private 

	def post_params
		params.require(:post).permit(:content, :title)
	end

	def comments_to_json_hash(comments)
		@array = Array.new
		comments.each do |c|
			@hash = Hash.new
			@hash[:id] = c.id
			@hash[:text] = c.text
			@hash[:email] = User.find(c[:user_id]).email
			@array << @hash
		end
		return @array
	end

	# def search_params
	# 	params.require(:search).permit(:text)
	# end

end
