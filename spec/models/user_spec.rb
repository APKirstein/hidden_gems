require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:username).when('username') }
  it { should have_valid(:username).when('anothername123') }
  it { should_not have_valid(:username).when('') }
  it { should_not have_valid(:username).when(nil) }
  it { should_not have_valid(:username).when('with space') }
  it { should_not have_valid(:username).when('upsernamethatgoesonforever') }
  it { should_not have_valid(:username).when('with#$%^characters') }
end
