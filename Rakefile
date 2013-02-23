require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :skeptic do
  files = (Dir.glob File.join("**", "**", "**", "*.rb")) + \
          (Dir.glob File.join("**", "**", "**", "*.treetop")) +
          ["Rakefile"]
  files.each do |file|
    p "#{file}"
    system("skeptic --no-trailing-whitespace #{file}") or exit(1)
  end
end

task :default => :spec