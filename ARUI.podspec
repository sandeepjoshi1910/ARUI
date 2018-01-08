#
# Be sure to run `pod lib lint ARUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ARUI'
  s.version          = '0.1.0'
  s.summary          = 'ARUI helps create an AR UI from an Xib file'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  ARUI is a library which helps to create an Augmented Reality UI with ease. Develoeprs need to spend time in handling all the 
  ARkit specific details and sceneKit related code to setup an AR UI and then worry about the positioning and sizing the UI elements
  in AR. This library lets the developer specify a UI in the form of an Xib file and then parses the Xib file and creates an AR UI
  by resizing all the UI elements and arranging them to their relative positions in AR.
                       DESC

  s.homepage         = 'https://github.com/sandeepjoshi1910/ARUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sandeepjoshi1910' => 'aw.snjoshi@hotmail.com' }
  s.source           = { :git => 'https://github.com/sandeepjoshi1910/ARUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'ARUI/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ARUI' => ['ARUI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
