class MemosController < ApplicationController
    before_action :get_memo, only: [:show, :edit, :update, :destroy]

    def index
        @memos = Memo.all.order(created_at: :desc)
        @memo = Memo.last
    end

    def show
    end
    
    def new
        @memo = Memo.new
    end

    # Toast対応（Turbo Streams検討中）
    def create
        @memo = Memo.new
        @memo.save!

        redirect_to root_path
    end

    def edit
    end

    def update
        # バリデーションがないため、検証不要
        @memo.update(memo_params)
        redirect_to root_path
    end

    def destroy
        # destroy.turbo_stream.erbで使用
        @next_memo = @memo.next
        @prev_memo = @memo.previous
        
        @memo.destroy
    end

    # 削除確認モーダルの表示
    def confirm
        @memo = Memo.find(params[:id])
    end

    # メモの検索
    def search
        @memos = Memo.search(params[:word])
    end

    private
    # メモ情報の取得
    def get_memo
        @memo = Memo.find(params[:id])
    end

    # ストロングパラメータ
    def memo_params
        params.require(:memo).permit(:content)
    end
end
