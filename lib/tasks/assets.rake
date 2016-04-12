Rake::Task["assets:precompile"].clear

namespace :assets do
  task 'precompile' do
      puts "Skipping forced assets:precompile..."
  end
end
