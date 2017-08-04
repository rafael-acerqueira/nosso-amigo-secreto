require "rails_helper"

RSpec.describe CampaignRaffleJob, type: :job do
  include ActiveJob::TestHelper

  before(:each) do
    @current_user = FactoryGirl.create(:user)
    @campaign = create(:campaign, user: @current_user)
    @job = CampaignRaffleJob.perform_later(@campaign)
  end

  it 'queues the job' do
    expect { CampaignRaffleJob.perform_later(@campaign) }
      .to have_enqueued_job(CampaignRaffleJob)
  end

  it 'is in emails queue' do
    expect(CampaignRaffleJob.new.queue_name).to eq('emails')
  end

  it 'executes perform' do
    expect(RaffleService.new(@campaign))
    perform_enqueued_jobs { @job }
  end
end
