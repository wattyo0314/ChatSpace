class GroupsController < ApplicationController

  # GET /groups/new
  def new
    @group = Group.new
    @group.users << current_user
    # グループを新規作成するときはログインしているユーザーを加入させるため。
  end
  # => app/views/groups/new.html.haml
  
  # POST /groups
  # => app/views/groups/create.html.haml
  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end

  private

  def group_params
    params.require.(:group).permit(:name, :user_ids:[])
  end


end
