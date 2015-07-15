require 'intercom'

intercom = Intercom::Client.new(app_id: 'dqv4tqvn', api_key: '8513ddd36eeac9caebb01a1b6daac7637af5c40f')

class Hash
  def except(which)
    self.tap{ |h| h.delete(which) }
  end
end

user = intercom.users.find(:email => "ebi@artkollecto.com")
puts user.custom_attributes['taste-category']
custom_abs = user.custom_attributes.except('taste-category')
user.custom_attributes = custom_abs
puts user.custom_attributes['taste-category']
user.custom_attributes['taste-category'] = nil
intercom.users.save(user)

#intercom.users.all.each {|user| puts %Q(#{user.custom_attributes["Budget"]})}


#@user = intercom.users.find_all(:custom_attributes =>{:budget => "$100-$300"})

#print @user
#print user.custom_attributes["budget"]
