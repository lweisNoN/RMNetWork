Pod::Spec.new do |s|

  s.name         = "RMNetwork"
<<<<<<< HEAD
  s.version      = "0.1.7"
=======
  s.version      = "0.1.5"
>>>>>>> origin/master
  s.summary      = "For AFNetworking 3.x."
  s.homepage     = "https://github.com/lweisNoN/RMNetWork"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


<<<<<<< HEAD
  s.author             = { "luhai" => "18221536574@163.com","Tony Duan" => "duanhai@outlook.com" }

  s.ios.deployment_target = "7.0"
=======
  s.author             = { "luhai" => "13076080418@163.com", "Tony Duan" => "duanhai@outlook.com"}
  s.ios.deployment_target = "8.0"
>>>>>>> origin/master

  s.source       = { :git => "https://github.com/lweisNoN/RMNetwork.git", :tag => s.version.to_s }

  s.source_files  = "RMNetWork/*.{h,m}"

  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 3.0'

end
