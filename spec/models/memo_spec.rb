require 'rails_helper'

RSpec.describe Memo, type: :model do
  
  # モデルを検索するクラスメソッド
  describe "#search" do
    before do
      FactoryBot.create(:memo, content: "今日も1日がんばろう")
      FactoryBot.create(:memo, content: "1日お疲れ様")
      FactoryBot.create(:memo, content: "今日も1日がんばったね")
    end

    it "完全一致での検索が正しくできること" do
      memos = Memo.search('今日も1日がんばろう')
      expect(memos.count).to eq 1
    end

    it "部分一致での検索が正しくできること" do
      memos = Memo.search('今日')
      expect(memos.count).to eq 2

      memos = Memo.search('1日')
      expect(memos.count).to eq 3
    end

    it "文字列が一致しないメモは検索されないこと" do
      memos = Memo.search('今日も疲れた')
      expect(memos.count).to eq 0
    end
  end

  # 前のレコードを取得するインスタンスメソッド
  describe "#previous" do

    # アクション前に実行
    let!(:memo_first){FactoryBot.create(:memo);}
    let!(:memo_second){FactoryBot.create(:memo);}
    let!(:memo_third){FactoryBot.create(:memo);}

    it "前のレコードが取得できること" do
      expect(memo_second.previous).to eq memo_first
    end

    it "2番目のレコードを削除すると、1番目に作成したレコードが取得されること" do
      memo_second.destroy
      expect(memo_third.previous).to eq memo_first
    end
  end

  # 次のレコードを検索するインスタンスメソッド
  describe "#next" do
    # アクション前に実行
    let!(:memo_first){FactoryBot.create(:memo);}
    let!(:memo_second){FactoryBot.create(:memo);}
    let!(:memo_third){FactoryBot.create(:memo);}

    it "次のレコードが取得できること" do
      expect(memo_second.next).to eq memo_third
    end

    it "2番目のレコードを削除すると、3番目に作成したレコードが取得されること" do
      memo_second.destroy
      expect(memo_first.next).to eq memo_third
    end
  end
  
end
