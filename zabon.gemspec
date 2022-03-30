# frozen_string_literal: true

require_relative "lib/zabon/version"

Gem::Specification.new do |spec|
  spec.name          = "zabon"
  spec.version       = Zabon::VERSION
  spec.authors       = ["Joesi"]
  spec.email         = ["johannes@meisterlabs.com"]

  spec.summary       = "Japanese line breaking algorithm: Ruby port of mikan.js"
  spec.description   = "Splits up a (Japanese) string into semantic segment; wrap result in a HTML tag"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.7"

  spec.metadata["source_code_uri"] = "https://github.com/krokodaxl/zabon.git"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "actionview"
  spec.add_dependency "railties"
end
