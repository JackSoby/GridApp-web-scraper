class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def scrape_mangoo
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.mangoo.org/product-catalogue/productdetail/market/show/product/s20-solar-lamp/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=dec2b667b8c66f18d9b28aafd0a09c28"))
    product_name = doc.css('.col-xs-12 h1').text
    product_description = doc.css('p.bodytext')[0].text

    # iterate through indexes 4 - 9 in css array result
    product_features = []
    5.times { |i|
      product_features << doc.css('div.row div.col-xs-12 p')[i + 4].text
    }

    manufacturers_site = doc.css('div.row div.col-xs-12 p a')

    render html: manufacturers_site
  end
end
