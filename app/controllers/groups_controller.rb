class GroupsController < ApplicationController

  # GET /groups/new
  def new
    @group = Group.new
    @group.users << current_user
    # グループを新規作成するときはログインしているユーザーを加入させるため。
  end
  # => app/views/groups/new.html.haml
  
  # POST /groups
  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end

  # GET /groups/:id/edit
  def edit
    @group = Group.find(params[:id])
  end
  # => app/views/groups/edit.html.haml

  # PATCH /groups/:id
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to root_path, notice: 'グループを更新しました'
    else
      render :edit
    end
  end
end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [] )
  end


end
