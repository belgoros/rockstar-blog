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

  describe 'POST /posts/:post_id/comments' do
    let(:a_post)    { create(:post)}
    let(:comment) { build(:comment, commentable: a_post)}
    let(:valid_params) do
      {
        body: comment.body
      }
    end

    context 'when the request is valid' do
      it 'creates a new post comment' do
        expect {
          post "/posts/#{a_post.id}/comments", params: valid_params
        }.to change(a_post.comments, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'POST /comments/:comment_id/comments' do
    let(:comment)    { create(:comment)}
    let(:thread_comment) { build(:comment, commentable: comment)}
    let(:valid_params) do
      {
        body: thread_comment.body
      }
    end

    context 'when the request is valid' do
      it 'creates a new comment of comment' do
        expect {
          post "/comments/#{comment.id}/comments", params: valid_params
        }.to change(comment.comments, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end
  end
end
