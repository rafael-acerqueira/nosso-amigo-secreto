class CampaignRaffleJob < ApplicationJob
  queue_as :emails

  def perform(campaign)
    results = RaffleService.new(campaign).call

    campaign.members.each {|m| m.set_pixel}
    results.each do |member, friend|
      CampaignMailer.raffle(campaign, member, friend).deliver_now
    end
    campaign.update(status: :finished)

    CampaignMailer.raffle_error(campaign).deliver_now unless results
  end
end
