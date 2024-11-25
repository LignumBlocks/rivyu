module Ai
  class HackProcessor
    def initialize(hack)
      @hack = hack
      @model = Ai::LlmHandler.new('gemini-1.5-flash-8b')
    end

    def scale_hack!
      scale = hack_scaling
      category_name = scale['category']
      explanation = scale['explanation']
      classification_instance = Classification.find_by_name('Complexity Scale')
      categories = classification_instance.categories
      # Find the specific category by name within that classification
      category_instance = categories.find_by(name: category_name)

      HackCategory.create(
        hack: @hack,
        category: category_instance,
        justification: explanation
      )
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
      classification_results.each do |classification_name, classification_data|
        next if classification_data.nil? # Skip if classification failed

        classification_data.each do |category_hash|
          category_name = category_hash['category']
          explanation = category_hash['explanation']
          classification_instance = Classification.find_by_name(classification_name)
          categories = classification_instance.categories
          # Find the specific category by name within that classification
          category_instance = categories.find_by(name: category_name)

          HackCategory.create(
            hack: @hack,
            category: category_instance,
            justification: explanation
          )
        end
      end
    end

    def self.build_prompt_text(prompt_text, tags_to_replace = {})
      keys = tags_to_replace.keys
      tags = keys.map { |key| "[{#{key}}]" }
      tags.each_with_index { |tag, index| prompt_text.gsub!(tag, tags_to_replace[keys[index]].to_s) }
      prompt_text
    end

    private

    def hack_scaling
      description = "#{@hack.free_title}:\n\n#{@hack.description}"
      prompt = Ai::Prompts.prompts[:COMPLEXITY_CLASSIFICATION]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { hack_description: description })
      result = @model.run(prompt_text)
      result = result.gsub('json', '').gsub('```', '').strip
      JSON.parse(result)
    end

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
      free_description << "Resources Needed\n"
      free_description << "#{@hack.resources_needed}\n\n"
      free_description << "Expected Benefits\n"
      free_description << "#{@hack.expected_benefits}\n\n"
      free_description
    end

    def get_hack_classifications
      free_description = free_from_structured
      format_hash = { hack_summary: @hack.summary, hack_description: free_description,
                      metadata: @hack.article.metadata }
      classifications = {}
      class_and_cat_hash = Ai::ClassificationCategories.classifications_and_categories
      class_and_cat_hash.each do |class_name, class_data|
        prompt_key = class_data[:type] == 'single_cat' ? :GENERIC_SINGLE_CATEGORY_CLASSIFICATION : :GENERIC_MULTI_CATEGORY_CLASSIFICATION
        prompt = Ai::Prompts.prompts[prompt_key]
        explained_categories = class_data[:categories].map do |cat|
          "- #{cat[:name]}: #{cat[:description]}\n"
        end.join('')
        prompt_data = format_hash.merge({
                                          class_name: class_name.to_s,
                                          classification_description: class_data[:description],
                                          explained_categories: explained_categories
                                        })
        prompt_text = Ai::HackProcessor.build_prompt_text(prompt, prompt_data)
        result = @model.run(prompt_text)
        result = result.gsub("```json\n", '').gsub('```', '').strip
        parsed = JSON.parse(result)
        classifications[class_name.to_s] = class_data[:type] == 'single_cat' ? [parsed] : parsed
      end
      classifications
    end
  end
end
