require 'rails_helper'

RSpec.describe "Review", type: :request do
  describe "POST /reviews" do
    context "依存関係のあるテーブルのparamsが送信されているとき" do
      @item_params = {
        item_attributes: {
          "0": FactoryBot.attributes_for(:item)
        }
      }
      @params_nested = { 
        review: FactoryBot.attributes_for(:review).merge( @item_params )
      }
    end
    it 'リクエストが成功すること' do
        post reviews_path, params: @params_nested
        expect(response.status).to eq 302
    end
  end
end
