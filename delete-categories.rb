require 'intercom'

intercom = Intercom::Client.new(app_id: 'dqv4tqvn', api_key: '8513ddd36eeac9caebb01a1b6daac7637af5c40f')
@users = intercom.users.all
@users = @users.select{|user| user.custom_attributes.has_key? "taste-category"}
puts @users.count

if(@users.count > 0)
  @users.each do |user|
    user.custom_attributes["taste-category"] = nil
    intercom.users.save(user)
  end
end
