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
    let(:post)    { create(:post)}
    let(:comment) { build(:comment, commentable: post)}

    let(:valid_params) do
      ams_json(Comment, body: comment.body)
    end

    it 'creates a new comment for the post' do
      pending 'To be implemented'
      expect {
        post "/posts/#{post.id}/comments", params: valid_params
      }.to change(post.comments, :count).by(1)
      expect(response).to have_http_status(201)
    end
  end

  describe 'POST /comments/:comment_id/comments' do
    let(:comment)    { create(:comment)}
    let(:threaded_comment) { build(:comment, commentable: comment)}

    let(:valid_params) do
      ams_json(Comment, body: threaded_comment.body)
    end

    it 'creates a new comment for the existing comment' do
      pending 'To be implemented'
      expect {
        post "/comments/#{comment.id}/comments", params: valid_params
      }.to change(comment.comments, :count).by(1)
      expect(response).to have_http_status(201)
    end
  end
end
