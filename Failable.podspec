# Failable

Pod::Spec.new do |s|
  # Meta
  s.name         = 'Failable'
  s.version      = '1.4.1'
  s.summary      = 'Closure data using Either monad.'
  s.description  = <<-DESC
                   An iOS version of Either monad returning either data T or NSError
                   DESC

  s.homepage     = 'https://github.com/washingtonpost/ios-failable'
  s.license      = 'MIT'
  s.authors = { 'The Washington Post' => 'iosdevpluscontractors@washpost.com' }

  # Deployment
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  # Source
  s.swift_version = '4.2'
  s.source       = { :git => "https://github.com/washingtonpost/ios-failable.git", :tag => s.version.to_s }
  s.source_files = 'Sources/**/*.swift'
end
