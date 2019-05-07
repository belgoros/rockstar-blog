require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:posts) { create_list(:post, 3) }
  let(:post_id) { posts.first.id }

  describe 'GET /posts' do
    before { get '/posts' }

    it 'has a successful response' do
      expect(response).to have_http_status(200)
    end

    it 'loads posts' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq 3
    end
  end

  describe 'GET /posts/:id/' do
    before { get "/posts/#{post_id}" }

    context 'when the record exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the post' do
        expect(json['data']['id']).to eq(post_id.to_s)
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 9999 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  describe 'DELETE /posts/:id' do
    before { delete "/posts/#{post_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  describe 'POST /posts' do
    let(:valid_attributes) do
      {
        title: 'Ruby regex syntax',
        body: 'Catch any character'
      }
    end

    context 'when the request is valid' do
      before { post '/posts', params: valid_attributes }

      it 'creates a post' do
        expect(json['data']['attributes']['title']).to eq('Ruby regex syntax')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/posts', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Body can't be blank/)
      end
    end
  end

  describe 'PATCH /posts/:id' do
    let(:post) { Post.first }
    let(:valid_attributes) { { title: 'Ruby rocks' } }

    before { patch "/posts/#{post.id}", params: valid_attributes }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'updates the modified attributes' do
      expect(post.reload.title).to eq 'Ruby rocks'
    end
  end
end
