#
# Be sure to run `pod lib lint XCLoginUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XCLoginUI'
  s.version          = '1.0.0'
  s.summary          = '登录页面的UI'

  s.description      = <<-DESC
XCLoginUI: 登录页面的UI.
                       DESC

  s.homepage         = 'https://github.com/fanxiaocong/XCLoginUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fanxiaocong' => '1016697223@qq.com' }
  s.source           = { :git => 'https://github.com/fanxiaocong/XCLoginUI.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'XCLoginUI/Classes/**/*'
  
  s.resource_bundles = {
    'XCLoginUI' => ['XCLoginUI/Assets/images/*.png',
                    'XCLoginUI/Assets/*.storyboard'
                    ]
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'XCMacros', '~> 1.0.4'

end
