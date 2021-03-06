class ReportingController < ApplicationController
  has_scope :users, :type => :array
  has_scope :projects, :type => :array

  def daily

    if params[:year].present? and params[:month].present? and params[:day].present?
      @date = Time.zone.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")
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
      @date = Time.zone.parse("#{params[:year]}-#{params[:month]}-1")
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
      @start_time = Time.zone.parse("#{params[:year_from]}-#{params[:month_from]}-#{params[:day_from]}")
      @end_time = Time.zone.parse("#{params[:year_to]}-#{params[:month_to]}-#{params[:day_to]}").beginning_of_day + 1.day
      if @end_time <= @start_time
        @end_time = @start_time.beginning_of_day + 1.day
      end
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
    if @user.admin?
      @users = User.all
      @projects = Project.all
      if (params[:users] or params[:projects])
        if params[:users] and params[:users].length >= 2
          @filtering_user = User.find(params[:users].first)
          @filtering_users_len = params[:users].length
        end
        if params[:projects] and params[:projects].length >= 2
          @filtering_projects = Project.find(params[:projects].first)
          @filtering_projects_len = params[:projects].length
        end
        @tasks = apply_scopes(Task).between(@start_time, @end_time)
      else
        @tasks = Task.between(@start_time, @end_time)
      end
    else
      @tasks = @user.tasks.between(@start_time, @end_time)
    end
    @total_seconds = @tasks.to_a.sum do |t|
      t.total_time_capped_by(@start_time, @end_time) || 0
    end
  end

end
