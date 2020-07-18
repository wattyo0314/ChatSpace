class MessagesController < ApplicationController
  before_action :set_group
  # GET  /groups/:group_id/messages
  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
    # group中に所属する全てのメッセージを含んでいる。:userに対するN＋1問題解消
  end

  # POST /groups/:group_id/message
  def create
    @message = @group.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.json
      end
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = "メッセージを入力してください。"
      render :index
      # 新しいインスタンスを生成し、その中にメッセージと画像のデータを入れる。
      # もしセーブできれば、一覧ページへ飛び、メッセーを追加しましたというフラッシュメッセージを送信
      # そうでなければそのままインデックスページへとび、メッセージを入力してくださいというフラッシュメッセージを送信。
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
