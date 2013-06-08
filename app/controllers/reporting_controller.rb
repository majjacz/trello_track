class ReportingController < ApplicationController

  def daily

    if params[:year].present? and params[:month].present? and params[:day].present?
      @date = Time.zone.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")
      @start_time = @date.to_datetime
      @end_time = @date.to_datetime.end_of_day
    else
      date = Time.zone.now
      redirect_to daily_url(year: date.year, month: date.month, day: date.day)
    end

  end


  def weekly

    if params[:year].present? and params[:week].present?
      @date = Date.commercial(params[:year].to_i, params[:week].to_i)
      @start_time = @date.to_datetime
      @end_time = @date.end_of_week.to_datetime.end_of_day
    else
      date = Time.zone.now.to_date
      redirect_to weekly_url(year: date.year, week: date.cweek)
    end

  end


  def monthly

    if params[:year].present? and params[:month].present?
      @date = Time.zone.parse("#{params[:year]}-#{params[:month]}-1")
      @start_time = @date.to_datetime.to_datetime
      @end_time = @date.end_of_month.to_datetime.end_of_day
    else
      date = Time.zone.now
      redirect_to monthly_url(year: date.year, month: date.month)
    end

  end

  def custom

    if params[:year_from].present? and params[:month_from].present? and params[:day_from].present? and params[:year_to].present? and params[:month_to].present? and params[:day_to].present?
      @start_time = Time.zone.parse("#{params[:year_from]}-#{params[:month_from]}-#{params[:day_from]}").to_datetime
      @end_time = Time.zone.parse("#{params[:year_to]}-#{params[:month_to]}-#{params[:day_to]}").to_datetime.end_of_day
    else
      date = Time.zone.now
      redirect_to custom_url(year_from: date.year, month_from: date.month, day_from: date.day, year_to: date.year, month_to: date.month, day_to: date.day)
    end

  end

end
