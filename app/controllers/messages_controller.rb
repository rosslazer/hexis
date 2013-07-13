class MessagesController < ApplicationController




	def new

		@message = Message.new
		@message.sender= current_user
		@message.recipient = User.find(params[:id])

	end


	def create

	Message.new.save(params[:message])
 
  
	end

	def list
		@user = current_user
		@messages = @user.received_messages


	end


	def show
				@user = current_user

		@message = @user.received_messages.find(params[:id])
	end


	def delete

	@message = Message.find(params[:id])
  	@message.destroy
 
  redirect_to posts_path

	end


end
