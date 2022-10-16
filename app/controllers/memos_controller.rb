class MemosController < ApplicationController
    before_action :get_memo, only: [:show, :edit, :destroy]

    def index
        @memos = Memo.all
    end

    def show
    end
    
    def new
        @memo = Memo.new
    end

    def create
        @memo = Memo.new
        @memo.save!
        # redirect_to new_memo_path
        redirect_to root_path
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private
    def get_memo
        @memo = Memo.find(params[:id])
    end
end
