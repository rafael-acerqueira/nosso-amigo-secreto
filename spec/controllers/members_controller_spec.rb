require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end

  describe "POST #create" do

    it "returns http success" do
      campaign = create(:campaign, user: @current_user)
      member_attributes = attributes_for(:member).merge(campaign_id: campaign.id)
      post :create, params: {member: member_attributes}
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      campaign = create(:campaign, user: @current_user)
      member = create(:member, campaign: campaign)
      delete :destroy, params: {id: member.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "returns http success" do
      member_attributes = attributes_for(:member)
      campaign = create(:campaign, user: @current_user)
      member = create(:member, campaign: campaign)
      put :update, params: {id: member.id, member: member_attributes}
      expect(response).to have_http_status(:success)
    end
  end
end
