module Ai
  class LlmHandler < BaseHandler
    attr_reader :model_name, :llm

    def initialize(model_name = 'gemini-1.5-flash-8b', temperature = 0.5)
      super(model_name, temperature)
    end

    # Executes a conversation with the LLM based on the provided input and optional system prompt.
    def run(input, system_prompt = '')
      if system_prompt.empty?
        messages = [{ role: 'user', parts: [{ text: input }] }]
      else
        messages = [
          { role: 'user', parts: [{ text: system_prompt }, { text: input }] }
        ]
      end
      response = @llm.chat(messages:)
      response.chat_completion
    end
  end
end
