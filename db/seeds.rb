ActiveRecord::Base.transaction do
  Organization.delete_all
  Position.delete_all
  User.delete_all
  Candidate.delete_all
  Recruitment.delete_all
  RecruitmentStep.delete_all

  organization = Organization.create!(name: 'Plataformatec')
  recruiter = User.create!(name: 'Lucas Mazza', email: 'lucas.mazza@ptec.com.br', password: '12345678', avatar: 'http://www.gravatar.com/avatar/5a90a67fa1a92e6a4b605cfd8da5e375?s=32')
  organization.set_owner!(recruiter)
  candidate = Candidate.create!(name: 'Daniel Filho', avatar: 'http://www.gravatar.com/avatar/3f2ebf61315d43cae59e727dab091620?s=96')

  position = organization.positions.create!(title: 'Developer', description: 'Web Developer')
  recruitment = position.recruitments.build

  recruitment.recruiter = recruiter
  recruitment.candidate = candidate

  recruitment.participants << [
    User.create!(name: 'George Guimaraes', email: 'george@ptec.com.br', password: '12345678', avatar: 'http://www.gravatar.com/avatar/ada3814d14e852b414a860cbbf4c2c13?s=32', organization: organization),
    User.create!(name: 'Hugo Barauna', email: 'hugo@ptec.com.br', password: '12345678', avatar: 'http://www.gravatar.com/avatar/dcde2c5777be84f81545480b353f1a71?s=32', organization: organization),
    User.create!(name: 'Rafael Rinaldi', email: 'rafael.rinaldi@gmail.com', password: '12345678', avatar: 'http://www.gravatar.com/avatar/ffc5102ee85d0d7ec57200fa3e6b1fce?s=32', organization: organization),
    User.create!(name: 'Rafael França', email: 'rafael.franca@ptec.com.br', password: '12345678', avatar: 'http://www.gravatar.com/avatar/0525b332aafb83307b32d9747a93de03?s=32', organization: organization)
  ]
  recruitment.save!

  recruitment.steps.create!(order: 1, title: 'Entrevista via Skype')
  recruitment.steps.create!(order: 2, title: 'Mini app')
  recruitment.steps.create!(order: 3, title: 'Pair programming')
  recruitment.steps.create!(order: 4, title: 'Mesa de bar com George Guimarães')
end
