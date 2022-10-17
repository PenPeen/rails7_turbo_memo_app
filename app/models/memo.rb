class Memo < ApplicationRecord

    def self.search(word)
        Memo.where("content LIKE?","%#{word}%")
    end

    # 前のレコードを検索
    def previous
        Memo.where("id < ?", self.id).order("id DESC").first
    end

    # 次のレコードを検索
    def next
        Memo.where("id > ?", self.id).order("id ASC").first
    end
end
