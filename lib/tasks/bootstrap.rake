namespace :bootstrap do
  task first_topic: :environment do
    Topic.create(
        name: 'deportes',
        promoted: false,
        twitter_keywords: 'deportes futbol rugby automovilismo ajedrez'
    )
  end
  task first_notification: :environment do
    Notification.create(
        body: 'No habra futbol este fin de semana.',
        url: 'http://google.com',
        promoted: false,
        twitter_handle: '@GonchuB',
        topic: Topic.where(name: 'deportes').first
    )
  end

  desc 'Run all bootstrapping tasks'
  task all: [:first_topic, :first_notification]
end