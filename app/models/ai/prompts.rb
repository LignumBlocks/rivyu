module Ai
  # prompts hash
  class Prompts
    def self.prompts
      {
        'CHAIN_OF_THOUGHT': "You are an expert financial analyst. Review the following content:\nMetadata:\n```\n[{metadata}]\n```\nContent:\n```\n[{page_content}]\n```\n
Analyze it step by step to identify any practical financial strategies or techniques that could help individuals optimize their finances, save money, increase income, or improve their overall economic situation. They should have measurable financial value, originality, clear applicability, legality, clear explanation and demonstrable impact.
A financial hack is defined as:
- Practical: A strategy that can be implemented easily by individuals.
- Measurable: Provides a clear financial benefit (e.g., specific savings or increased income).
- Original: Offers something innovative or less commonly known, avoiding generic advice.
- Applicable: Tailored to specific situations, considering the user's profile (income, age, goals).
- Legal and Ethical: Complies with legal standards and avoids high-risk or unethical practices.
- Relevant: Useful in the current financial or economic context.
First, summarize the main topics discussed. Then, evaluate each topic to determine if it includes any financial hack with the described characteristics.",

        'VERIFICATION_REVIEW': "As a financial verification expert, review the analysis below to identify any practical financial strategies or techniques that could help individuals optimize their finances, save money, increase income, or improve their overall economic situation.
Identify financial hacks based on the following criteria: measurable financial value, originality, clear applicability, legality, clear explanation and demonstrable impact.
The analysis is as follows:\n```\n[{analysis_output}]\n```\nYour task:
1. Verify whether any described strategies meet these criteria. If so, list each financial hack with a short description, highlighting the specific financial benefit, how to apply it and the user conditions and resources needed.
2. If none meet the criteria, respond with: 'No qualifying financial hacks were identified in this content.' and explain why.",

        'HACK_VERIFICATION': "You are a financial analysis expert tasked with generating a structured summary of identified financial hacks. Use the following definitions to categorize and validate strategies:
- Financial Hack: A practical, measurable, original, and actionable strategy with clear steps and user-specific conditions.
- Financial Advice: General recommendations that lack originality, specificity, or measurable outcomes.\n
Content:\n[{page_content}]\nPrevious Analysis:\n[{analysis_output}]\n\n
Your task:\n1. Categorize the identified strategies into Financial Hacks or Financial Advice.\n2. Generate a JSON object in the following format:
```json
{
   \"content_summary\": \"<Summary of the main points of the content>\",
   \"are_hacks\": <Boolean: true if financial hacks were identified, otherwise false>,
   \"justification\": \"<Explanation of why the strategies were categorized as hacks or advice, in Markdown format>\",
   \"hacks_list\": [
       {
          \"hack_title\": \"<Title of the hack>\",
          \"brief_description\": \"<Summary of the hack, highlighting its financial benefit, application, and required conditions>\",
          \"hack_justification\": \"<Markdown-formatted explanation of why this qualifies as a hack, emphasizing originality, measurable impact, and relevance>\"
       }
    ],
   \"advice_list\": [
       {
          \"advice_title\": \"<Title of the general advice>\",
          \"reason_not_a_hack\": \"<Explanation of why this is categorized as advice and not a hack>\"
       }
    ]
}\n```\n
3. Filtering Guidelines:
   - Exclude advice that is generic or lacks measurable financial benefits.
   - Ensure each hack includes detailed steps, financial benefits, and user conditions.
   - If no hacks qualify, set `'are_hacks': false` and explain why in the justification.",

        'FREE_DESCRIPTION': "You are an expert financial analyst with a deep understanding of financial hacks and strategies.\nThis is a financial hack information.
Initial hack title:\n[{hack_title}]\n---\nBrief summary:\n[{hack_summary}]\n---\n
Your task is to provide a comprehensive analysis of the financial hack described above, adhering to the following guidelines. The result will be read directly by a user, keep that in mind. The analysis should be deeply detailed, structured, and articulate, providing the user with a clear understanding of this financial hack and its implications. Only answer about the indications in the guideline. The style should be in 2nd person, speaking to a user. Never mention 'this hack', substitute that for a reference to the title. Adapt examples and terminology to the user's region or state within the USA. Align with current laws and regulations in the USA and specific states.
Write it like a Medium post about financial strategies advices.\n\nThe format should follow this structure and guidelines:\n
# Hack Title:\n  Provide a concise and engaging title for the hack.\n
## Description:\n  Summarize the hack's concept and benefits in 2-3 sentences. Highlight how the hack improves the user's financial situation or habits. Make it concise and objective\n
## Main Goal:\n  Clearly state the hack's primary purpose in one sentence.\n
## Steps for Implementation (Summary):\n  List 3-5 concise, actionable steps for the user to implement the hack.\n  Ensure the steps are clear and simple enough for any user to follow without advanced knowledge.\n
## Resources Needed:\n  List the essential tools, apps, or bank accounts necessary to implement the strategy effectively (e.g., specific apps, online banks, calculators).\n
## Expected Benefits:\n  Briefly outline the financial or psychological benefits of applying the hack (e.g., improved savings discipline, accelerated debt payoff, reduced stress, etc.).",

        'PREMIUM_DESCRIPTION': "You are an expert financial analyst with a deep understanding of financial hacks and strategies.\n
Initial hack title:\n[{hack_title}]\n---\nBrief summary:\n[{hack_summary}]\n---\nSimplified analysis\n[{analysis}]\n---\n
Your task is to provide a comprehensive analysis of the financial hack described above, adhering to the following guidelines. The result will be read directly by a user, keep that in mind.\nYour Analysis should be deeply detailed, structured, and articulate, providing the user with a clear understanding of this financial hack and its implications. Only answer about the indications in the guideline. The style should be in 2nd person, speaking to a user. Never mention 'this hack', substitute that for a reference to the title. Adapt examples and terminology to the user's region or state within the USA. Align with current laws and regulations in the USA and specific states.
Write it like a Medium post about financial strategies advices.\n\nThe format should follow this structure and guidelines:\n
# Extended Title:\n  Provide an extended version of the title in the `Simplified analysis` to reflect the in-depth content.\n
## Detailed Steps for Implementation:\n  Offer an extended breakdown of each step listed in the `Simplified analysis`, including additional details and context to optimize the hack.\n  Ensure the steps are clear for any user to follow without advanced knowledge.\n  Include personalized tips, tricks, and insights to help the users tailor the strategy to their personal finances.\n  Explain advanced considerations that could help users maximize the hack.\n
## Additional Tools and Resources:\n  Suggest advanced apps, bank accounts that users can use to enhance the strategy.\n  Provide recommendations for tools that offer more complex tracking, customization, or integration with other financial plans (e.g., debt payoff calculators, investment tools, detailed budgeting systems).\n
## Case Study Outline:\n  Provide a brief outline for a realistic case study that demonstrates how a hypothetical user applies the hack and benefits from it.",

        'ENRICH_FREE_DESCRIPTION': "Your task is to analyze each section in the hack description and extend it with the information provided in the context.\n
Context containing relevant information:\n```\n[{page_content}]\n```\n---\nMetadata:\n```\n[{metadata}]\n```\n---\nHack description:\n[{previous_analysis}]\n---\n
Analyze each section in the hack description and expand it with the information provided. The analysis should be deeply detailed, structured, and articulate, providing the user with a clear understanding of this financial hack and its implications. Only answer about the indications in the guideline. The style should be in 2nd person, speaking to a user. Never mention 'this hack', substitute that for a reference to the title.\nMaintain the structure and the speech style from the `Hack description`. The title must be concise and engaging, don't change it if it is not necessary.\n
Write it like a Medium post about financial strategies advices.\n\nThe format should follow this structure and guidelines:\n
# Hack Title:\n  Concise and engaging title for the hack.\n
## Description:\n  Summarized hack's concept and benefits. Objective analysis of how the hack improves the user's financial situation or habits.\n
## Main Goal:\n  Hack's primary purpose.\n
## Steps for Implementation (Summary):\n  3-5 concise, actionable steps to implement the hack. Clear and simple enough for any user to follow without advanced knowledge.\n
## Resources Needed:\n  List of the essential tools, apps, or bank accounts necessary to implement the strategy effectively.\n
## Expected Benefits:\n  Outline of the benefits of applying the hack.",

        'ENRICH_PREMIUM_DESCRIPTION': "Your task is to analyze each section in the hack description and extend it with the information provided in the context.\n
Context containing relevant information:\n```\n[{page_content}]\n```\n---\nMetadata:\n```\n[{metadata}]\n```\n---\nSimplified analysis:\n[{free_analysis}]\n---\nHack description:\n[{previous_analysis}]\n---\n
Analyze each section in the hack description and expand it with the information provided.\nThe analysis should be deeply detailed, structured, and articulate, providing the user with a clear understanding of this financial hack and its implications. Only answer about the indications in the guideline. The style should be in 2nd person, speaking to a user. Never mention 'this hack', substitute that for a reference to the title or with 'this idea', 'this technique' and similars.\nMaintain the structure and the speech style from the `Hack description`. The title must be concise and engaging, don't change it if it is not necessary.\n
Write it like a Medium post about financial strategies advices.\n\nThe format should follow this structure and guidelines:\n
# Extended Title:\n  Extended version of the title in the `Simplified analysis` to reflect the in-depth content.\n
## Detailed Steps for Implementation:\n  Extended breakdown of each step listed in the `Simplified analysis`, including additional details and context to optimize the hack. The steps must br clear for any user to follow without advanced knowledge. With advanced considerations that could help users maximize the benefits of the hack.\n
## Additional Tools and Resources:\n  Advanced apps, bank accounts and services that users can use to enhance the strategy. Recommendations for tools that offer more complex tracking, customization, or integration with other financial plans (e.g., debt payoff calculators, investment tools, detailed budgeting systems).\n
## Case Study Outline:\n  Brief outline for a realistic case study that demonstrates how a hypothetical user applies the hack and benefits from it.",

        'STRUCTURED_FREE_DESCRIPTION': "Your task is to structure the provided analysis into a json dictionary.\n\nHack analysis:\n[{analysis}]\n---\n
Maintain the markdown text style inside the JSON. Below is a guide for the expected JSON object, if in the text a field is missing fill it as null.\n
Expected JSON structure:\n{\n    \"Hack Title\": \"<title>\",\n    \"Description\": \"<description>\",\n    \"Main Goal\": \"<goal or purpose>\",\n    \"steps(Summary)\": <steps>,
    \"Resources Needed\": <sources>,    \"Expected Benefits\": <benefits>\n}\n
Don't add or remove words. Nothing should be in list format, only string. Provide your response only as a JSON object containing the structured information provided.",

        'STRUCTURED_PREMIUM_DESCRIPTION': "Your task is to structure the provided analysis into a json dictionary.\n\nHack analysis:\n[{analysis}]\n---\n
Maintain the markdown text style inside the JSON. Below is a guide for the expected JSON object, if in the text a field is missing fill it as null.\n
Expected JSON structure:\n{\n    \"Extended Title\": \"<extended title>\",
    \"Detailed steps\": <steps>,\n    \"Additional Tools and Resources\": <sources>,\n    \"Case Study\": \"<case study>\"\n}\n
Don't add or remove words. Nothing should be in list format, only string. Provide your response only as a JSON object containing the structured information provided.",

        'COMPLEXITY_CLASSIFICATION': "Classify the financial hack into one of the following categories, based on its complexity, accessibility, and level of financial impact:\n
1. *Accessible*:\n   - *Description*: Simple hacks that are easy to implement by most people without requiring extensive financial knowledge or initial investment. Designed for users with any level of income and experience.\n   - *Examples*: Saving small amounts regularly, reducing non-essential expenses.\n
2. *Intermediate*:\n   - *Description*: Hacks that require some planning, basic financial knowledge, or a moderate initial investment. Useful for people with medium incomes or some experience in managing their money.\n   - *Examples*: Investing while carrying debt, simple retirement planning strategies.\n
3. *Advanced*:\n   - *Description*: More complex hacks requiring advanced financial knowledge or considerable sources. Often involve tax strategies, investment in complex assets, or sophisticated legal structures.\n   - *Examples*: Utilizing REITs and advanced tax strategies to maximize returns.\n
## Brief summary:\n[{hack_summary}]\n---\n## Financial hack:\n---\n[{hack_description}]\n---\n## Related metadata:\n```\n[{metadata}]\n```\n
Provide your response only as a JSON object with the values as plain strings, no markdown; in the following format:\n```json\n
{\n    \"category\": \"<Accessible, Intermediate or Advanced>\",\n    \"explanation\": \"<A short explanation regarding the classification>\",\n}\n```",

        'FINANCIAL_CLASSIFICATION': "Bellow you will be provided with a financial hack. According to the following financial categories state the applicable tags to the provided information.\n
## Financial categories:\n
- `Corporate Finance`: financial activities of corporations, including investment decisions, financial management, and capital structure.
- `Investment Management`: strategies and practices of managing financial assets to maximize returns.
- `Personal Finance`: management of individual or household financial activities, including budgeting, saving, and investing.
- `Financial Markets`:  facilitate the trading of financial instruments and play a key role in the allocation of sources. Including stock market, bond market and derivative market.
- `Public Finance`: studies the role of the government in the economy, including taxation, spending, and debt management.
- `Banking and Financial Institutions`: examines banking systems and financial institutions that provide financial services to individuals and businesses.
- `Risk Management`: identifies, assesses, and prioritizes risks followed by coordinated efforts to minimize or control their impact.
- `International Finance`: focuses on the financial interactions between countries, including currency exchange, investments, and regulations.
- `Financial Planning and Analysis`: managing a company's financial health through analysis and strategic planning.
- `Fintech and Emerging Technologies`: innovative technologies and their impact on the financial industry.
- `Behavioral Finance`: investigates the psychological factors influencing investors' decisions and market dynamics.\n
## Brief summary:\n[{hack_summary}]\n---\n## Financial hack:\n---\n[{hack_description}]\n---\n## Related metadata:\n```\n[{metadata}]\n```\n
If there is more than one category fitting then return them all. Provide your response only as a JSON object, in the following format:\n
Example for more than one tag:\n```json
[\n  {\n    \"category\": \"<category with the same name as it was listed>\",\n    \"explanation\": \"<A short explanation regarding the classification>\"\n  },\n  {\n    \"category\": \"<category with the same name as it was listed>\",\n\"breve explanation\": \"<A short explanation regarding the classification>\"\n  },\n  // ...\n]\n```
Example for one tag:\n```json
[\n  {\n    \"category\": \"<category with the same name as it was listed>\",\n    \"explanation\": \"<A short explanation regarding the classification>\"\n  }\n]\n```",

        'GENERIC_SINGLE_CATEGORY_CLASSIFICATION': "Classify the financial hack into one of the following categories, based on [{based_on}]:\n
[{explained_categories}]\n
## Brief summary:\n[{hack_summary}]\n---\n## Financial hack:\n---\n\[{hack_description}]\n---\n## Related metadata:\n```\n[{metadata}]\n```\n
Provide your response only as a JSON object with the values as plain strings, no markdown; in the following format:\n```json\n
{\n    \"category\": \"<[{categories}]>\",\n    \"explanation\": \"<A short explanation regarding the classification>\",\n}\n```",

        'GENERIC_MULTI_CATEGORY_CLASSIFICATION': "Bellow you will be provided with a financial hack. According to the following [{class_name}] categories, state the applicable tags to the provided information.\n
##[{class_name}] categories:
[{explained_categories}]\n
## Brief summary:\n[{hack_summary}]\n---\n## Financial hack:\n---\n\[{hack_description}]\n---\n## Related metadata:\n```\n[{metadata}]\n```\n
If there is more than one category fitting then return them all. Provide your response only as a JSON object, in the following format:\n
Example for more than one tag:\n```json
[\n  {\n    \"category\": \"<category with the same name as it was listed>\",\n    \"explanation\": \"<A short explanation regarding the classification>\"\n  },\n  {\n    \"category\": \"<category with the same name as it was listed>\",\n\"breve explanation\": \"<A short explanation regarding the classification>\"\n  },\n  // ...\n]\n```
Example for one tag:\n```json
[\n  {\n    \"category\": \"<category with the same name as it was listed>\",\n    \"explanation\": \"<A short explanation regarding the classification>\"\n  }\n]\n```"

      }
    end
  end
end
