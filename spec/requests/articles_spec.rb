require "rails_helper"

RSpec.describe "Articles", type: :request do
  let!(:user) { create(:user) }

  describe "POST /articles" do
    context "ログインしている場合" do
      before { sign_in user }

      it "記事が保存される" do
        article_params = attributes_for(:article)

        expect {
          post articles_path, params: { article: article_params }
        }.to change(Article, :count).by(1)

        expect(response).to have_http_status(302)
        expect(Article.last.title).to eq(article_params[:title])
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトされる" do
        article_params = attributes_for(:article)

        expect {
          post articles_path, params: { article: article_params }
        }.not_to change(Article, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
