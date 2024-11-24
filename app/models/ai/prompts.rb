module Ai
  # prompts hash
  class Prompts
    def self.prompts
      {
        'HACK_DISCRIMINATION': "A financial hack is a practical strategy or technique that helps individuals optimize their finances, save money, increase income, or improve their overall economic situation. Hacks range from easily accessible tips to sophisticated strategies used by high-net-worth individuals.
When scanning content, prioritize hacks that meet the following criteria:

- Clear Financial Value: Must demonstrate measurable financial benefits such as savings, income increases, or tax optimization with impact ranging from minor to significant.
- Applicability: Must be implementable by users, specifying who can use it and under what conditions (e.g., income level, country).
- Legality and Risks: Must comply with legal standards, highlighting legal implications, tax loopholes, and ethical issues. Key terms: legal complexities, tax exemptions, offshore jurisdictions.
- Clear Explanation: Prioritize hacks offering detailed explanations, preferably in tutorial or step-by-step format.
- Temporal Relevance: Must be suitable for the current economic context. Look for mentions of temporality or economic conditions in which the hack works.
- Impact Verification: Look for indications of measurable financial impact: specific figures or expected results.

Analyze the following content for financial hacks:
```
[{page_content}]
```

The output must be a json with the following structure:
```json
{
    \"content_summary\": <extract of the main points of the content. >,
    \"are_hacks\": <a boolean indicating if any hacks were found in the analysis, otherwise false>,
    \"justification\": <explanation of your reasoning regarding the 'are_hacks' conclusion. In Markdown format, using lists for each key point and bold text for particularly important findings.>,
    \"hacks_list\": [
        {
            \"hack_title\": <a concise, engaging and descriptive title for the hack>,
            \"description\": <Markdown-formatted description for the hack, highlighting the specific financial benefit, how to apply it and the user conditions and resources needed>,
            \"hack_justification\": <Markdown-formatted explanation of why this was selected as a hack, highlighting key points with lists and bold emphasis on important findings>
        }
    ]
}
```
If no hacks are found, set 'are_hacks' to false and provide a reasoning explanation in 'justification.' Leave 'hacks_list' empty in this case. Make sure each identified hack in the list has a clear title and reasoned justification in Markdown format.",

        'HACK_ADVICE_Old': "You are an expert financial analyst. Review the following financial strategy:
[{hack_info}]\n\n---\n
You need to qualify the proposed strategy as a simple financial advice or a complex financial hack.
A financial hack is a practical strategy or technique that helps individuals optimize their finances, save money, increase income, or improve their overall economic situation. Hacks range from easily accessible tips to sophisticated strategies used by high-net-worth individuals.
If it is a common or widely known financial strategy it should be classified as financial advice. Otherwise, if it offers something unique or little-known; or in a different approach, then it must be a financial advice.
A financial advice is usually more simple to implement, while a hack is more novel, little known or complex to understand or implement.

Provide your response only as a JSON, in the following format:
```json
{
     \"classification\": \"<It must be only one of the keywords 'Hack' or 'Advice'>\",
     \"explanation\": \"<A short explanation regarding the classification>\"
}
```",
        'HACK_ADVICE': "You are an expert financial analyst. Review the following financial strategy:
[{hack_info}]\n\n---\n
You need to qualify the proposed strategy as a financial advice or a financial hack.

Definition
Financial Advice: Tailored recommendations based on an individual's unique financial situation, goals, and circumstances, often provided by professionals.

Financial Hack: A one-size-fits-all shortcut or strategy aimed at immediate savings or optimization of a specific aspect of personal finance, often unconventional.

Criteria for Classifying Financial Advice vs. Financial Hacks
The goal is to classify whether content qualifies as financial advice or a financial hack based on the following criteria:

1. Personalization
Financial Advice: Content is tailored to an individual's unique financial circumstances, goals, and risk tolerance.
Financial Hack: Content provides general tips or strategies applicable to a broad audience without customization.
2. Time Horizon
Financial Advice: Focuses on long-term financial stability and planning.
Financial Hack: Targets short-term gains or immediate optimizations.
3. Depth of Explanation
Financial Advice: Offers detailed reasoning, multiple scenarios, and an analysis of potential trade-offs and risks.
Financial Hack: Provides straightforward and actionable steps with minimal depth or analysis.
4. Ethics and Legality
Financial Advice: Adheres to ethical and legal standards, often provided by professionals regulated by governing bodies.
Financial Hack: May exploit loopholes or operate in gray areas but generally stays within legal bounds.
5. Scalability
Financial Advice: Universally applicable across various financial situations and contexts.
Financial Hack: Effectiveness depends on specific, often localized or niche conditions.
6. Outcome Measurement
Financial Advice: Includes clear metrics or frameworks for measuring success and tracking progress.
Financial Hack: Results are often subjective and focus on immediate impact without structured tracking.
7. Risk Analysis
Financial Advice: Identifies risks explicitly and provides strategies to mitigate them.
Financial Hack: May briefly mention risks but lacks robust analysis or mitigation strategies.
8. Educational Component
Financial Advice: Educates the reader on broader financial principles or decision-making frameworks.
Financial Hack: Focuses on actionable tips without broader educational context.
9. Practical Feasibility
Financial Advice: Accessible and practical for most individuals without significant prerequisites.
Financial Hack: May require specific tools, conditions, or niche knowledge that limits broad applicability.

When evaluating an article or piece of content:
- Review the content using the criteria outlined above.
- Determine whether it aligns more strongly with the characteristics of financial advice or a financial hack.
- Provide a justification for the classification based on the criteria.",
        'HACK_ADVICE_STRUCT': "Your task is to extract the conclusions of the following analysis and return a json object.\n\nAnalysis:\n[{analysis}]\n---\n
Maintain the markdown text style if possible. Provide the result as a JSON object in this format:\n
```json
{
     \"is_hack\": <s boolean that is true if the classification is Hack; otherwise, if it is an Advice it should be false>,
     \"justification\": <Markdown-formatted explanation regarding the classification as Hack or Advice>\"
}
```",

        'CHAIN_OF_THOUGHT': "You are an expert financial analyst. Review the following content:\nMetadata:\n```\n[{metadata}]\n```\nContent:\n```\n[{page_content}]\n```\n
Analyze it step by step to identify any practical financial strategies or techniques that could help individuals optimize their finances, save money, increase income, or improve their overall economic situation. They should have measurable financial value, originality, clear applicability, legality, clear explanation and demonstrable impact.
A financial hack is defined as:
- Practical: A strategy that can be implemented easily by individuals.
- Measurable: Provides a clear financial benefit (e.g., specific savings or increased income).
- Original: Offers something innovative or less commonly known, avoiding generic advice.
- Applicable: Tailored to specific situations, considering the user's profile (income, age, goals).
- Legal and Ethical: Complies with legal standards and avoids high-risk or unethical practices.
- Relevant: Useful in the current financial or economic context.
First, summarize the main topics discussed. Then, evaluate each topic to determine if it includes any financial hack with the described characteristics. If there are not financial hacks in the content then clarify that there are not financial hacks.",

        'VERIFICATION_REVIEW': "As a financial verification expert, review the analysis below to identify any practical financial strategies or techniques that could help individuals optimize their finances, save money, increase income, or improve their overall economic situation.

The analysis is as follows:\n```\n[{analysis_output}]\n```\nYour task:
- Review the analysis and it's conclusions about the existence of financial hacks in the mentioned content.
- Identify financial hacks based on the following criteria: measurable financial value, originality, clear applicability, legality, clear explanation and demonstrable impact. Exclude common hacks or widely known financial advice.

1. If there are any strategies that meet these criteria list each financial hack with a short description, highlighting the specific financial benefit, how to apply it and the user conditions and resources needed.
2. If none meet the criteria or the analysis clarifies that there are not financial hacks, respond with: 'No qualifying financial hacks were identified in this content.' and explain why.",

        'HACK_VERIFICATION': "As a financial analysis and verification expert, you are reviewing an analysis of financial strategies for the presence of qualifying financial hacks.
A financial hack is a practical strategy or technique that helps individuals optimize their finances, save money, increase income, or improve their overall economic situation. Hacks range from easily accessible tips to sophisticated strategies used by high-net-worth individuals. A hack is a legal interesting advice to improve the finances of individuals.
Must demonstrate measurable financial benefits such as savings, income increases, or tax optimization with impact ranging from minor to significant. Look for indications of measurable financial impact: specific figures or expected results.

Below is some content that may contain financial hacks, and a previous verification analysis of this content.
\nContent:\n```\n[{page_content}]\n``` \nPrevious Analysis:\n```\n[{analysis_output}]\n```\n
Your task is to identify whether the analysis output found financial hacks in the content.\nProvide the result as a JSON object in this format:\n
```json\n{\n   \"content_summary\": <extract of the main points of the content. >,\n   \"are_hacks\": <a boolean indicating if any hacks were found in the analysis, otherwise false>,\n
        \"justification\": <explanation of your reasoning regarding the 'are_hacks' conclusion. In Markdown format, using lists for each key point and bold text for particularly important findings.>,
        \"hacks_list\": [\n       {\n          \"hack_title\": <a concise, engaging and descriptive title for the hack>,\n          \"brief_description\": <a description for the hack, highlighting the specific financial benefit, how to apply it and the user conditions and resources needed. If it's a very simple hack or accessible hack highlight that fact.>,
                \"hack_justification\": <Markdown-formatted explanation of why this was selected as a hack, highlighting key points with lists and bold emphasis on important findings>\n       }\n    ]\n}\n```
If no hacks are found, set 'are_hacks' to false and provide a reasoning explanation in 'justification.' Leave 'hacks_list' empty in this case. Make sure each identified hack in the list has a clear title and reasoned justification in Markdown format.",

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

        'GENERIC_SINGLE_CATEGORY_CLASSIFICATION': "Bellow you will be provided with a financial hack. According to the following '[{class_name}]' categories evaluate the financial hack taking into account: \"[{classification_description}]\".\n
##[{class_name}] categories:
[{explained_categories}]\n
## Financial hack:\n---\n\[{hack_description}]\n---\n## Related metadata:\n```\n[{metadata}]\n```\n
Choose the more accurate category for the provided information.
Provide your response only as a JSON object, in the following format:\n```json\n
{\n    \"category\": \"<category with the same name as it was listed>\",\n    \"explanation\": \"<A short explanation regarding the classification>\",\n}\n```",

        'GENERIC_MULTI_CATEGORY_CLASSIFICATION': "Bellow you will be provided with a financial hack. According to the following '[{class_name}]' categories evaluate the financial hack taking into account: \"[{classification_description}]\".\n
##[{class_name}] categories:
[{explained_categories}]\n
## Financial hack:\n---\n\[{hack_description}]\n---\n## Related metadata:\n```\n[{metadata}]\n```\n
State the applicable tags to the provided information. If there is more than one category fitting then return them all. Provide your response only as a JSON object, in the following format:\n
Example for more than one tag:\n```json
[\n  {\n    \"category\": \"<category with the same name as it was listed>\",\n    \"explanation\": \"<A short explanation regarding the classification>\"\n  },\n  {\n    \"category\": \"<category with the same name as it was listed>\",\n\"breve explanation\": \"<A short explanation regarding the classification>\"\n  },\n  // ...\n]\n```
Example for one tag:\n```json
[\n  {\n    \"category\": \"<category with the same name as it was listed>\",\n    \"explanation\": \"<A short explanation regarding the classification>\"\n  }\n]\n```"

      }
    end
  end
end
