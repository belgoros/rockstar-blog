require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'should be valid' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it 'is invalid without body' do
    comment = build(:comment, body: nil)
    expect(comment).not_to be_valid
  end
end
