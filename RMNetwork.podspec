Pod::Spec.new do |s|

  s.name         = "RMNetwork"
  s.version      = "0.1.3"
  s.summary      = "For AFNetworking 3.x."
  s.homepage     = "https://github.com/lweisNoN/RMNetWork"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "luhai" => "18221536574@163.com" }

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/lweisNoN/RMNetwork.git", :tag => s.version.to_s }

  s.public_header_files = 'RMNetWork/RMNetWork.h'
  s.source_files  = "RMNetWork/*.{h,m}"

  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 3.0'

end
