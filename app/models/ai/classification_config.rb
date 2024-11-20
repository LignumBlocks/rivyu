module Ai
  # classifications hash
  class Classification
    def self.classifications_and_categories
      #  Hash with the structure:
      #  {
      #    'Classification1_name' => {
      #       'description' => '',
      #       'categories' => [
      #         { name: 'cat1_name', description: '' },
      #         { name: 'cat2_name', description: '' },
      #         ...
      #       ],
      #       Unknown category is the default category for when none of the listed matched the hack
      #       'unknown_category' => {
      #         name: '',
      #         description: ''
      #       }
      #     },
      #    'Classification2_name' => {
      #       'description' => '',
      #       'categories' => [
      #         { name: 'cat1_name', description: '' },
      #         { name: 'cat2_name', description: '' },
      #         ...
      #       ],
      #       Unknown category is the default category for when none of the listed matched the hack
      #       'unknown_category' => {
      #         name: '',
      #         description: ''
      #       }
      #     },
      #     ......
      #  }
      {
        'Financial' => financial_general,
        'Complexity' => complexity
      }
    end

    def self.financial_general
      {
        'description' => '',
        'categories' => [
          {
            name: 'Corporate Finance',
            description: 'Financial activities of corporations, including investment decisions, financial management, and capital structure.'
          },
          {
            name: 'Investment Management',
            description: 'Strategies and practices of managing financial assets to maximize returns.'
          },
          {
            name: 'Personal Finance',
            description: 'Management of individual or household financial activities, including budgeting, saving, and investing.'
          },
          {
            name: 'Financial Markets',
            description: 'Facilitate the trading of financial instruments and play a key role in the allocation of sources. Including stock market, bond market, and derivative market.'

          },
          {
            name: 'Public Finance',
            description: 'Studies the role of the government in the economy, including taxation, spending, and debt management.'
          },
          {
            name: 'Banking and Financial Institutions',
            description: 'Examines banking systems and financial institutions that provide financial services to individuals and businesses.'
          },
          {
            name: 'Risk Management',
            description: 'Identifies, assesses, and prioritizes risks followed by coordinated efforts to minimize or control their impact.'
          },
          {
            name: 'International Finance',
            description: 'Focuses on the financial interactions between countries, including currency exchange, investments, and regulations.'
          },
          {
            name: 'Financial Planning and Analysis',
            description: "Managing a company's financial health through analysis and strategic planning."
          },
          {
            name: 'Fintech and Emerging Technologies',
            description: 'Innovative technologies and their impact on the financial industry.'
          },
          {
            name: 'Behavioral Finance',
            description: "Investigates the psychological factors influencing investors' decisions and market dynamics."
          }
        ],
        'unknown_category' => {
          name: '',
          description: ''
        }
      }
    end

    def self.complexity
      {
        'description' => '',
        'categories' => [
          {
            name: 'Accessible',
            description: 'Simple hacks that are easy to implement by most people without requiring extensive financial knowledge or initial investment. Designed for users with any level of income and experience. Examples: Saving small amounts regularly, reducing non-essential expenses.'
          },
          {
            name: 'Intermediate',
            description: 'Hacks that require some planning, basic financial knowledge, or a moderate initial investment. Useful for people with medium incomes or some experience in managing their money. Examples: Investing while carrying debt, simple retirement planning strategies.'
          },
          {
            name: 'Advanced',
            description: 'More complex hacks requiring advanced financial knowledge or considerable sources. Often involve tax strategies, investment in complex assets, or sophisticated legal structures. Examples: Utilizing REITs and advanced tax strategies to maximize returns.'
          }
        ],
        'unknown_category' => {
          name: '',
          description: ''
        }
      }
    end
  end
end
