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
      return unless hacks_in_article

      hacks_list.each do |hack|
        @article.create_hack(init_title: hack['hack_title'], summary: hack['brief_description'],
                             justification: hack['hack_justification'])
      end
    end

    private

    def extract_hacks
      prompt = Ai::Prompts.prompts[:CHAIN_OF_THOUGHT]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt,
                                                        { metadata: @article.metadata, page_content: @article.content })
      chain_of_thought = @model.run(prompt_text)
      prompt = Ai::Prompts.prompts[:VERIFICATION_REVIEW]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { analysis_output: chain_of_thought })
      review = @model.run(prompt_text)
      prompt = Ai::Prompts.prompts[:HACK_VERIFICATION]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt,
                                                        { page_content: @article.content, analysis_output: review })
      result = @model.run(prompt_text)
      # puts result
      # puts '----------'
      result = result.gsub('json', '').gsub('```', '').strip
      # puts result
      JSON.parse(result)
    end
  end
end
