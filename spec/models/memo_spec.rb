require 'rails_helper'

RSpec.describe Memo, type: :model do
  
  # モデルの検索機能
  describe "#search" do
    before do
      FactoryBot.create(:memo, content: "今日も1日がんばろう")
      FactoryBot.create(:memo, content: "1日お疲れ様")
      FactoryBot.create(:memo, content: "今日も1日がんばったね")
    end

    it "完全一致での検索が正しくできること" do
      memos = Memo.search('今日も1日がんばろう')
      expect(memos.count).to eq 1

      memos = Memo.search('今日も1日がんばろう！')
      expect(memos.count).to eq 0
    end

    it "部分一致での検索が正しくできること" do
      memos = Memo.search('今日')
      expect(memos.count).to eq 2

      memos = Memo.search('1日')
      expect(memos.count).to eq 3
    end
  end

  # 前のレコードを取得するメソッド
  describe "#previous" do
    it "前のレコードを正しく取得できていること" do
      memo_first = FactoryBot.create(:memo);
      memo_second = FactoryBot.create(:memo);
      memo_third = FactoryBot.create(:memo);
      # 2
      memo_second.destroy

      expect(memo_third.previous).to eq memo_first
    end
  end
  
end
