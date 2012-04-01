Gem::Specification.new do |s|
  s.name = "proffer"
  s.summary = "An Action Controller module to hide instance variables from views by default."
  s.description = "A module to stop Action Controller from copying every instance variable available to an action to the view by default. Instead, Proffer provides a way to explicitly expose values as local variables within views."
  s.version = "0.10.0"
  s.authors = ["James Hunt", "Paul Mucur"]
  s.homepage = "https://github.com/hudge/proffer"
  s.files = ["lib/proffer.rb", "Rakefile", "README.md", "LICENSE.txt"]
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/spec_helper_rails.rb",
    "spec/proffer_spec.rb",
    "spec/proffer_integration_spec.rb",
    "spec/fixtures/proffer_test/index.html.erb",
    "spec/fixtures/proffer_test/index.xml.builder"
  ]
  s.add_development_dependency("rspec-rails")
  s.add_development_dependency("rails")
  s.add_development_dependency("rake")
end

