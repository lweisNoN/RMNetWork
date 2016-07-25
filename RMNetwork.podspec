Pod::Spec.new do |s|

  s.name         = "RMNetwork"
  s.version      = "0.1.5"
  s.summary      = "For AFNetworking 3.x."
  s.homepage     = "https://github.com/lweisNoN/RMNetWork"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "luhai" => "13076080418@163.com", "Tony Duan" => "duanhai@outlook.com"}
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/lweisNoN/RMNetwork.git", :tag => s.version.to_s }

  s.source_files  = "RMNetWork/*.{h,m}"

  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 3.0'

end
