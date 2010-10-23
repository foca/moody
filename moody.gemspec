Gem::Specification.new do |s|
  s.name    = "moody"
  s.version = "0.1.1"
  s.date    = "2010-10-23"

  s.description = "Simple and straightforward implementation of the state pattern, inspired by the StatePattern gem"
  s.summary     = "State Pattern for your rubies"
  s.homepage    = "http://github.com/foca/moody"

  s.authors = ["Nicolás Sanguinetti"]
  s.email   = "contacto@nicolassanguinetti.info"

  s.require_paths     = ["lib"]
  s.has_rdoc          = true

  s.files = %w[
    README.md
    moody.gemspec
    lib/moody.rb
    test/test_moody.rb
  ]
end
