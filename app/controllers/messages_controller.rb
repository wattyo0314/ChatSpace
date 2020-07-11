class MessagesController < ApplicationController
  # GET  /groups/:group_id/messages
  def index
  end

  # POST /groups/:group_id/message
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path, notice: "メッセージを送信しました。"
      render :edit
    end
  end
end
