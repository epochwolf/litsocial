LitSocial::Application.config.middleware.use ExceptionNotifier,
 :email_prefix => "[LitSocial] ",
 :sender_address => %{Error Notifier <mailferret@litsocial.com>},
 :exception_recipients => %w{epochwolf@litsocial.com},
 :sections => ExceptionNotifier::Notifier.default_sections