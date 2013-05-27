class MessageNotifier < Notifier
  observe :message 

  def after_create(message)
    notify(message.to, "message_create", message, "from_id" => message.from_id, "from" => message.from.name)
  end
end