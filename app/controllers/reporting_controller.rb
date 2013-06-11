class ReportingController < ApplicationController

  def daily

    if params[:year].present? and params[:month].present? and params[:day].present?
      @date = Time.zone.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}").to_datetime.in_time_zone
      @start_time = @date.beginning_of_day
      @end_time = @start_time + 1.day
      @human_end_time = @date.end_of_day
      prepare
    else
      date = Time.zone.now
      redirect_to daily_url(year: date.year, month: date.month, day: date.day)
    end

  end


  def weekly

    if params[:year].present? and params[:week].present?
      @date = Date.commercial(params[:year].to_i, params[:week].to_i).to_datetime.in_time_zone
      @start_time = @date.beginning_of_week.beginning_of_day
      @end_time = @start_time + 1.week
      @human_end_time = @date.end_of_week.end_of_day
      prepare
    else
      date = Time.zone.now.to_date
      redirect_to weekly_url(year: date.year, week: date.cweek)
    end

  end


  def monthly

    if params[:year].present? and params[:month].present?
      @date = Time.zone.parse("#{params[:year]}-#{params[:month]}-1").to_datetime.in_time_zone
      @start_time = @date.to_time.in_time_zone
      @end_time = @start_time + 1.month
      @human_end_time = @date.end_of_month.end_of_day
      prepare
    else
      date = Time.zone.now
      redirect_to monthly_url(year: date.year, month: date.month)
    end

  end

  def custom

    if params[:year_from].present? and params[:month_from].present? and params[:day_from].present? and params[:year_to].present? and params[:month_to].present? and params[:day_to].present?
      @start_time = Time.zone.parse("#{params[:year_from]}-#{params[:month_from]}-#{params[:day_from]}").to_datetime.in_time_zone
      @end_time = Time.zone.parse("#{params[:year_to]}-#{params[:month_to]}-#{params[:day_to]}").to_datetime.in_time_zone.beginning_of_day + 1.day
      @human_end_time = @end_time - 1.seconds
      prepare
    else
      date = Time.zone.now
      redirect_to custom_url(year_from: date.year, month_from: date.month, day_from: date.day, year_to: date.year, month_to: date.month, day_to: date.day)
    end

  end

  private
  def prepare
    last_reporting_url(request.fullpath)
    @user = current_user
    @tasks = @user.tasks.between(@start_time, @end_time).order("start_time")
    @total_seconds = @tasks.sum do |t|
      t.total_time_capped_by(@start_time, @end_time) || 0
    end
  end

end
