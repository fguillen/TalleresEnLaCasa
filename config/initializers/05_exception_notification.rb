ExceptionNotification::Notifier.exception_recipients = APP_CONFIG[:admin_emails]
ExceptionNotification::Notifier.sender_address = APP_CONFIG[:email_from]
ExceptionNotification::Notifier.email_prefix = "[Talleres en la Casa] ERROR: "


