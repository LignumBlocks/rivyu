class ProcessArticleJob < ApplicationJob
  queue_as :default

  def perform(id)
    article = Article.find(id)
    Ai::ArticleProcessor.new(article).create_hacks!
    article.reload
    article.hacks.each do |hack|
      hack_processor = Ai::HackProcessor.new(hack)
      hack_processor.extend_hack!
      hack_processor.classify_hack!
    end
  end
end
