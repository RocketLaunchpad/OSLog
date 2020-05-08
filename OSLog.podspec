Pod::Spec.new do |s|

  s.name = "OSLog"
  s.version = "1.0.4"
  s.summary = "OSLog Logging Framework"

  s.description = <<-DESC
The OSLog framework provides convenience wrappers around the native OSLog facilities provided by Apple.
  DESC

  s.homepage = "https://github.com/rocketinsights/OSLog"
  s.author = "Rocket Insights"
  s.source = { :git => "https://github.com/rocketinsights/OSLog.git", :tag => "#{s.version}" }
  s.license = "MIT"

  s.platform = :ios, "11.0"
  s.swift_version = "5.0"

  s.source_files = "Sources/*.swift"
end

