# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = build(:user)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_acceptance_of(:accept_terms) }

    it 'should validate that email address is unique' do
      subject.email = 'text-email@example.com'
      is_expected.to validate_uniqueness_of(:email)
        .case_insensitive
        .with_message('has already been taken')
    end
  end

  context 'associations' do
    it { is_expected.to have_and_belong_to_many(:roles) }
    it { is_expected.to have_many(:users_vessels) }
    it { is_expected.to have_many(:vessels) }
    it { is_expected.to belong_to(:club) }
    it { is_expected.to have_many(:registrations) }
  end

  context 'instance methods' do
    describe '#first_name=' do
      it 'is capitalized' do
        usr = build(:user, last_name: 'foo')
        expect(usr.last_name).to eql('Foo')
      end
    end

    describe '#last_name=' do
      it 'is capitalized' do
        usr = build(:user, last_name: 'foo')
        expect(usr.last_name).to eql('Foo')
      end
    end

    describe '#name' do
      it "returns the user's full name" do
        expect(@user.name).to eq("#{@user.first_name} #{@user.last_name}")
      end
      it "returns the user's first name if there is no last name" do
        @user.last_name = nil
        expect(@user.name).to eq(@user.first_name.to_s)
      end
      it "returns the user's last name if there is no first name" do
        @user.first_name = nil
        expect(@user.name).to eq(@user.last_name.to_s)
      end
      it "returns the user's email if no names are available" do
        @user.first_name = nil
        @user.last_name = nil
        expect(@user.name).to eq(@user.email.to_s)
      end
    end

    describe '#to_json' do
      before(:each) do
        @user.save
        @json = JSON.parse(@user.to_json)
      end

      it 'returns the fields we expect' do
        expect(@json['id']).to eql(@user.id)
        expect(@json['first_name']).to eql(@user.first_name)
        expect(@json['last_name']).to eql(@user.last_name)
        expect(@json['email']).to eql(@user.email)
      end
      it 'does not return the fields we expect to be ommitted' do
        expect(@json.fetch('secret', nil)).to eql(nil)
        expect(@json.fetch('encrypted_password', nil)).to eql(nil)
        expect(@json.fetch('reset_password_token', nil)).to eql(nil)
        expect(@json.fetch('remember_created_at', nil)).to eql(nil)
        expect(@json.fetch('accept_terms', nil)).to eql(nil)
      end
      it 'returns the associations we expect' do
        create(:users_vessel, vessel: create(:vessel), user: @user)
        @user.update(club: create(:club))
        @json = JSON.parse(@user.reload.to_json)
        expect(@json['club'].length).to eql(1)
        expect(@json['vessels'].length).to eql(1)
      end
    end
  end
end
