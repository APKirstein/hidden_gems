require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it { should have_valid(:name).when('Chipotle') }
  it { should have_valid(:name).when('Row34') }
  it { should have_valid(:address).when('123 Main St') }
  it { should have_valid(:city).when('Boston') }
  it { should have_valid(:state).when('MA') }
  it { should have_valid(:zip_code).when('02111') }
  it { should_not have_valid(:name).when('') }
  it { should_not have_valid(:name).when(nil) }
  it { should_not have_valid(:address).when('') }
  it { should_not have_valid(:address).when(nil) }
  it { should_not have_valid(:city).when('') }
  it { should_not have_valid(:city).when(nil) }
  it { should_not have_valid(:state).when('') }
  it { should_not have_valid(:state).when(nil) }
  it { should_not have_valid(:state).when('Massachusetts') }
  it { should_not have_valid(:zip_code).when('123') }
end
