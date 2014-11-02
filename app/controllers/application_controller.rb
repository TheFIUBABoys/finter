require 'pry'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = 'Uv0j5zucxjhagAqfaGKnpQzeO'
      config.consumer_secret     = 'hmNcGr33Shl87Fcs8oxStOGrRuVfQYHz5MPl3P84FIief5Fgfn'
      config.access_token        = '2821251712-T5vqdPZHwCEmsmTbJm22y8szQ8YhH5mn6DAO0tv'
      config.access_token_secret = 'H2qEXs5zJJ8vFhrKBoFxjLWbbp4FIKF4OEYhUg1yDCC6M'
    end
  end
end
