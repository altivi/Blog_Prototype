class CommentsController < ApplicationController

	def create
		@post = Post.find(params[:post_id])
	    @comment = @post.comments.create(comment_params)
	    respond_to do |format|
			format.html { redirect_to post_url(@post) }
			format.js
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy if current_user.id == @comment.user_id
		respond_to do |format|
			format.html { redirect_to post_url(@post) }
			format.js
		end
	end

	private

	def comment_params
		if current_user
			hash = params.require(:comment).permit(:text)
			hash[:user_id] = current_user.id
			return hash
		end
	end

end