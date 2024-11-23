# app/services/scraper_consumer_financial.rb
module Services
  class ScraperInvestopedia < BaseScraper
    include HTTParty

    def max_pages
      27
    end

    def scrape_links(page_number)
      suffix = case page_number
               when 1 then 'num'
               else ('a'.ord + page_number - 2).chr
               end

      base_number = 4_769_350
      unique_number = base_number + (page_number - 1)

      page_url = "#{url}/terms-beginning-with-#{suffix}-#{unique_number}"

      response = HTTParty.get(page_url, headers: default_headers)
      document = Nokogiri::HTML(response.body)

      links = document.css('a.dictionary-top300-list__list').map do |link_element|
        link_element['href']
      end

      links.compact
    end

    def scrape_page_content(link, source_id)
      response = HTTParty.get(link, headers: default_headers)
      document = Nokogiri::HTML(response.body)

      # metadata = scrape_page_metadata(document)

      content = document.css('div.article-content').text.strip
      cleaned_content = content.gsub(/\s+/, ' ').squeeze(' ')

      Article.create!(
        content: cleaned_content,
        metadata: {},
        source_id: source_id,
        link: link
      )
    end

    private

    def scrape_page_metadata(document)
      title = document.css('div.o-item-introduction h1').text.strip

      date_element = document.at_css('div.o-item-introduction .a-date time')
      publication_date = date_element ? date_element['datetime'] : nil

      topics = document.css('ul.m-tag-group li a .a-tag-topic__text').map(&:text)

      {
        title: title,
        publication_date: publication_date,
        topics: topics
      }
    end

    def default_headers
      {
        'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36',
        'Accept-Language' => 'en-US,en;q=0.9'
      }
    end
  end
end
