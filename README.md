# Finter

## Dependencies

### Ruby
- RubyGems: https://rubygems.org/pages/download
- Rake: https://rubygems.org/gems/rake
- Bundler: http://bundler.io/
- RubyOnRails: http://rubyonrails.org/download/

### Postgre
-  ```sudo apt-get install postgresql postgresql-contrib```

Setup user-pass-db:

- ```sudo -u postgres createuser -D -A -P finter```
- ```sudo -u postgres psql```. Then in the opened psql console:
   - ```alter user finter with password 'finter';``` 
- ```sudo -u postgres createdb -O finter finter```

### JS Runtime
- ```sudo apt-get install nodejs```

## Bundle application

```bundle install```

## Run migrations

```bundle exec rake db:create``` (First time only)

```bundle exec rake db:migrate```

## Bootstrap database

```bundle exec rake bootstrap:all```

## Running app

```rails s```

or

```rails s -p 3000```

## Opening the rails console

```rails c```

Then you can interact with the models of the app. For example:

```ruby
first_topic = Topic.first
topic_notification = first_topic.notifications.first
notification_body = topic_notification.body

first_notification = Notification.first
notification_topic = first_notification.topic
topic_name = notification_topic.name
```

## General rails doc

http://guides.rubyonrails.org/
