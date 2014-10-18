# encoding: utf-8
require 'rails_helper'

RSpec.describe Recruitment, :type => :model do
  it 'is owned by a recruiter' do
    recruiter = User.create!(email: 'pat.belda@ptec.com.br', password: '12345678')

    recruitment = Recruitment.new
    recruitment.recruiter = recruiter
    recruitment.save!

    expect(recruitment.recruiter).to eq recruiter
  end

  it 'recruits a candidate' do
    candidate = Candidate.create!(name: 'Wesley Safadão')

    recruitment = Recruitment.new
    recruitment.candidate = candidate
    recruitment.save!

    expect(recruitment.candidate).to eq candidate
  end
end
