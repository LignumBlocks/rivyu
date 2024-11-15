require 'faker'

# Obtener los registros existentes de Source
sources = Source.all
if sources.empty?
  puts "No hay registros en la tabla 'sources'. Asegúrate de que existen antes de correr el seed."
  exit
end

# Crear artículos (articles) con una fuente asociada
NUM_ARTICLES = 10
articles = NUM_ARTICLES.times.map do
  Article.create!(
    source_id: sources.sample.id, # Asocia un source existente aleatorio
    content: Faker::Lorem.paragraph
  )
end

# Crear hacks con un artículo asociado
NUM_HACKS = 10
hacks = NUM_HACKS.times.map do
  Hack.create!(
    article_id: articles.sample.id, # Asocia un artículo aleatorio
    summary: Faker::Lorem.sentence,
    justification: Faker::Lorem.paragraph,
    steps_summary: Faker::Lorem.sentence,
    resources_needed: Faker::Lorem.words(number: 4).join(', '),
    expected_benefits: Faker::Lorem.sentence,
    detailed_steps: Faker::Lorem.paragraph,
    additional_tools_resources: Faker::Lorem.sentence,
    case_study: Faker::Lorem.paragraph,
    created_at: Faker::Date.backward(days: 365),
    updated_at: Faker::Date.backward(days: 100),
    init_title: Faker::Lorem.sentence,
    free_title: Faker::Lorem.sentence,
    premium_title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    main_goal: Faker::Lorem.sentence
  )
end

# Verificar que haya categorías en la tabla 'categories'
categories = Category.all
if categories.empty?
  puts "No hay registros en la tabla 'categories'. Creando categorías dummy..."
  NUM_CATEGORIES = 5
  categories = NUM_CATEGORIES.times.map do
    Category.create!(name: Faker::Lorem.word)
  end
end

# Crear relaciones entre hacks y categorías (hack_categories)
NUM_HACK_CATEGORIES = 20
NUM_HACK_CATEGORIES.times do
  HackCategory.create!(
    category_id: categories.sample.id, # Asocia una categoría aleatoria
    hack_id: hacks.sample.id, # Asocia un hack aleatorio
    justification: Faker::Lorem.paragraph
  )
end

puts "#{NUM_ARTICLES} Articles, #{NUM_HACKS} Hacks y #{NUM_HACK_CATEGORIES} HackCategories creados con datos dummy."
