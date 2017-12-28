#
#  Be sure to run `pod spec lint SwiftyImageCache.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SwiftyImageCache"
  s.version      = "1.2.2"
  s.summary      = "Image Cache for iOS in Swift"
  s.description  = <<-DESC
                   Lightly, powerfully framework for iOS in swift.
                   DESC

  s.homepage     = "https://github.com/noblakit01/SwiftyImageCache"
  s.license      = "MIT"

  s.platform     = :ios, "8.0"

  s.author       = { "noblakit01" => "noblakit01@gmail.com" }
  
  s.source       = { :git => "https://github.com/noblakit01/SwiftyImageCache.git", :tag => s.version }

  s.source_files  = "Sources/*.swift"
  s.requires_arc = true

end
