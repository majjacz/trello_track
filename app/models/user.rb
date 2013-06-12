#require 'trello'

class User < ActiveRecord::Base

  has_many :tasks
  has_one :unfinished_task, :class_name => 'Task', :conditions => 'time_records.end_time IS NULL'

  def self.from_api_key(apikey)
    where(:api_key => apikey).first
  end

  def self.from_omniauth(auth)
    user = where(auth.slice("provider", "uid")).first
    unless user.nil?
      user.oauth_hash = auth
      user.save!
    end
    user = create_from_omniauth(auth) if user.nil?
    return user
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]
      user.name = auth["info"]["name"]
      user.oauth_hash = auth
      user.api_key = SecureRandom.hex
    end
  end

  def oauth_hash_yaml
    @oauth_hash_yaml ||= YAML::load(oauth_hash)
  end

  #include Trello
  #usage: @user.trello_api.find(:cards, Time_record.first.trello_card_id).name
  #def trello_api
  #  @trello ||= Trello::Client.new(
  #            :consumer_key => ENV['TRELLO_KEY'],
  #            :consumer_secret => ENV['TRELLO_SECRET'],
  #            :oauth_token => oauth_hash_yaml['extra']['access_token'].token,
  #            :oauth_token_secret => oauth_hash_yaml[:extra][:access_token].secret
  #           )
  #end

end
