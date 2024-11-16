module Ai
  class HackProcessor
    def initialize(hack)
      @hack = hack
      @model = Ai::LlmHandler.new('gemini-1.5-flash-8b')
    end

    def extend_hack!
      free_description = hack_description('FREE_DESCRIPTION')
      premium_description = hack_description('PREMIUM_DESCRIPTION', free_description)
      grown_descriptions = grow_descriptions(free_description, premium_description)
      free_structured = hack_structure(grown_descriptions[:free_description], 'STRUCTURED_FREE_DESCRIPTION')
      premium_structured = hack_structure(grown_descriptions[:premium_description], 'STRUCTURED_PREMIUM_DESCRIPTION')
      @hack.create_hack_structured_info!(free_title: free_structured['Hack Title'],
                                         description: free_structured['Description'],
                                         main_goal: free_structured['Main Goal'],
                                         steps_summary: free_structured['steps(Summary)'],
                                         resources_needed: free_structured['Resources Needed'],
                                         expected_benefits: free_structured['Expected Benefits'],
                                         premium_title: premium_structured['Extended Title'],
                                         detailed_steps: premium_structured['Detailed steps'],
                                         additional_tools_resources: premium_structured['Additional Tools and Resources'],
                                         case_study: premium_structured['Case Study'])
    end

    def classify_hack!
      structured = @hack.hack_structured_info
      classification_results = classification_from_free_description(structured)
      result_complexity = classification_results[:complexity]
      result_financial_categories = classification_results[:financial_categories]
      puts "result_complexity.keys #{result_complexity.keys}"
      complexity_category_name = result_complexity['category']
      complexity_justification = result_complexity['explanation']
      category_instance = Category.find_by_name(complexity_category_name)
      HackCategoryRel.create(
        hack: @hack,
        category: category_instance,
        justification: complexity_justification
      )

      financial_categories = result_financial_categories.map { |item| [item['category'], item['explanation']] }
      financial_categories.each do |category, explanation|
        category_instance = Category.find_by_name(category)
        HackCategoryRel.create(
          hack: @hack,
          category: category_instance,
          justification: explanation
        )
      end
    end

    def self.build_prompt_text(prompt_text, tags_to_replace = {})
      keys = tags_to_replace.keys
      tags = keys.map { |key| "[{#{key}}]" }
      tags.each_with_index { |tag, index| prompt_text.gsub!(tag, tags_to_replace[keys[index]].to_s) }
      prompt_text
    end

    private

    def hack_description(prompt_code, analysis = '')
      prompt = Ai::Prompts.prompts[prompt_code]
      prompt_text = build_prompt_text(prompt, { hack_title: @hack.title, hack_summary: @hack.summary, analysis: })
      @model.run(prompt_text)
    end

    def grow_descriptions(free_description, premium_description)
      prompt = Ai::Prompts.prompts[:ENRICH_FREE_DESCRIPTION]
      prompt_text = build_prompt_text(prompt, { page_content: @hack.article.content, metadata: @hack.article.metadata,
                                                previous_analysis: free_description })
      enriched_description_free = @model.run(prompt_text)
      prompt = Ai::Prompts.prompts[:ENRICH_PREMIUM_DESCRIPTION]
      prompt_text = build_prompt_text(prompt, { page_content: @hack.article.content, metadata: @hack.article.metadata,
                                                free_analysis: enriched_description_free, previous_analysis: premium_description })
      enriched_description_premium = @model.run(prompt_text)
      {
        free_description: enriched_description_free,
        premium_description: enriched_description_premium
      }
    end

    def hack_structure(description, prompt_code)
      prompt = Ai::Prompts.prompts[prompt_code]
      prompt_text = build_prompt_text(prompt, { analysis: description })
      system_prompt_text = prompt.system_prompt
      result = @model.run(prompt_text, system_prompt_text)
      JSON.parse(result.gsub("```json\n", '').gsub('```', '').strip)
    end

    def classification_from_free_description(structured)
      hack_title = structured[:hack_title]
      description = structured[:description]
      main_goal = structured[:main_goal]

      steps_summary = begin
        JSON.parse(structured[:steps_summary])
      rescue StandardError
        structured[:steps_summary]
      end
      free_description = ''
      free_description << "Hack Title\n"
      free_description << "#{hack_title}\n\n"
      free_description << "Description\n"
      free_description << "#{description}\n\n"
      free_description << "Main Goal\n"
      free_description << "#{main_goal}\n\n"
      free_description << "Steps to implement\n"
      if steps_summary.is_a?(Array)
        steps_summary.each do |step|
          free_description << "- #{step}\n"
        end
      else
        free_description << "#{steps_summary}\n\n"
      end
      get_hack_classifications(free_description)
    end

    def get_hack_classifications(free_description)
      prompt_complexity = Ai::Prompts.prompts[:COMPLEXITY_CLASSIFICATION]
      prompt_financial_categories = Ai::Prompts.prompts[:FINANCIAL_CLASSIFICATION]
      format_hash = { hack_description: free_description, metadata: @hack.article.metadata }
      prompt_text_complexity = prompt_complexity.build_prompt_text(format_hash)
      prompt_text_financial_categories = prompt_financial_categories.build_prompt_text(format_hash)
      begin
        result_complexity = @model.run(prompt_text_complexity, system_prompt_text)
        result_categories = @model.run(prompt_text_financial_categories, system_prompt_text)
        result_complexity = result_complexity.gsub("```json\n", '').gsub('```', '').strip
        result_categories = result_categories.gsub("```json\n", '').gsub('```', '').strip
        {
          complexity: JSON.parse(result_complexity),
          financial_categories: JSON.parse(result_categories)
        }
      rescue StandardError => e
        puts "Error in hack classification: #{e.message}"
        {
          complexity: nil,
          categories: nil
        }
      end
    end
  end
end
