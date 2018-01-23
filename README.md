# Mwangazi Solar Lights web scraper and Database

-----
## To run this app on your local machine
  * Install Ruby.2.3.3
  * In a terminal, run `git clone https://github.com/luigilake/GridApp-web-scraper.git`
  * Navigate to the project's root directory with `cd pensieve`
  * Run `bundle install && rake db:setup`
  * In terminal, run rails s
  * Visit `http://localhost:3000/` in your browser.
-----

## Web Scraper

The web scraper currently resides in the `application_controller.rb`, as the `scrape_mangoo` function, to test for its effectiveness in scraping the two websites. The websites that are being scraped are:
  * [Mangoo.org](https://www.mangoo.org/)
  * [LightingGlobal.org](https://www.lightingglobal.org)

The scraper goes about this by first accessing a selected product from Mangoo.org, for example, the [***Solar Lantern S20***](https://www.mangoo.org/product-catalogue/productdetail/market/show/product/s20-solar-lamp/?tx_marketplace_articlesearch%5Bcontroller%5D=Product&cHash=272c9fa15f83d636bc190dcebfc3f6cd). The scraper will then obtain relevant information with the Mangoo website, which includes ***a link to the same product's Lighting Global webpage***. The scraper will then obtain the relevant information within the Lighting Global webpage, ***which should include the product spec PDFs***.

While the scraper currently works, there are a couple of things that need to be done. Here is the general flow of information:
  * THE WEB SCRAPER OBTAINS ALL INFORMATION FROM MANGOO AND LIGHTING GLOBAL
    * Double check, by scraping random Mangoo.org products, to see if the scraper dynamically and successfully obtains the proper information from both Lighting Global and Mangoo websites.
    * There was a recent change in the format of the PDFs, fix the *currently commented out PDF scraper* so that the information in the PDFs will also be scraped properly.
  * SAVE ALL INFO OBTAINED BY THE WEB SCRAPER INTO THE CSV FILES (inside the public folder)
  * THE MWANGAZI TEAM REVIEWS ALL INFORMATION IN THE CSV FILES
    * The CSVs will have a column entitled 'VERIFIED', with the values 'YES' or 'NO'. The Mwangazi team will change this to 'YES' if they've verified the information in a row.
  * IF INFORMATION IS VERIFIED, PULL ALL INFO FROM CSVs THEN ADD THEM TO THE DATABASE.
  * Done!
