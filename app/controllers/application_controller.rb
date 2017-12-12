class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def scrape_mangoo
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.mangoo.org/product-catalogue/productdetail/market/show/product/pico-solar-home-system-3000/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=28d7ac98bfcd74cd35751bee7121bf29"))

    # LIGHTING GLOBAL WEBSITE
    lighting_global = doc.css('a').find do |p|
      p["href"].include?("lightingglobal")
    end

    description = doc.css('p.bodytext')[0].text

    # iterate through indexes 4 - 9 in css array result to pull PRODUCT FEATURES
    product_features = []
    doc.css('div.row div.col-xs-12 p').each_with_index do |info, index|
      if info.text.include?("Model")
        6.times { |i|
          product_features << doc.css('div.row div.col-xs-12 p')[index + i].text.gsub("\r", "")
        }
      end
    end

    # pull all DISTRIBUTOR INFORMATION
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

    # MANUFACTURER'S WEBSITE
    manufacturer = doc.css('div.col-xs-12 p a').find do |p|
      p.text.include?("Manufacturer")
    end

    data = {
      name: doc.css('.col-xs-12 h1').text,
      description: doc.css('p.bodytext')[0].text,
      features: product_features,
      availability: doc.css('div.col-xs-12 p')[doc.css('div.col-xs-12 p').length - 1].text.gsub("\n", "").gsub("   ", ""),
      links: {
        manufacturer: manufacturer["href"],
        lighting_global: lighting_global["href"]
      },
      distributors: distributors
    }

    render json: data
  end
end
