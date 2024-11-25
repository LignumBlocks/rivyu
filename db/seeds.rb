# Source.all.destroy_all
# sources = [
#  { name: 'Consumer Finance', link: 'https://www.consumerfinance.gov/about-us/blog/' },
#  { name: 'Money Management', link: 'https://www.moneymanagement.org/blog' },
#  { name: 'Investopedia', link: 'https://www.investopedia.com' }
# ]

# sources = [
#   { name: 'Investopedia', link: 'https://www.investopedia.com' }
# ]

# sources.each { |source| Source.create(source) }

# # Crear clasificaciones
# HackCategory.all.destroy_all
# Category.all.destroy_all
# Classification.all.destroy_all

#
# popularity_classification = Classification.create(name: 'Popularity')
# Category.create([
#                   { name: 'Widely Known', description: 'Hacks that are commonly recognized and frequently used by the general public.',
#                     classification: popularity_classification },
#                   { name: 'Moderately Known',
#                     description: 'Hacks that are familiar within certain groups or require some research to discover.', classification: popularity_classification },
#                   { name: 'Little Known', description: 'Hacks that are rare, niche, or not widely publicized.',
#                     classification: popularity_classification },
#                   { name: 'Unknown Popularity', description: 'When the popularity of the hack is unclear or not easily categorized.',
#                     classification: popularity_classification }
#                 ])
#
# financial_topic_classification = Classification.create(name: 'Specific Financial Topic')
# Category.create([
#                   { name: 'Banking and Financial Services', description: 'Hacks related to bank accounts, fees, and banking services',
#                     classification: financial_topic_classification },
#                   { name: 'Credit Cards', description: 'Strategies specifically focused on managing and optimizing credit card usage.',
#                     classification: financial_topic_classification },
#                   { name: 'Loans and Debt Management',
#                     description: 'Hacks aimed at managing, reducing, or refinancing loans and debts.', classification: financial_topic_classification },
#                   { name: 'Real Estate and Housing', description: 'Hacks for buying, selling, or investing in property.',
#                     classification: financial_topic_classification },
#                   { name: 'Budgeting and Saving', description: 'Methods to save money and manage personal budgets.',
#                     classification: financial_topic_classification },
#                   { name: 'Tax Strategies', description: 'Hacks to legally reduce tax liabilities.',
#                     classification: financial_topic_classification },
#                   { name: 'Retirement Planning', description: 'Tips for securing financial stability in retirement.',
#                     classification: financial_topic_classification },
#                   { name: 'Insurance', description: 'Strategies related to various insurance products.',
#                     classification: financial_topic_classification },
#                   { name: 'Investments', description: 'Hacks focused on investing strategies to grow wealth.',
#                     classification: financial_topic_classification },
#                   { name: 'Education Funding', description: 'Hacks for saving on education costs.',
#                     classification: financial_topic_classification },
#                   { name: 'No Specific Topic', description: 'Hacks that do not fit into any particular financial topic.',
#                     classification: financial_topic_classification }
#                 ])
#
# audience_classification = Classification.create(name: 'Audience and Life Stage')
# Category.create([
#                   { name: 'Students and Young Adults',
#                     description: 'Hacks suited for individuals in their educational or early career stages.', classification: audience_classification },
#                   { name: 'Families', description: 'Hacks designed to help households manage collective finances.',
#                     classification: audience_classification },
#                   { name: 'Professionals and Entrepreneurs',
#                     description: 'Hacks tailored for working individuals and business owners.', classification: audience_classification },
#                   { name: 'Retirees', description: 'Hacks aimed at those who have retired or are nearing retirement.',
#                     classification: audience_classification },
#                   { name: 'High Net Worth Individuals', description: 'Hacks for individuals with significant financial assets.',
#                     classification: audience_classification },
#                   { name: 'General Audience',
#                     description: 'Hacks that are applicable to a broad range of users regardless of specific demographics.', classification: audience_classification }
#                 ])
#
# time_horizon_classification = Classification.create(name: 'Time Horizon')
# Category.create([
#                   { name: 'Short Term', description: 'Hacks that provide immediate or near-immediate financial gains.',
#                     classification: time_horizon_classification },
#                   { name: 'Medium Term', description: 'Hacks that yield benefits over a moderate period, typically within a year.',
#                     classification: time_horizon_classification },
#                   { name: 'Long Term',
#                     description: 'Hacks that offer financial advantages over an extended period, often several years.', classification: time_horizon_classification },
#                   { name: 'Unspecified Time Horizon', description: 'When the time frame for benefits is unclear or not defined.',
#                     classification: time_horizon_classification }
#                 ])
#
# risk_level_classification = Classification.create(name: 'Risk Level')
# Category.create([
#                   { name: 'Low Risk', description: 'Hacks that involve minimal financial risk and are generally safe.',
#                     classification: risk_level_classification },
#                   { name: 'Moderate Risk', description: 'Hacks that carry a balanced level of risk and potential reward.',
#                     classification: risk_level_classification },
#                   { name: 'High Risk', description: 'Hacks that involve significant financial risk and potential for loss.',
#                     classification: risk_level_classification },
#                   { name: 'Unknown Risk Level',
#                     description: 'When the risk associated with the hack is unclear or not easily assessable.', classification: risk_level_classification }
#                 ])
#
# implementation_classification = Classification.create(name: 'Implementation Difficulty')
# Category.create([
#                   { name: 'Minimal Effort',
#                     description: 'Hacks that can be implemented quickly with little to no additional resources or complex steps.', classification: implementation_classification },
#                   { name: 'Moderate Effort', description: 'Hacks that require a moderate amount of time, resources, or planning.',
#                     classification: implementation_classification },
#                   { name: 'Significant Effort', description: 'Hacks that demand substantial time, resources, or complex planning.',
#                     classification: implementation_classification },
#                   { name: 'Unknown Implementation Effort',
#                     description: 'Use this category when the level of effort required to implement the hack is unclear or cannot be easily determined.', classification: implementation_classification }
#                 ])
#
# financial_goals_classification = Classification.create(name: 'Financial Goals')
# Category.create([
#                   { name: 'Debt Reduction', description: 'Hacks aimed at minimizing or eliminating debt.',
#                     classification: financial_goals_classification },
#                   { name: 'Wealth Building', description: 'Hacks focused on increasing overall financial wealth.',
#                     classification: financial_goals_classification },
#                   { name: 'Income Generation', description: 'Hacks designed to create additional streams of income.',
#                     classification: financial_goals_classification },
#                   { name: 'Expense Management', description: 'Hacks that help control or reduce expenses.',
#                     classification: financial_goals_classification },
#                   { name: 'Other Financial Goals', description: 'Hacks that align with financial objectives not explicitly listed.',
#                     classification: financial_goals_classification }
#                 ])
#
# knowledge_level_classification = Classification.create(name: 'Knowledge Level Required')
# Category.create([
#                   { name: 'Beginner', description: 'Hacks that require basic financial knowledge.',
#                     classification: knowledge_level_classification },
#                   { name: 'Intermediate', description: 'Hacks that require a moderate understanding of financial concepts.',
#                     classification: knowledge_level_classification },
#                   { name: 'Advanced', description: 'Hacks that necessitate a deep or sophisticated understanding of finance.',
#                     classification: knowledge_level_classification },
#                   { name: 'Unknown Literacy Level', description: 'When the required financial knowledge for the hack is unclear.',
#                     classification: knowledge_level_classification }
#                 ])
hacks_scale = Classification.create(name: 'Complexity Scale')
Category.create([
                  { name: 'Basic', description: 'Simple hacks that are easy to implement by most people without requiring extensive financial knowledge or initial investment. Designed for users with any level of income and experience.',
                    classification: hacks_scale },
                  { name: 'Intermediate', description: 'Hacks that require some planning, basic financial knowledge, or a moderate initial investment. Useful for people with medium incomes or some experience in managing their money.',
                    classification: hacks_scale },
                  { name: 'Advanced', description: 'More complex hacks requiring advanced financial knowledge or considerable sources. Often involve tax strategies, investment in complex assets, or sophisticated legal structures.',
                    classification: hacks_scale }
                ])
# load(Rails.root.join('db/seeds/development/hacks.rb')) if Rails.env.development?
