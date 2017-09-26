server ENV['PRODUCTION_SERVER'], roles: %w[app db web]

set :rails_env, 'production'
set :migration_role, :app
