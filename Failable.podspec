Pod::Spec.new do |s|
  s.name         = "Failable"
  s.version      = "0.1.0"
  s.summary      = "Closure data using Either monad."
  s.description  = <<-DESC
                   An iOS version of Either monad returning either data T or NSError
                   DESC

  s.homepage     = "https://github.com/washingtonpost/ios-failable"
  s.license      = 'MIT'
  s.author       = "The Washington Post"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/washingtonpost/ios-failable.git", :tag => s.version.to_s }
  s.source_files = 'Failable/**/*.swift'

  s.dependency 'ObjectMapper', '~> 1.3'
  
end