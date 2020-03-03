
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'modl/parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'modl'
  spec.version       = MODL::Parser::VERSION
  spec.authors       = ['Tony Walmsley']
  spec.email         = ['tony@aosd.co.uk']

  spec.summary       = 'The ANTLR4 Lexer and Parser for MODL generated using the Ruby language target.'
  spec.description   = 'Contains the base Lexer, Parser, and supporting classes for a MODL parser.'
  spec.homepage      = 'https://github.com/MODLanguage/ruby-interpreter'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency 'antlr4-runtime', '= 0.2.10'
  spec.add_runtime_dependency 'punycode4r', '>= 0.2.0'
end
