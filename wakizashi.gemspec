# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wakizashi/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Francis Chong"]
  gem.email = ["francis@ignition.hk"]
  gem.description = "HTML/XML parser for RubyMotion, based on GDataXML-HTML."
  gem.summary = "HTML/XML parser for RubyMotion, based on GDataXML-HTML, which is based on GDataXML and HTMLparser module of libxml2. It allows you to deal with non validating XML or HTML."
  gem.homepage = "https://github.com/siuying/wakizashi"

  gem.files = `git ls-files`.split($\)
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.name = "wakizashi"
  gem.require_paths = ["lib"]
  gem.version = Wakizashi::VERSION
  gem.add_dependency 'motion-cocoapods', '>= 1.0.1'
  gem.add_development_dependency 'motion-redgreen'
end