class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def scrape_mangoo
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.mangoo.org/product-catalogue/productdetail/market/show/product/s2-solar-lamp/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=edb224d00917c9e9ea2fb69977ae606c"))
    product_name = doc.css('.col-xs-12 h1').text
    product_description = doc.css('p.bodytext')[0].text

    # iterate through indexes 4 - 9 in css array result
    product_features = []
    5.times { |i|
      product_features << doc.css('div.row div.col-xs-12 p')[i + 4].text.gsub("\r", "")
    }

    availability = doc.css('div.col-xs-12 p')[doc.css('div.col-xs-12 p').length - 1].text.gsub("\n", "").gsub("   ", "")

    manufacturers_site = doc.css('div.col-xs-12 p')
    data = {
      name: product_name,
      description: product_description,
      features: product_features,
      availability: availability
    }

    render html: manufacturers_site
  end
end
