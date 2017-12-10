class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def scrape_mangoo
    render html: 'scrape mangoo data here'
  end
end
