# -*- encoding: utf-8 -*-
lib = File.expand_path('./lib', File.dirname(__FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deliver'

Gem::Specification.new do |gem|
  gem.name          = "deliver"
  gem.version       = Deliver::VERSION
  gem.authors       = ["Rain Lee"]
  gem.email         = ["blacktear23@gmail.com"]
  gem.description   = %q{Deploy tools, that can run commands in many servers}
  gem.summary       = %q{Deploy tools}
  gem.homepage      = "https://github.com/blacktear23/deliver"

  gem.files         = Dir['README.md', 'LICENSE.txt', 'bin/**/*', 'lib/**/*', 'test/**/*']
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.bindir        = 'bin'
  gem.executables   = ['deliver']
  gem.add_dependency 'net-ssh'
  gem.add_dependency 'net-scp'
end
