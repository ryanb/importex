Gem::Specification.new do |s|
  s.name = "importex"
  s.summary = "Import an Excel document with Ruby."
  s.description = "Import an Excel document by creating a Ruby class and passing in an 'xls' file. It will automatically format the columns into specified Ruby objects and raise errors on bad data."
  s.homepage = "http://github.com/ryanb/importex"
  
  s.version = "0.1.0"
  s.date = "2010-02-08"
  
  s.authors = ["Ryan Bates"]
  s.email = "ryan@railscasts.com"
  
  s.require_paths = ["lib"]
  s.files = Dir["lib/**/*"] + Dir["spec/**/*"] + ["LICENSE", "README.rdoc", "Rakefile", "CHANGELOG.rdoc"]
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG.rdoc", "LICENSE"]
  
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Importex", "--main", "README.rdoc"]
  
  s.add_dependency("spreadsheet", "= 0.6.4.1")
  
  s.rubygems_version = "1.3.4"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2")
end
