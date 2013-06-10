module Api
  class TimerController < ApplicationController

    before_filter :authentificate
    respond_to :json

    def in_progress
      @record = @user.time_records.where('end_time IS NULL OR paused = 1').first
    end

    private
    def authentificate
      @user = User.from_api_key(params[:apikey])
      head :unauthorized unless @user
    end

  end
end
