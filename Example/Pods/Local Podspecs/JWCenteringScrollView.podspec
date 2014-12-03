#
# Be sure to run `pod lib lint JWCenteringScrollView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JWCenteringScrollView"
  s.version          = "0.1.0"
  s.summary          = "A scrollView that centers its content instead of snapping to the top-left."
  s.description      = <<-DESC
                        When the contentsize of a scrollview is less than the bounds, UIScrollView snaps the content to the top-left corner. This behavior is very annoying for displaying images and the such.
                        JWCenteringScrollView fixes this by keeping it centered.
                       DESC
  s.homepage         = "https://github.com/jackwu95/JWCenteringScrollView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "jackwu" => "jackwu95@gmail.com" }
  s.source           = { :git => "https://github.com/jackwu95/JWCenteringScrollView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/JackTripleU'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.frameworks = 'UIKit'
end
