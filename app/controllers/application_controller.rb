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
      product_features << doc.css('div.row div.col-xs-12 p')[i + 4].text.gsub("\r", "")
    }

    availability = doc.css('div.col-xs-12 p')[doc.css('div.col-xs-12 p').length - 1].text.gsub("\n", "").gsub("   ", "")

    manufacturers_site = doc.css('div.col-xs-12 p a')[1]["href"]

    light_global_site = doc.css('div.col-xs-12 p a')[2]["href"]

    awango_site = doc.css('div.col-xs-12 p a')[3]["href"]

    distributors = []
    doc.css('div.col-xs-12 td').each_with_index do |info, index|
      if index % 4 == 0
        {
          dealer: doc.css('div.col-xs-12 td')[index].text,
          country: doc.css('div.col-xs-12 td')[index + 1].text,
          price: doc.css('div.col-xs-12 td')[index + 2].text,
          contact: doc.css('div.col-xs-12 td')[index + 3].css('a')[0]["href"]
        }
      end
    end

    data = {
      name: product_name,
      description: product_description,
      features: product_features,
      availability: availability,
      links: {
        manufacturer: manufacturers_site,
        lighting_global: light_global_site,
        awango: awango_site
      }
    }

    render html: doc.css('div.col-xs-12 td')[3].css('a')[0]["href"]
  end
end
