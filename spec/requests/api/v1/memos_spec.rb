require 'rails_helper'

RSpec.describe "Api::V1::Memos", type: :request do
  describe "GET /memos" do
    it "全件取得" do
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
      valid_params = { title: "title", content: "content" }
      post "http://127.0.0.1:3000/api/v1/memos", params: valid_params
      change(Memo, :count).by(+1)
      expect(response).to have_http_status(:success)
    end
  end
  # APIにmemoが削除できるかどうかのテスト
  describe 'DELETE /api/v1/memos/:id' do
    it 'deletes the memo' do
      memo = FactoryBot.create(:memo)
      delete "http://127.0.0.1:3000/api/v1/memos/#{memo.id}"
      expect(response).to have_http_status(200)
    end
    it 'ensures the memo is removed from the database' do
      memo = FactoryBot.create(:memo)
      delete "http://127.0.0.1:3000/api/v1/memos/#{memo.id}"
      expect(Memo.find_by(id: memo.id)).to be_nil
    end
  end
  it 'memoの編集を行う' do
    memo = FactoryBot.create(:memo)

    put "http://127.0.0.1:3000/api/v1/memos/#{memo.id}", params: { title: 'new-title' }
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    #データが更新されている事を確認
    expect(json['title']).to eq('new-title')
 end
end
