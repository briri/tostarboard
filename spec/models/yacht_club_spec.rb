# frozen_string_literal: true

require 'rails_helper'

RSpec.describe YachtClub, type: :model do
  before(:each) do
    @club = build(:yacht_club)
  end

  context 'instance methods' do
    context 'type' do
      it "is 'yacht_club'" do
        expect(@club.type).to eql('yacht_club')
      end
    end

    context '#name=' do
      it 'capitalizes each word' do
        @club.name = 'foo bar yacht club'
        expect(@club.name).to eql('Foo Bar Yacht Club')
      end
      it "appends the words 'Yacht Club' when the name does not end with 'Yacht Club'" do
        @club.name = 'foo bar'
        expect(@club.name).to eql('Foo Bar Yacht Club')
      end
      it "does not append the words 'Yacht Club' when the name already ends with 'Yacht Club'" do
        @club.name = 'foo bar Yacht club'
        expect(@club.name).to eql('Foo Bar Yacht Club')
      end
    end
  end
end
