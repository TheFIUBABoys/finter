class HomeController < ApplicationController
  	def index
  	end
  	
	  def sendmail
      #Send email and  go back to home
      ActionMailer::Base.mail(:from => "lucas.simonelli@example.com", :to => "ohv40933@pisls.com", :subject => "Federer updates!", :body => "test")
          .deliver

      redirect_to(action: index)
    end
end
