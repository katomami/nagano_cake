# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:genre) { create(:genre, name:'hoge') }
  describe 'ジャンル追加画面のテスト' do
    before do
      visit admin_genres_path
    end
    context '表示の確認' do
      it 'ジャンル追加画面に「ジャンル一覧・追加」が表示されているか' do
        expect(page).to have_content 'ジャンル一覧・追加'
      end
      it 'pathが"/admin/genres"であるか' do
        expect(current_path).to eq('/admin/genres')
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'genre[name]', with: Faker::Lorem.characters(number:5)

        click_button '新規登録'
        expect(page).to have_current_path admin_genres_path
      end
    end
  end
end

