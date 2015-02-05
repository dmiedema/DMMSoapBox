Pod::Spec.new do |s|

  s.name         = "DMMSoapBox"
  s.version      = "0.0.1"
  s.summary      = "A Soapbox on which to announce things."

  s.description  = <<-DESC
                   Announce important things to your users, let them know
                   whatever they need to know.

                   Based on panic's 2014 report where they mention using their soapbox
                   code to announce Prompt 2 to users of Prompt
                   DESC

  s.homepage     = "https://github.com/dmiedema/DMMSoapBox"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.author             = { "Daniel Miedema" => "danielmiedema@me.com" }
  s.social_media_url   = "http://twitter.com/no_good_ones"
  
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dmiedema/DMMSoapBox.git", :tag => "0.0.1" }

  s.source_files  = "DMMSoapBox/*/*.{h,m}"

  s.requires_arc = true

  s.dependency "GroundControl", "~> 2.1"
  s.dependency "Colours", "~> 5.6"

end
