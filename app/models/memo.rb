class Memo < ApplicationRecord

    # 前のレコードを検索
    def previous
        Memo.where("id < ?", self.id).order("id DESC").first
    end

    # 次のレコードを検索
    def next
        Memo.where("id > ?", self.id).order("id ASC").first
    end
end
