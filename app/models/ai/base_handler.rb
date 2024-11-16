module Ai
  class BaseHandler
    GOOGLE_API_KEYS = ENV.fetch('GOOGLE_API_KEYS', '')

    MODELS = %w[gemini-1.5-flash gemini-1.5-flash-8b].freeze

    DEFAULT_SYSTEM_PROMPT = 'You are a helpful assistant. Answer all questions to the best of your ability.'.freeze

    def initialize(model_name = 'gemini-1.5-flash-8b', temperature = 0.7)
      @model_name = MODELS.include?(model_name) ? model_name : MODELS[1]
      @temperature = temperature

      @llm = load_gemini
    end

    def load_openai
      Langchain::LLM::OpenAI.new(
        api_key: OPENAI_API_KEY, default_options: { temperature: @temperature, chat_completion_model_name: @model_name,
                                                    embeddings_model_name: 'text-embedding-3-small' }
      )
    end

    def load_gemini
      keys = GOOGLE_API_KEYS.split(',')
      max = keys.size - 1
      Langchain::LLM::GoogleGemini.new(
        api_key: keys[rand(0..max)],
        default_options: { temperature: @temperature,
                           chat_completion_model_name: @model_name,
                           embeddings_model_name: 'text-embedding-004' }
      )
    end
  end
end
