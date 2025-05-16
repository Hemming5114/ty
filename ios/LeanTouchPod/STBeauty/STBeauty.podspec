Pod::Spec.new do |s|
  s.name             = 'STBeauty'
  s.version          = '1.0.0'
  s.summary          = 'A short description of STBeauty.'
  s.platform         =:ios

  s.description      = <<-DESC
  # 这里写描述
  腾讯的短视频SDK，COSSDK，网络状态监听
  DESC

  s.homepage         = 'https://gitee.com/pikaqiu/tencent-upload'
  s.author           = { '' => 'www.tecent@qq.com' }
  s.source           = { :git => 'https://gitee.com/pikaqiu/tencent-upload.git', :tag => s.version.to_s }

  s.xcconfig         = {'VALID_ARCHS' => 'armv7 arm64 x86_64'}

  s.ios.deployment_target = '12.0'
  s.requires_arc = true
  s.static_framework = true
  
  s.vendored_libraries = 'SDK/lib/*.a'

  s.libraries = 'stdc++'
  s.resources = "Resources/*.bundle"

  # Include headers from specific folders

  # Source files from specific folders
  
  s.source_files = 'Utils/**/*.{h,m}', 'SDK/**/*.{h,m}'

  s.dependency 'Masonry', '~> 1.1.0'
  s.dependency 'zhPopupController', '~> 2.0.0'
  s.dependency 'JSONModel', '~> 1.8.0'

  


end
