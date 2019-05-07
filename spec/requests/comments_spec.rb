require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'GET /posts/:post_id/comments' do
    let!(:comment) { create(:comment) }

    before { get "/posts/#{comment.commentable.id}/comments" }

    it 'has a successful response' do
      expect(response).to have_http_status(200)
    end

    it 'loads posts' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq 1
    end
  end

  describe 'GET /comments/:comment_id/comments' do
    let!(:comment) { create(:comment, :for_comment) }

    before { get "/comments/#{comment.commentable.id}/comments" }

    it 'has a successful response' do
      expect(response).to have_http_status(200)
    end

    it 'loads posts' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq 1
    end
  end
end
