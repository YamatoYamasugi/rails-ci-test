require 'rails_helper'

RSpec.describe "Api::V1::Memos", type: :request do
  describe "GET /memos" do
    it "全権取得" do
      FactoryBot.create_list(:memo, 5)
      get "http://127.0.0.1:3000/api/v1/memos"
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json.length).to eq(5)
    end
  end
  # APIにmemoが追加できるかどうかのテスト
  describe "POST /memos" do
    it "新しいメモを追加する" do
      valid_params = {title: "title", content: "content"}
      post "http://127.0.0.1:3000/api/v1/memos", params: valid_params
      change(Memo, :count).by(+1)
      expect(response).to have_http_status(:success)
    end
  end
end
