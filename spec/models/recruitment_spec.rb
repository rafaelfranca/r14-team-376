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

  it 'is kept up by many participants' do
    participant_1 = User.create!(email: 'rondy.sousa@ptec.com.br', password: '12345678')
    participant_2 = User.create!(email: 'rafael.franca@ptec.com.br', password: '12345678')

    recruitment = Recruitment.new
    recruitment.participants << participant_1
    recruitment.participants << participant_2
    recruitment.save!

    expect(recruitment.participants).to match_array [participant_1, participant_2]
  end

  it 'makes progress on many ordered steps' do
    step_1 = RecruitmentStep.new(order: 1, title: 'Entrevista via Skype')
    step_2 = RecruitmentStep.new(order: 2, title: 'Mini app')
    step_3 = RecruitmentStep.new(order: 3, title: 'Pair programming')

    recruitment = Recruitment.new
    recruitment.steps << step_1
    recruitment.steps << step_2
    recruitment.steps << step_3
    recruitment.save!

    expect(recruitment.steps.count).to eq 3
    expect(recruitment.steps).to match_array [step_1, step_2, step_3]
  end

  it 'measures its progress based upon approved steps' do
    step_1 = RecruitmentStep.new(order: 1, title: 'Entrevista via Skype', state: 'waiting')
    step_2 = RecruitmentStep.new(order: 2, title: 'Mini app', state: 'waiting')
    step_3 = RecruitmentStep.new(order: 3, title: 'Pair programming', state: 'waiting')

    recruitment = Recruitment.new
    recruitment.steps << step_1
    recruitment.steps << step_2
    recruitment.steps << step_3
    recruitment.save!

    expect(recruitment.progress).to eq 0.0

    recruitment.steps.find_by(order: 1).update_attribute(:state, 'approved')
    expect(recruitment.progress).to eq 33.33

    recruitment.steps.find_by(order: 2).update_attribute(:state, 'approved')
    expect(recruitment.progress).to eq 66.67

    recruitment.steps.find_by(order: 3).update_attribute(:state, 'approved')
    expect(recruitment.progress).to eq 100.0
  end
end
