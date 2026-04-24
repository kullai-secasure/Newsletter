module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_campaign, only: [:show, :update, :preview, :send_test]

      def index
        @campaigns = current_user.campaigns.order(created_at: :desc)
        render json: @campaigns
      end

      def preview
        preview_url = params[:preview_url] || campaign_preview_url(@campaign)
        screenshot = ScreenshotService.new.generate_preview(preview_url)
        render json: { screenshot_url: screenshot }
      end

      private

      def set_campaign
        @campaign = current_user.campaigns.find(params[:id])
      end
    end
  end
end
