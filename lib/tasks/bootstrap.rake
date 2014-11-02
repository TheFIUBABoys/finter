namespace :bootstrap do
  desc 'Creating first topics'
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
  desc 'Creating first notification and associating it with topic'
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

  desc 'Creating many sports notifications'
  task many_notifications: :environment do
    topic = Topic.where(name: 'deportes').first
    notification = Notification.create(
        body: 'No habra futbol este fin de semana.',
        url: 'http://google.com',
        promoted: false,
        twitter_handle: 'GonchuB'
    )
    topic.notifications << notification
    notification = Notification.create(
        body: 'Banfield le gana a San Lorenzo en el torneo de futbol local.',
        url: 'http://google.com',
        promoted: false,
        twitter_handle: 'MartinPiro'
    )
    topic.notifications << notification
    notification = Notification.create(
        body: 'Travis Pastrana campeon mundial de automovilismo sobre 3 ruedas.',
        url: 'http://google.com',
        promoted: false,
        twitter_handle: 'LNDeportes'
    )
    topic.notifications << notification
    notification = Notification.create(
        body: 'El jugador de rugby sigue internado por tener el cuello extremadamente ancho. Ampliaremos',
        url: 'http://google.com',
        promoted: false,
        twitter_handle: 'DeportesAr'
    )
    topic.notifications << notification
    notification = Notification.create(
        body: 'Cualquier cosa menos un partido de ajedrez.',
        url: 'http://google.com',
        promoted: false,
        twitter_handle: 'mepodestuitear'
    )
    topic.notifications << notification
  end

  desc 'Run all bootstrapping tasks'
  task all: [:first_topic, :first_notification]
end
