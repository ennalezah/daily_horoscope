lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "daily_horoscope/version"

Gem::Specification.new do |spec|
  spec.name          = "daily_horoscope"
  spec.version       = DailyHoroscope::VERSION
  spec.authors       = ["Hazel Anne Villareal"]
  spec.email         = ["hae.villareal@gmail.com"]

  spec.summary       = "Gets current horoscope readings for the day"
  spec.description   = "Displays daily horoscope, and depending on user's choice,
                        horoscopes for love, career, money, and health can also be viewed."
  spec.homepage      = "https://github.com/ennalezah/daily_horoscope.git"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  
  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "https://github.com/ennalezah/daily_horoscope.git"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", ">= 1.0"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "colorize", "~> 0.8.1"
end
