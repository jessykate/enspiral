class PagesController < ApplicationController
  def holding
  end

  def about
  end

  def recruitment
  end

  def index
    @feeds = FeedEntry.latest
    @people = Person.with_gravatar.sort_by{ rand }.slice(0...12)
  end

  def services
  end
  
  def contact
    @phone_number = '04 123 1234'
    
    Notifier.contact(params).deliver
    flash[:notice] = 'Enquiry was sent successfully.'
    redirect_to root_url
  end

  def social_media
  end
end
