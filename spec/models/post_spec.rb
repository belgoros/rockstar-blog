require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'should be valid' do
    post = build(:post)
    expect(post).to be_valid
  end

  it 'is invalid without title' do
    post = build(:post, title: nil)
    expect(post).not_to be_valid
  end

  it 'is invalid without body' do
    post = build(:post, body: nil)
    expect(post).not_to be_valid
  end

  it 'should have unique title' do
    existing_post = create(:post)
    new_post = build(:post, title: existing_post.title)
    expect(new_post).not_to be_valid
  end
end
