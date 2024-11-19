# app/services/scraper_consumer_financial.rb
module Services
  class ScraperMoneyManagement < BaseScraper
    include HTTParty

    def max_pages
      api_url = 'https://www.moneymanagement.org/api/sitecore/Blog/BlogList_API'
      params = {
        filterType: 0,
        dateFilter: '01/01/01, 12:00 AM',
        valueFilter: 'null',
        page: 1,
        pageSize: 10
      }

      response = HTTParty.get(api_url, query: params)

      if response.code == 200
        parsed_response = JSON.parse(response.body)
        parsed_response['totalPages']

      else
        puts "Failed to fetch data. HTTP Code: #{response.code}"
        nil
      end
    end

    def scrape_links(page_number)
      # URL base de la API
      api_url = 'https://www.moneymanagement.org/api/sitecore/Blog/BlogList_API'
      params = {
        filterType: 0,
        dateFilter: '01/01/01, 12:00 AM',
        valueFilter: 'null',
        page: page_number,
        pageSize: 10
      }

      response = HTTParty.get(api_url, query: params, headers: default_headers)

      if response.success?
        data = JSON.parse(response.body)

        data['rows'].map do |post|
          URI.join('https://www.moneymanagement.org', post['PostUrl']).to_s
        end

        # puts "Enlaces encontrados en la página #{page_number}: #{links}"

      else
        puts "Error al obtener datos de la API para la página #{page_number}: #{response.code}"
        []
      end
    end

    def scrape_page_content(link, source_id)
      response = HTTParty.get(link, headers: default_headers)
      document = Nokogiri::HTML(response.body)

      metadata = scrape_page_metadata(document)

      content = document.css('div.blog-detail').text.strip
      cleaned_content = content.gsub(/\s+/, ' ').squeeze(' ')

      # unique_id = SecureRandom.hex(8)

      # File.open(Rails.root.join('tmp', "article_#{unique_id}.html"), 'w') do |file|
      #  file.write(metadata)
      #  file.write(cleaned_content)
      # end

      Article.create!(
        content: cleaned_content,
        metadata: metadata,
        source_id: source_id,
        link: link
      )
    end

    private

    def scrape_page_metadata(document)
      title = document.css('h1').text.strip

      date_element = document.at_css('div.blog-byline .date')
      publication_date = date_element ? date_element['datetime'] : nil

      topics = document.css('p.blog-detail-tags a').map(&:text).map(&:strip)

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
