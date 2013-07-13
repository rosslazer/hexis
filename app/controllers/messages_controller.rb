class MessagesController < ApplicationController


	def list
		@user = current_user
		@messages = @user.received_messages


	end


	def show
		@message = Message.find(params[:id])
	end
end
