namespace :bootstrap do
  desc 'Creating first topics'
  task topics: :environment do
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
  desc 'Run all bootstrapping tasks'
  task all: [:topics]
end
