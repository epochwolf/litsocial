class MessageNotifier < Notifier
  observe :message 

  def after_create(message)
    Notification.create(
      user: message.to,
      template: "message_create", 
      notifiable: message,
      data: {
        "from_id" => message.from_id,
        "from" => message.from.name,
      }
    )
  end
end