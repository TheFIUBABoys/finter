namespace :bootstrap do
  puts 'Creating first topics'
  task first_topic: :environment do
    Topic.create(
        name: 'deportes',
        promoted: false,
        twitter_keywords: 'deportes futbol rugby automovilismo ajedrez',
        description: 'Informacion de deportes'
    )
    Topic.create(
        name: 'transito',
        promoted: false,
        twitter_keywords: 'ernestoarriaga transito cortado autopista colectivo tren subte',
        description: 'Informacion del estado de transito'
    )
  end
  puts 'Creating first notification and associating it with topic'
  task first_notification: :environment do
    notification = Notification.create(
        body: 'No habra futbol este fin de semana.',
        url: 'http://google.com',
        promoted: false,
        twitter_handle: '@GonchuB'
    )
    topic = Topic.where(name: 'deportes').first
    topic.notifications << notification
  end

  desc 'Run all bootstrapping tasks'
  task all: [:first_topic, :first_notification]
end
