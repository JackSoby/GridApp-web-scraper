class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def scrape_mangoo
    require 'open-uri'
    require 'rubygems'
    require 'pdf/reader'
    require 'csv'

    doc = Nokogiri::HTML(open("https://www.mangoo.org/product-catalogue/productdetail/market/show/product/s100-solar-lamp/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=eb13d18c6f6928fbac0a5ae45b1ca3bc"))


    #WORKING LINKS
    #https://www.mangoo.org/product-catalogue/productdetail/market/show/product/s20-solar-lamp/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=272c9fa15f83d636bc190dcebfc3f6cd
    #https://www.mangoo.org/product-catalogue/productdetail/market/show/product/s2-solar-lamp/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=5f4fa2e9c317089e10a11ab639bfd706
    #https://www.mangoo.org/product-catalogue/productdetail/market/show/product/s100-solar-lamp/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=eb13d18c6f6928fbac0a5ae45b1ca3bc

    #NOT WORKING LINKS
    #https://www.mangoo.org/product-catalogue/productdetail/market/show/product/a2-solar-lamp/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=0ca4f705ac7682f2875460a40548f212


    # LIGHTING GLOBAL WEBSITE
    lighting_global = doc.css('a').find do |p|
      p["href"].include?("lightingglobal")
    end

    lighting_global_page = Nokogiri::HTML(open(lighting_global["href"]))

    additional_info = {}
    lighting_global_page.css('table tr td').each_with_index do |element, index|
      if index % 2 == 0
        additional_info[element.text] = lighting_global_page.css('table tr td')[index + 1].text
      end
    end

    # PDF SCRAPING - RECENT FORMAT CHANGE - REDO

    spec_pdf = ''
  lighting_global_page.css('section.pdf-downloads ul li a').each do |element|
    if element.text == "Specification Sheet"
      spec_pdf = element["href"]
    end
  end


  if spec_pdf != ''
   io = open(spec_pdf)

    reader = PDF::Reader.new(io)

  end




  paragraph = ""
  pdf_info = []
  reader.pages.each do |page|
    lines = page.text.scan(/^.+/)
    pdf_info << lines
  end

  pdf = pdf_info [0]
  pdf += pdf_info [1]

  lighting_global_pdf = {
      "num_lights_lg" => nil,
      "lumens_lg" => nil,
      "lighting_runtime_lg" => nil,
      "batt_type_lg" => nil,
      "mobile_charge_lg" => nil,
      "warranty_lg" => nil,
      "expiration_lg" => nil,
      "solar_lg" => nil
  }


 pdf.each do |line|
   if line.include?('ID number')
     lighting_global_pdf["num_lights_lg"] = line
   elsif line.include?('Total light output (lumens)')
        lighting_global_pdf["lumens_lg"] = line
      elsif line.include?('Full battery run time')
        lighting_global_pdf["lighting_runtime_lg"] = line
      elsif line.include?('Battery chemistry ')
          lighting_global_pdf["batt_type_lg"] = line
        elsif line.include?('Mobile charging')
          lighting_global_pdf["mobile_charge_lg"] = line
        elsif line.include?('warranty')
          lighting_global_pdf["warranty_lg"] = line
      elsif line.include?('expiration date')
        lighting_global_pdf["expiration_lg"] = line
      else 
   end
end


    # Scrape product description
    description = []
    doc.css('p').each_with_index do |entry, index|
      if index > 1
        if entry.text.include?("Model #")
          break
        end
        description << entry.text
      end
    end
    description = description.join(" ")

    # Scrape product features
    product_features = {}
    doc.css('div.row div.col-xs-12 p').each_with_index do |info, index|
      if info.text.include?("Model")
        product_features["Model #"] = doc.css('div.row div.col-xs-12 p')[index].text.gsub("\r", "").gsub(/(.*?)(\: )/, "")
        product_features["Size of Panel (Wp)"] = doc.css('div.row div.col-xs-12 p')[index + 1].text.gsub("\r", "").gsub(/(.*?)(\: )/, "")
        product_features["Size of Battery (Ah/V)"] = doc.css('div.row div.col-xs-12 p')[index + 2].text.gsub("\r", "").gsub(/(.*?)(\: )/, "")
        product_features["Battery Type"] = doc.css('div.row div.col-xs-12 p')[index + 3].text.gsub("\r", "").gsub(/(.*?)(\: )/, "")
        product_features["Lumen"] = doc.css('div.row div.col-xs-12 p')[index + 4].text.gsub("\r", "").gsub(/(.*?)(\: )/, "")
        product_features["Mobile Charging"] = doc.css('div.row div.col-xs-12 p')[index + 5].text.gsub("\r", "").gsub(/(.*?)(\: )/, "")
      end
    end

    # Scrape all distributor information
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

    # Scrape manufacturer website link
    manufacturer = doc.css('div.col-xs-12 p a').find do |p|
      p.text.include?("Manufacturer")
    end

    # Scrape for product availability (country and continent)
    availability = doc.css('div.col-xs-12 p')[doc.css('div.col-xs-12 p').length - 1].text.gsub(/(\   )|(\n)|(\:)|(\,)/, "").split(' ')
    locations = {}
    continent = ''
    availability.each do |loc|
      setting = loc.gsub('<br>', '').gsub('<b>', '').gsub('</b>', '')
      if setting != nil
        if (loc).include?("Asia") || (loc).include?("Africa")
          continent = setting
          locations[continent] = []
        else
          locations[continent] = []
          setting = 'N/A'
          locations[continent] << setting
        end
      end

    end

    # CSVs
    CSV.open("./public/products.csv", "wb") do |csv|
      csv << ['model #', 'name', 'description', 'mobile charging LG', 'light points LG', 'solar panel LG', 'battery type LG', 'warranty LG', 'expiration LG', 'panel size M', 'battery size M', 'battery type M', 'lumen M', 'mobile charging M']

      csv << [
        product_features["Model #"],
        doc.css('.col-xs-12 h1').text,
        description, additional_info["Mobile Phone Charging:"],
        additional_info["Light Points:"],
        additional_info["Solar Panel:"],
        additional_info["Battery Type:"],
        additional_info["Warranty Information:"],
        additional_info["Results Expiration Date:"],
        product_features["Size of Panel (Wp)"],
        product_features["Size of Battery (Ah/V)"],
        product_features["Battery Type"],
        product_features["Lumen"],
        product_features["Mobile Charging"]
      ]

    end

    CSV.open("./public/distributors.csv", "wb") do |csv|
      csv << ['model #', 'dealer_name', 'price', 'location','contact_link']

      distributors.each do |distributor|
        csv << [
          product_features["Model #"],
          distributor[:dealer],
          distributor[:price],
          distributor[:country],
          distributor[:contact]
        ];
      end

    end

    data = {
      model_num: product_features["Model #"],
      name: doc.css('.col-xs-12 h1').text,
      description: description,
      features: product_features,
      additional_info: additional_info,
      availability: locations,
      links: {
        manufacturer: manufacturer["href"],
        lighting_global: lighting_global["href"]
      },
      pdf_info:  lighting_global_pdf ,
      distributors: distributors
    }

    render json: data
  end

end
