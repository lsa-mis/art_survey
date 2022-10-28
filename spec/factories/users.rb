# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  uniqname               :string
#  principal_name         :string
#  display_name           :string
#  person_affiliation     :string
#
FactoryBot.define do
  factory :user do
    id { Faker::Number.between(from: 1, to: 10) }
    email { Faker::Internet.email }
    provider { Faker::FunnyName.one_word_name }
    uid { Faker::Number.between(from: 567489, to: 789760) }
    uniqname { Faker::Internet.username(specifier: 5..10) }
    principal_name { Faker::FunnyName.two_word_name }
    display_name { Faker::FunnyName.one_word_name }
    person_affiliation {Faker::Internet.domain_name}   
  end
end
