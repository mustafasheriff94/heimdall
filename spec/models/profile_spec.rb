require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'Profile imported' do
    let(:user) { FactoryBot.create(:user) }
    before do
      profile_hash = Profile.transform(JSON.parse(File.open('spec/support/nginx_profile.json', 'r').read))
      @profile = Profile.new(profile_hash)
    end

    it 'get control_families' do
      families, nist = @profile.control_families
      expect(families).to_not be_empty
      expect(nist).to have_key('AC-2')
      expect(nist).to have_key('AC-3')
    end

    it 'get nist_hash' do
      nist = @profile.nist_hash nil
      expect(nist).to_not be_empty
      expect(nist).to have_key('CM-6')
    end

    it 'get build json string' do
      expect(@profile.to_json).to be_a(String)
      expect(JSON.parse(@profile.to_json)).to have_key('name')
    end

    it 'get build json' do
      expect(@profile.as_json).to have_key('name')
    end
  end
end
