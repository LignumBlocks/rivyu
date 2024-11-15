namespace :admin do
  desc 'Create a default admin user'
  task create_admin_user: :environment do
    role = Role.where(name: 'admin').first
    role ||= Role.create!(name: 'admin')

    admin = User.create!(email: 'admin@hintsly.dev', password: 'password', password_confirmation: 'password')
    admin.roles << role
  end
end