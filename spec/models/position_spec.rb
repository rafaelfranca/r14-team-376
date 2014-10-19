require 'rails_helper'

RSpec.describe Position, type: :model do
  it 'requires title' do
    position = Position.new

    expect(position).not_to be_valid
    expect(position.errors[:title]).not_to be_empty
  end

  it 'belongs to an organization' do
    position = Position.new

    expect(position).not_to be_valid
    expect(position.errors[:organization]).not_to be_empty
  end
end
