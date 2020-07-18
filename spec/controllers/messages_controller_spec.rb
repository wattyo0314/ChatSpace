require 'rails_helper'

describe MessagesController do
  let(:group) {create(:group)}
  let(:user) {create(:user)}
  # group = create(:group)

  describe 'Get #index' do
    context 'ログインしている'do
      before do
      login user
      get :index, params: { group_id: group.id }
    end

      it '@messageが定義されているか' do
        expect(assigns(:message)).to be_a_new(Message)
      end

      it '@groupが定義されているか' do
        expect(assigns(:group)).to eq group
      end

      it '該当するビューが描画されているか' do
        expect(response).to render_template :index
      end
    end
    context 'ログインしていない場合' do
      before do
        get :index, params: { group_id: group.id }
      end

      it '新規投稿ページへリダイレクトする' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'Get #create' do
    let(:params) {{group_id: group.id, user_id: user.id, message: attributes_for(:message)}}

    context 'ログイン' do
      before do
        login user
      end

      context '保存できる' do
        subject {
          post :create,
          params: params
        }

        it 'メッセージのデータが増える' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it 'グループメッセージ一覧を表示する' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context '保存できない' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'メッセージのデータが増えない' do
          expect( subject ).not_to change(Message, :count)
        end

        it '一覧ページに戻る' do
          
        end
      end
    end

      context 'ログインしていない' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end