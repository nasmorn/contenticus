# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name          = "contenticus"
  s.version       = "0.4.10"
  s.authors       = ["Roman Almeida"]
  s.email         = ["post@romanalmeida.com"]
  s.homepage      = "http://github.com/nasmorn/contenticus"
  s.summary       = "Programmer centered CMS Engine"
  s.description   = "Conquer your Content"
  s.license       = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'rails',                 '>= 4.0.0', '< 5'
  s.add_dependency 'rails-i18n',            '>= 4.0.0'
  s.add_dependency 'pg'
  s.add_dependency 'ancestry'
  s.add_dependency 'bootstrap_form',        '>= 2.3.0'
  s.add_dependency 'jquery-rails',          '>= 3.0.0'
  s.add_dependency 'jquery-ui-rails',       '>= 5.0.0'
  s.add_dependency 'jcrop-rails-v2',        '>= 0.9.12'
  s.add_dependency 'haml-rails',            '>= 0.3.0'
  s.add_dependency 'sass-rails',            '>= 4.0.3'
  s.add_dependency 'coffee-rails',          '>= 3.1.0'
  s.add_dependency 'codemirror-rails',      '>= 3.0.0'
  s.add_dependency 'bootstrap-sass',        '>= 3.3.0'
  s.add_dependency 'kramdown',              '>= 1.13.2'
  s.add_dependency 'dragonfly',             '>= 1.0.10'
  s.add_dependency 'select2-rails',         '>= 4.0.3'
end
