require 'rails_helper'

RSpec.describe Memo, type: :model do
  it "is valid with a title" do
    memo = Memo.new(title: "Sample title")
    expect(memo).to be_valid
  end

  it 'is invalid without a title' do
    memo = Memo.new(title: nil)
    memo.valid?
    expect(memo.errors[:title]).to include("can't be blank")
  end
end
