require 'rails_helper'

RSpec.describe "MemosController", type: :request do

  # Indexメソッド
  describe "#index" do
    it "リクエストが正しく完了すること" do
      get root_path
      expect(response).to have_http_status 200

      get :"/memos"
      expect(response).to have_http_status 200
    end
  end

  # Createメソッド
  describe "#create" do
    let(:memo){FactoryBot.create(:memo)}
    
    it "メモの作成が行えること" do
      memo_params = FactoryBot.attributes_for(:memo)
      expect{post :"/memos", params: {memo: memo_params}}.to change{Memo.count}.by(1)
    end

    it "リダイレクトが発生すること" do
      memo_params = FactoryBot.attributes_for(:memo)
      post :"/memos", params: {memo: memo_params}
      expect(response).to have_http_status 302
    end

    it "リダイレクト先が[root_path]であること" do
      memo_params = FactoryBot.attributes_for(:memo)
      post :"/memos", params: {memo: memo_params}
      expect(response).to redirect_to root_path  
    end
  end

  # EDIT
  describe "#edit" do
    let!(:memo){FactoryBot.create(:memo)}

    context "有効なリソースの場合" do
      it "編集画面が正しく表示されること" do
        get edit_memo_path(memo)
        expect(response).to have_http_status 200
      end
    end
    
    context "無効なリソースの場合" do
      it "ルートページへリダイレクトされること" do
        get "/memos/2/edit"
        expect(response).to redirect_to root_path
      end
    end
  end

  # UPDATEメソッド
  describe "#update" do
    let!(:memo){FactoryBot.create(:memo, content: "Old Contents")}
    let(:memo_params){FactoryBot.attributes_for(:memo, content: "Update Content")}
    
    context "有効なリソースの場合" do
      it "メモの更新が行えること" do
        patch memo_path(memo), params: {memo: memo_params}
        expect(memo.reload.content).to eq "Update Content"
      end
      
      it "更新後、リダイレクトが発生すること" do
        patch memo_path(memo), params:{memo: memo_params}
        expect(response).to have_http_status 302
      end
      
      it "更新後、ルートページへリダイレクトされること" do
        patch memo_path(memo), params:{memo: memo_params}
        expect(response).to redirect_to root_path
      end
    end

    context "無効なリソースの場合" do
      it "ルートページへリダイレクトされること" do
        patch "/memos/9999", params:{memo: memo_params}
        expect(response).to redirect_to root_path
      end
    end
  end

  # Destroyメソッド
  describe "#destroy" do
    let!(:memo){FactoryBot.create(:memo, content: "Old Contents")}
    
    context "有効なリソースの場合" do
      it "メモの削除が行えること" do
        # Turbo Streamsを使用する場合、「_turbo-stream.html」をヘッダーに追加する必要
        expect{
          delete memo_path(memo),
          xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        }.to change{Memo.count}.by(-1)
        
      end
      
      # 
      # TurboStreamsの為、リダイレクトは発生しない
      # 
      # it "削除後、リダイレクトが発生すること"
      # it "削除後、ルートページへリダイレクトされること"
      
    end

    context "無効なリソースの場合" do
      it "ルートページへリダイレクトされること" do
        delete "/memos/9999", xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to redirect_to root_path
      end
    end

  end
end
