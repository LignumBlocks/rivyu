User.all.destroy_all
Role.all.destroy_all

role = Role.create!(name: 'admin')

admin = User.create!(email: 'admin@hintsly.dev', password: 'password', password_confirmation: 'password')
admin.roles << role

Source.all.destroy_all
sources = [
  { name: 'Consumer Finance', link: 'https://www.consumerfinance.gov/about-us/blog/' },
  { name: 'Money Managment', link: 'https://www.moneymanagement.org/blog' }
]

sources.each { |source| Source.create(source) }

# Crear clasificaciones
HackCategory.all.destroy_all
Category.all.destroy_all
Classification.all.destroy_all

financial_classification = Classification.create(name: 'Financial')
complexity_classification = Classification.create(name: 'Complexity')

# Crear categorías para Financial_categories
Category.create([
                  { name: 'Corporate Finance',
                    description: 'Financial activities of corporations, including investment decisions, financial management, and capital structure.', classification: financial_classification },
                  { name: 'Investment Management',
                    description: 'Strategies and practices of managing financial assets to maximize returns.', classification: financial_classification },
                  { name: 'Personal Finance',
                    description: 'Management of individual or household financial activities, including budgeting, saving, and investing.', classification: financial_classification },
                  { name: 'Financial Markets',
                    description: 'Facilitate the trading of financial instruments and play a key role in the allocation of sources. Including stock market, bond market, and derivative market.', classification: financial_classification },
                  { name: 'Public Finance',
                    description: 'Studies the role of the government in the economy, including taxation, spending, and debt management.', classification: financial_classification },
                  { name: 'Banking and Financial Institutions',
                    description: 'Examines banking systems and financial institutions that provide financial services to individuals and businesses.', classification: financial_classification },
                  { name: 'Risk Management',
                    description: 'Identifies, assesses, and prioritizes risks followed by coordinated efforts to minimize or control their impact.', classification: financial_classification },
                  { name: 'International Finance',
                    description: 'Focuses on the financial interactions between countries, including currency exchange, investments, and regulations.', classification: financial_classification },
                  { name: 'Financial Planning and Analysis',
                    description: "Managing a company's financial health through analysis and strategic planning.", classification: financial_classification },
                  { name: 'Fintech and Emerging Technologies',
                    description: 'Innovative technologies and their impact on the financial industry.', classification: financial_classification },
                  { name: 'Behavioral Finance',
                    description: "Investigates the psychological factors influencing investors' decisions and market dynamics.", classification: financial_classification }
                ])

# Crear categorías para Complexity
Category.create([
                  { name: 'Accessible',
                    description: 'Simple hacks that are easy to implement by most people without requiring extensive financial knowledge or initial investment. Designed for users with any level of income and experience. Examples: Saving small amounts regularly, reducing non-essential expenses.', classification: complexity_classification },
                  { name: 'Intermediate',
                    description: 'Hacks that require some planning, basic financial knowledge, or a moderate initial investment. Useful for people with medium incomes or some experience in managing their money. Examples: Investing while carrying debt, simple retirement planning strategies.', classification: complexity_classification },
                  { name: 'Advanced',
                    description: 'More complex hacks requiring advanced financial knowledge or considerable sources. Often involve tax strategies, investment in complex assets, or sophisticated legal structures. Examples: Utilizing REITs and advanced tax strategies to maximize returns.', classification: complexity_classification }
                ])

load(Rails.root.join('db/seeds/development/hacks.rb')) if Rails.env.development?
