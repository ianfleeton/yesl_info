class Slack::Webhook
  def self.trigger(event, object)
    uri = URI.parse(webhook_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new('/')
    request.add_field('Content-Type', 'application/json')
    request.body = {
      'payload' => {
        'channel' => '#general',
        'username' => 'timesheet',
        'text' => "#{object.user} added a new timesheet entry to #{object.organisation}: #{object.description} <#{Rails.application.routes.url_helpers.edit_timesheet_entry_url(object)}>",
        'icon_emoji' => ':clock3:'
      }
    }
    http.request(request)
  end

  def self.webhook_url
    ENV['SLACK_WEBHOOK_URL']
  end
end
