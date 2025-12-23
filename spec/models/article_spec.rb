require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { create(:user) }

  context 'タイトルと内容が入力されている場合' do
    let(:article) { build(:article, user: user) }

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end

  context 'タイトルの文字が一文字の場合' do
    let(:article) do
      build(
        :article,
        title: Faker::Lorem.characters(number: 1),
        user: user
      )
    end

    it '記事を保存できない' do
      article.valid?
      expect(article.errors[:title]).to include('は2文字以上で入力してください')
    end
  end
end
