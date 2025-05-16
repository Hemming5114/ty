Pod::Spec.new do |s|
  s.name             = 'TXUpload'
  s.version          = '1.0.0'
  s.summary          = 'A short description of TXUpload.'
  s.platform         =:ios

  s.description      = <<-DESC
  # 这里写描述
  腾讯的短视频SDK，COSSDK，网络状态监听
  DESC

  s.homepage         = "https://www.xiuliao.com/TXUpload"
  s.author        = { "hemming" => "hemming@guojiang.tv" }
  s.source           = { :git => 'https://www.xiuliao.com/TXUpload.git', :tag => s.version.to_s }

  s.xcconfig         = {'VALID_ARCHS' => 'armv7 arm64 x86_64'}

  s.ios.deployment_target = '12.0'
  s.requires_arc = true
  s.static_framework = true

  s.vendored_frameworks = 'COSSDK/QCloudCore.framework', 'COSSDK/QCloudCOSXML.framework','COSSDK/mars.framework'
  s.libraries = 'stdc++'

  # Include headers from specific folders
  s.public_header_files = 'Class/**/*.h', 'include/**/*.h'

  # Source files from specific folders
  s.source_files = 'Class/**/*.{h,m}', 'include/**/*.{h,m}'


end
