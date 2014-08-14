namespace :servertasks do
  desc "TODO"
  task disable_autoload_on_take: :environment do
    ENV['DISABLE_INITIALIZER_FROM_RAKE'] = 'true'
  end

end
