class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def scrape_mangoo
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.mangoo.org/product-catalogue/productdetail/market/show/product/s2-solar-lamp/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=edb224d00917c9e9ea2fb69977ae606c"))
    
    # iterate through indexes 4 - 9 in css array result
    product_features = []
    5.times { |i|
      product_features << doc.css('div.row div.col-xs-12 p')[i + 4].text.gsub("\r", "")
    }

    distributors = []
    doc.css('div.col-xs-12 td').each_with_index do |info, index|
      if index % 4 == 0
        distributors << {
          dealer: doc.css('div.col-xs-12 td')[index].text,
          country: doc.css('div.col-xs-12 td')[index + 1].text.gsub("\n", "").gsub("  ", ""),
          price: doc.css('div.col-xs-12 td')[index + 2].text.gsub("\n", "").gsub("  ", ""),
          contact: doc.css('div.col-xs-12 td')[index + 3].css('a')[0]["href"]
        }
      end
    end

    data = {
      name: doc.css('.col-xs-12 h1').text,
      description: doc.css('p.bodytext')[0].text,
      features: product_features,
      availability: doc.css('div.col-xs-12 p')[doc.css('div.col-xs-12 p').length - 1].text.gsub("\n", "").gsub("   ", ""),
      links: {
        manufacturer: doc.css('div.col-xs-12 p a')[1]["href"],
        lighting_global: doc.css('div.col-xs-12 p a')[2]["href"],
        awango: doc.css('div.col-xs-12 p a')[3]["href"]
      },
      distributors: distributors
    }

    render json: data
  end
end
