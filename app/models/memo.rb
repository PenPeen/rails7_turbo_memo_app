class Memo < ApplicationRecord
    # コンテンツ検索機能
    scope :search,->(word){Memo.where("content LIKE?","%#{word}%")}

    # 前のレコードを検索
    # scope -> クラスメソッドと近い（同じではない）振る舞いのため、インスタンスメソッドのscope化は不可
    def previous
        Memo.where("id < ?", self.id).order("id DESC").first
    end

    # 次のレコードを検索
    def next
        Memo.where("id > ?", self.id).order("id ASC").first
    end
end
