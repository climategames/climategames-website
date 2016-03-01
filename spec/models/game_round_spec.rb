require 'rails_helper'

RSpec.describe GameRound, type: :model do
  describe ".current" do
    it 'raises if no COP21 game round exists' do
      FactoryGirl.create(:game_round, name: "Genua")
      expect { GameRound.current }.to raise_error
    end

    it 'is the COP21 game round if it exists' do
      cop21 = FactoryGirl.create(:game_round, name: "COP21")
      expect(GameRound.current).to eq cop21
    end
  end

  describe "validations" do
    it "is not valid if starts_at > ends_at" do
      attrs = {
        starts_at: 1.days.ago,
        ends_at: 2.days.ago
      }
      expect(FactoryGirl.build(:game_round, attrs)).not_to be_valid
    end
  end

  describe "#active?" do
    it "is not active if current date is after ends_at" do
      attrs = {
        starts_at: 2.days.ago,
        ends_at: 1.day.ago
      }
      expect(FactoryGirl.create(:game_round, attrs).active?).to be_falsey
    end

    it "is not active if current date is before starts_at" do
      attrs = {
        starts_at: 1.days.from_now,
        ends_at: 2.days.from_now
      }
      expect(FactoryGirl.create(:game_round, attrs).active?).to be_falsey
    end

    it "is active if current date is between starts_at and ends_at" do
      attrs = {
        starts_at: 1.days.ago,
        ends_at: 1.day.from_now
      }
      expect(FactoryGirl.create(:game_round, attrs).active?).to be_truthy
    end
  end
end
