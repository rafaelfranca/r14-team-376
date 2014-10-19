# encoding: utf-8
require 'rails_helper'

RSpec.describe Recruitment, :type => :model do
  fixtures :all

  let(:position) { positions(:developer) }

  it 'recruits a candidate' do
    candidate = Candidate.create!(name: 'Wesley Safadão')

    recruitment = Recruitment.new(position: position)
    recruitment.candidate = candidate
    recruitment.save!

    expect(recruitment.candidate).to eq candidate
  end

  it 'tracks as participant when someone comments in a recruitment step' do
    rondy = User.create!(email: 'rondy.sousa@ptec.com.br', password: '12345678')
    recruitment = Recruitment.create
    step = RecruitmentStep.create(recruitment: recruitment, title: 'Mini app')

    step.comments << Comment.new(body: 'Need to improve Git skills', author: rondy)

    recruitment = Recruitment.new(position: position)
    recruitment.participants << participant_1
    recruitment.participants << participant_2
    recruitment.save!

    expect(recruitment.participants).to match_array [rondy]
  end

  it 'makes progress on many ordered steps' do
    step_1 = RecruitmentStep.new(order: 1, title: 'Entrevista via Skype')
    step_2 = RecruitmentStep.new(order: 2, title: 'Mini app')
    step_3 = RecruitmentStep.new(order: 3, title: 'Pair programming')

    recruitment = Recruitment.new(position: position)
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

    recruitment = Recruitment.new(position: position)
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

  describe '#current_state' do
    subject(:recruitment) do
      step_1 = RecruitmentStep.new(order: 1, title: 'Entrevista via Skype', state: 'waiting')
      step_2 = RecruitmentStep.new(order: 2, title: 'Mini app', state: 'waiting')
      step_3 = RecruitmentStep.new(order: 3, title: 'Pair programming', state: 'waiting')

      recruitment = Recruitment.new(position: position)
      recruitment.steps << step_1
      recruitment.steps << step_2
      recruitment.steps << step_3

      recruitment.save!

      recruitment
    end

    it 'is "waiting" when all steps are waiting' do
      expect(recruitment.current_state).to eq 'waiting'
    end

    it 'is "approved" only when all steps are approved' do
      recruitment.steps.find_by(order: 1).update_attribute(:state, 'approved')
      expect(recruitment.current_state).to eq 'waiting'

      recruitment.steps.find_by(order: 2).update_attribute(:state, 'approved')
      expect(recruitment.current_state).to eq 'waiting'

      recruitment.steps.find_by(order: 3).update_attribute(:state, 'approved')
      expect(recruitment.current_state).to eq 'approved'
    end

    it 'is "reproved" when at least one step is reproved' do
      recruitment.steps.find_by(order: 1).update_attribute(:state, 'reproved')
      expect(recruitment.current_state).to eq 'reproved'
    end
  end

  describe '#next_step' do
    let(:step_1) { RecruitmentStep.new(order: 1, title: 'Entrevista via Skype', state: 'waiting') }
    let(:step_2) { RecruitmentStep.new(order: 2, title: 'Mini app', state: 'waiting') }
    let(:step_3) { RecruitmentStep.new(order: 3, title: 'Pair programming', state: 'waiting') }

    subject(:recruitment) do
      recruitment = Recruitment.create!(position: position)
      recruitment.steps << step_1
      recruitment.steps << step_2
      recruitment.steps << step_3

      recruitment
    end

    it 'is the first step when all steps are waiting' do
      expect(recruitment.next_step).to eq step_1
    end

    it 'is the first waiting step after the last approved one' do
      recruitment.steps.find_by(order: 1).update_attribute(:state, 'approved')
      expect(recruitment.next_step).to eq step_2

      recruitment.steps.find_by(order: 2).update_attribute(:state, 'approved')
      expect(recruitment.next_step).to eq step_3
    end

    it 'is nil when all steps are approved' do
      recruitment.steps.update_all(state: 'approved')

      expect(recruitment.next_step).to eq nil
    end

    it 'is nil when there is at least one reproved step' do
      recruitment.steps.find_by(order: 1).update_attribute(:state, 'reproved')
      expect(recruitment.next_step).to eq nil

      recruitment.steps.update_all(state: 'waiting')
      recruitment.steps.find_by(order: 2).update_attribute(:state, 'reproved')
      expect(recruitment.next_step).to eq nil

      recruitment.steps.update_all(state: 'waiting')
      recruitment.steps.find_by(order: 3).update_attribute(:state, 'reproved')
      expect(recruitment.next_step).to eq nil
    end
  end
end
