module Ai
  class ArticleProcessor
    def initialize(article)
      @article = article
      @model = Ai::LlmHandler.new('gemini-1.5-flash-8b')
    end

    def create_hacks!
      article_hack_extraction = extract_hacks
      @article.content_summary = article_hack_extraction['content_summary']
      hacks_in_article = article_hack_extraction['are_hacks']
      @article.are_hacks = hacks_in_article
      @article.justification = article_hack_extraction['justification']
      hacks_list = article_hack_extraction['hacks_list']
      @article.save
      return [] unless hacks_in_article

      hacks_list.each do |hack|
        hack_info = "#{hack['hack_title']}:\n#{hack['brief_description']}"
        hack_advice = hack_or_advice(hack_info)
        Hack.create({ article: @article, init_title: hack['hack_title'], summary: hack['brief_description'],
                      justification: hack['hack_justification'], is_advice: hack_advice['classification'],
                      advice_justification: hack_advice['explanation'] })
      end
      hacks_list
    end

    private

    def hack_or_advice(hack_info)
      prompt = Ai::Prompts.prompts[:HACK_ADVICE]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { hack_info: hack_info })
      result = @model.run(prompt_text)
      result = result.gsub('json', '').gsub('```', '').strip
      JSON.parse(result)
    end

    def extract_hacks
      # prompt = Ai::Prompts.prompts[:CHAIN_OF_THOUGHT]
      # prompt_text = Ai::HackProcessor.build_prompt_text(prompt,
      #                                                   { metadata: @article.metadata, page_content: @article.content })
      # chain_of_thought = @model.run(prompt_text)
      # prompt = Ai::Prompts.prompts[:VERIFICATION_REVIEW]
      # prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { analysis_output: chain_of_thought })
      # review = @model.run(prompt_text)
      # prompt = Ai::Prompts.prompts[:HACK_VERIFICATION]
      # prompt_text = Ai::HackProcessor.build_prompt_text(prompt,
      #                                                   { page_content: @article.content, analysis_output: review })
      prompt = Ai::Prompts.prompts[:HACK_DISCRIMINATION]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { page_content: @article.content })
      result = @model.run(prompt_text)
      result = result.gsub('json', '').gsub('```', '').strip
      File.open('log.md', 'a+') do |f|
        f.write("\n#{@article.link}:\n---\n#{result}\n")
      end
      JSON.parse(result)
    end
  end
end
