class Notifier < ActiveRecord::Observer

  def notify(users, event, data)
    Notification.transaction do 
      Array.wrap(users).each do |user|
        Notification.create!({
          user: user,
          template: event,
          data: data,
        })
      end
    end
  end  

end