require 'rest-client'
require 'base64'

class MailgunService
  def self.send_template_email(to:, subject:, template:, variables: {})
    api_key = ENV['MAILGUN_API_KEY'] || 'API_KEY'
    RestClient.post(
      'https://api.mailgun.net/v3/eigopencil.com/messages', 
      {
        from: '85pencilより👋 <postmaster@eigopencil.com>',
        to: to,
        subject: subject,
        template: template,
        'h:X-Mailgun-Variables': variables.to_json
      },
      { Authorization: "Basic #{Base64.strict_encode64("api:#{api_key}")}" }
    )
  end
end
