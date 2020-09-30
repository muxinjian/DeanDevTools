#
# Be sure to run `pod lib lint DeanDevTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DeanDevTools'
  s.version          = 'v1.1.0'
  s.summary          = 'DeanDevTools 封装了iOS快速开发工具, DeanDevTools/FPS 屏幕帧频数 DeanDevTools/CallStack 卡断打印函数调用栈信息 DeanDevTools/ClangTrace 二进制插座缓存程序启动的符号表,加快程序启动速度  DeanDevTools/AESCrypt AES256加密 解密'
  s.homepage         = 'https://github.com/muxinjian/DeanDevTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'muxinjian' => 'muxinjian.job@gmail.com' }
  s.social_media_url    = "https://juejin.im/user/3192637497025293"
  s.platform            = :ios, "8.0"
  s.source           = { :git => 'https://github.com/muxinjian/DeanDevTools.git', :tag => s.version.to_s }
  s.requires_arc        = true
  #s.source_files = 'DeanDevTools/Classes/**/*'
  #帧频率显示工具
  s.subspec 'FPS' do |fps|
    fps.source_files = 'DeanDevTools/Classes/FPS/**/*'
    end
 
  #卡顿检测打印堆栈信息
  s.subspec 'CallStack' do |cs|
    cs.source_files = 'DeanDevTools/Classes/CallStack/**/*'
    end
  #二进制插桩
  s.subspec 'ClangTrace' do |ct|
    ct.source_files = 'DeanDevTools/Classes/ClangTrace/**/*'
    end
  
  #AES256 加密/解密
  s.subspec 'AESCrypt' do |aes|
    aes.source_files = 'DeanDevTools/Classes/AESCrypt/**/*'
    aes.dependency 'MJExtension' , '~> 3.2.1'
    end
 

  # s.resource_bundles = {
  #   'DeanDevTools' => ['DeanDevTools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

