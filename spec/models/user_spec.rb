require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe 'Userを作成してみる' do
    it "有効な場合は保存されるか" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
    it "nameが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = build(:user, name: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("を入力してください")
    end
    it "emailが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = build(:user, email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("を入力してください")
    end
    it "passwordが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
      user = build(:user, password: nil)
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("を入力してください")
    end
    it "passwordが不一致の場合、エラーメッセージが返ってきているか" do
      user = build(:user, password: "111111")
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to be_present
    end
  end
end