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
        hack_info = "#{hack['hack_title']}:\n#{hack['description']}"
        hack_advice = hack_or_advice(hack_info)
        Hack.create({ article: @article, init_title: hack['hack_title'], summary: hack['description'],
                      justification: hack['hack_justification'], is_advice: !hack_advice['is_hack'],
                      advice_justification: hack_advice['justification'] })
      end
      hacks_list
    end

    private

    def hack_or_advice(hack_info)
      prompt = Ai::Prompts.prompts[:HACK_ADVICE]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { hack_info: hack_info })
      hack_advice_analysis = @model.run(prompt_text)
      prompt = Ai::Prompts.prompts[:HACK_ADVICE_STRUCT]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { analysis: hack_advice_analysis })
      result = @model.run(prompt_text)
      result = result.gsub('json', '').gsub('```', '').strip
      JSON.parse(result)
    end

    def extract_hacks
      prompt = Ai::Prompts.prompts[:HACK_DISCRIMINATION]
      prompt_text = Ai::HackProcessor.build_prompt_text(prompt, { page_content: @article.content })
      result = @model.run(prompt_text)
      result = result.gsub('json', '').gsub('```', '').strip
      JSON.parse(result)
    end
  end
end
