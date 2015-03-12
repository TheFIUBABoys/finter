class HomeController < ApplicationController
  	def index
  	end
  	
	  def sendmail
      #Send email and  go back to home
      ActionMailer::Base.mail(:from => "lucas.simonelli@example.com", :to => "gonchub@gmail.com", :subject => "Federer updates!", :body => "#Federer just won the US Open again! More in [finter permalink]")
          .deliver

      redirect_to(action: index)
    end
end
