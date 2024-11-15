# app/services/scrapers/base_scraper.rb
module Services
  class BaseScraper
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def max_pages
      raise NotImplementedError, 'all scrapper must implement this method'
    end

    def scrape_links(page_number)
      raise NotImplementedError, 'all scrapper must implement this method'
    end

    def scrape_page_content(link)
      raise NotImplementedError, 'all scrapper must implement this method'
    end
  end
end
