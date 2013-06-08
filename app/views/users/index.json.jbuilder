json.array!(@users) do |user|
  json.extract! user, :name, :surname, :email, :provider, :uid
  json.url user_url(user, format: :json)
end
