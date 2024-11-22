module HacksHelper
  def render_json(json)
    content_tag(:ul) do
      json.map do |key, value|
        content_tag(:li) do
          if value.is_a?(Hash)
            "#{key.capitalize}: #{render_json(value)}".html_safe
          elsif value.is_a?(Array)
            "#{key.capitalize}: #{value.to_sentence}".html_safe
          else
            "#{key.capitalize}: #{value}".html_safe
          end
        end
      end.join.html_safe
    end
  end
end
