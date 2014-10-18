require 'rails_helper'

RSpec.describe Organization, type: :model do
  it 'requires the name' do
    expect(Organization.new(name: nil)).not_to be_valid
  end
end
