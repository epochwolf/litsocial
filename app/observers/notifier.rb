class Notifier < ActiveRecord::Observer

  def notify(users, event, object, data)
    Notification.transaction do 
      Array.wrap(users).each do |user|
        Notification.create!({
          user: user,
          template: event,
          notifiable: object,
          data: data,
        })
      end
    end
  end  

end