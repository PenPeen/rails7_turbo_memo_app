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

    def create
        @memo = Memo.new
        @memo.save!

        # toast
        
        redirect_to root_path
    end

    def edit
    end

    def update
        # バリデーションがないため、保存
        @memo.update(memo_params)
        redirect_to root_path
    end

    def destroy
        # destroy.turbo_stream.erbで使用
        @next_memo = @memo.next
        @prev_memo = @memo.previous
        
        @memo.destroy
    end

    def confirm
        @memo = Memo.find(params[:id])
    end

    private
    def get_memo
        @memo = Memo.find(params[:id])
    end

    def memo_params
        params.require(:memo).permit(:content)
    end
end
