Gem::Specification.new do |s|
  s.name        = "notificater-rails"
  s.version     = "0.1.0"
  s.authors     = ["Kien La"]
  s.email       = ["la.kien@gmail.com"]
  s.homepage    = "http://kla.github.com/notificater"
  s.summary     = "Use notificater.js with rails 3.1"
  s.files       = Dir["lib/**/*"] + Dir["vendor/**/*"] + ["README"]

  s.add_dependency("railties", "~> 3.1.0")
end