module Ai
  class HackProcessor
    def initialize(hack)
      @hack = hack
      @model = Ai::LlmHandler.new('gemini-1.5-flash-8b')
    end

    def extend_hack!
      free_description = hack_description('FREE')
      premium_description = hack_description('PREMIUM', free_description)
      grown_descriptions = grow_descriptions(free_description, premium_description)
      free_structured = hack_structure(grown_descriptions[:free_description], 'FREE')
      premium_structured = hack_structure(grown_descriptions[:premium_description], 'PREMIUM')
      @hack.free_title = free_structured['Hack Title']
      @hack.description = free_structured['Description']
      @hack.main_goal = free_structured['Main Goal']
      @hack.steps_summary = free_structured['steps(Summary)']
      @hack.resources_needed = free_structured['Resources Needed']
      @hack.expected_benefits = free_structured['Expected Benefits']
      @hack.premium_title = premium_structured['Extended Title']
      @hack.detailed_steps = premium_structured['Detailed steps']
      @hack.additional_tools_resources = premium_structured['Additional Tools and Resources']
      @hack.case_study = premium_structured['Case Study']
      @hack.save
    end

    def classify_hack!
      classification_results = get_hack_classifications
      result_complexity = classification_results[:complexity]
      result_financial_categories = classification_results[:financial_categories]
      complexity_category_name = result_complexity['category']
      complexity_justification = result_complexity['explanation']
      category_instance = Category.find_by_name(complexity_category_name)
      HackCategory.create(
        hack: @hack,
        category: category_instance,
        justification: complexity_justification
      )

      financial_categories = result_financial_categories.map { |item| [item['category'], item['explanation']] }
      financial_categories.each do |category, explanation|
        category_instance = Category.find_by_name(category)
        HackCategory.create(
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
      prompt = if prompt_code == 'FREE'
                 Ai::Prompts.prompts[:FREE_DESCRIPTION]
               else
                 Ai::Prompts.prompts[:PREMIUM_DESCRIPTION]
               end
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt,
                                                        { hack_title: @hack.init_title, hack_summary: @hack.summary,
                                                          analysis: })
      @model.run(prompt_text)
    end

    def grow_descriptions(free_description, premium_description)
      prompt = Ai::Prompts.prompts[:ENRICH_FREE_DESCRIPTION]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { page_content: @hack.article.content, metadata: @hack.article.metadata,
                                                                  previous_analysis: free_description })
      enriched_description_free = @model.run(prompt_text)
      prompt = Ai::Prompts.prompts[:ENRICH_PREMIUM_DESCRIPTION]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { page_content: @hack.article.content, metadata: @hack.article.metadata,
                                                                  free_analysis: enriched_description_free, previous_analysis: premium_description })
      enriched_description_premium = @model.run(prompt_text)
      {
        free_description: enriched_description_free,
        premium_description: enriched_description_premium
      }
    end

    def hack_structure(description, prompt_code)
      prompt = if prompt_code == 'FREE'
                 Ai::Prompts.prompts[:STRUCTURED_FREE_DESCRIPTION]
               else
                 Ai::Prompts.prompts[:STRUCTURED_PREMIUM_DESCRIPTION]
               end
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { analysis: description })
      result = @model.run(prompt_text)
      JSON.parse(result.gsub("```json\n", '').gsub('```', '').strip)
    end

    def free_from_structured
      free_description = ''
      free_description << "Hack Title\n"
      free_description << "#{@hack.free_title}\n\n"
      free_description << "Description\n"
      free_description << "#{@hack.description}\n\n"
      free_description << "Main Goal\n"
      free_description << "#{@hack.main_goal}\n\n"
      free_description << "Steps to Implement\n"
      free_description << "#{@hack.steps_summary}\n\n"
      free_description
    end

    def get_hack_classifications
      free_description = free_from_structured
      prompt_complexity = Ai::Prompts.prompts[:COMPLEXITY_CLASSIFICATION]
      prompt_financial_categories = Ai::Prompts.prompts[:FINANCIAL_CLASSIFICATION]
      format_hash = { hack_description: free_description, metadata: @hack.article.metadata }
      prompt_text_complexity = Ai::HackProcessor.build_prompt_text(prompt_complexity, format_hash)
      prompt_text_financial_categories = Ai::HackProcessor.build_prompt_text(prompt_financial_categories, format_hash)
      begin
        result_complexity = @model.run(prompt_text_complexity)
        result_categories = @model.run(prompt_text_financial_categories)
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
