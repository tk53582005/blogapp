require "rails_helper"

RSpec.describe "Api::Comments", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  let!(:comment_user) { create(:user) }
  let!(:comments) { create_list(:comment, 3, article: article, user: comment_user) }

  describe "GET /api/comments" do
    it "200を返し、コメント一覧を取得できる" do
      get api_comments_path(article_id: article.id)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include("application/json")

      json = JSON.parse(response.body)

      expect(json.length).to eq(3)
      expect(json.all? { |c| c.key?("id") }).to be true
      expect(json.all? { |c| c.key?("content") }).to be true

      # 返ってきたIDが、作ったcommentsのIDと一致している（絞り込み確認）
      expect(json.map { |c| c["id"] }.sort).to eq(comments.map(&:id).sort)
    end
  end
end
