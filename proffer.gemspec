Gem::Specification.new do |s|
  s.name = "proffer"
  s.summary = "An Action Controller module to hide instance variables from views by default."
  s.version = "0.9.0"
  s.authors = ["James Hunt", "Paul Mucur"]
  s.homepage = "http://github.com/hudge/proffer"
  s.files = ["lib/proffer.rb", "Rakefile", "README.md", "LICENSE.txt"]
  s.test_files = ["spec/spec_helper.rb", "spec/proffer_spec.rb"]
  s.add_development_dependency("minitest")
  s.add_development_dependency("rake")
end

