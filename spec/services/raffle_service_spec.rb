require 'rails_helper'

describe RaffleService do

  before :each do
    @campaign = create(:campaign, status: :pending)
  end

  describe '#call' do
    context "when has more then two members" do
      before(:each) do
        create(:member, campaign: @campaign)
        create(:member, campaign: @campaign)
        create(:member, campaign: @campaign)
        @campaign.reload

        @results = RaffleService.new(@campaign).call
      end

      it "results is a hash" do
        expect(@results.class).to eq(Hash)
      end

      it "all members are in results as a member" do
        result_members = @results.map {|member, friend| member}
        expect(result_members.sort).to eq(@campaign.members.sort)
      end

      it "all member are in results as a friend" do
        result_friends = @results.map {|member, friend| friend}
        expect(result_friends.sort).to eq(@campaign.members.sort)
      end

      it "a member don't get yourself" do
        @results.each do |member, friend|
          expect(member).not_to eq(friend)
        end
      end

      xit "a member x don't get a member y that get the member x" do
        # Desafio
      end

    end

    context "when don't has more then two members" do
      before(:each) do
        create(:member, campaign: @campaign)
        @campaign.reload

        @response = RaffleService.new(@campaign).call
      end

      it "raise error" do
        expect(@response).to eql(false)
      end
    end
  end
end
