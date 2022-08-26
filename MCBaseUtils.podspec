#
# Be sure to run `pod lib lint MCBaseUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MCBaseUtils'
  s.version          = '5.0.2'
  s.summary          = 'MCBaseUtils.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Swift版本 第一版，上传到spec里面，后面开始加载代码内容
      第二版，准备上传一些宏定义的内容
      第三版，准备一下扩展内容
      第四版，准备上传一些小组件
      第五版，准备上传一些控件的
      第六版，准备上传一些视频，上传相关的内容
                       DESC

  s.homepage         = 'https://github.com/loveshort'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mxx' => '271901088@qq.com' }
  s.source           = { :git => 'https://github.com/loveshort/MCBaseUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.platform = :ios, "13.0"
  s.swift_version = '5.0'
  s.source_files = 'MCBaseUtils/Classes/**/*'
  
#  s.subspec 'MCScreenHeight' do |mcscreenheight|
#      mcscreenheight.source_files = 'MCBaseUtils/Classes/MCScreenHeight/*.{h,m}'
#  end
#
#  s.subspec 'MCTabBar' do |mctabbar|
#      mctabbar.source_files = 'MCBaseUtils/Classes/MCTabBar/*.{h,m}'
#  end
#
#  s.subspec 'MCObject' do |mcobject|
#      mcobject.source_files = 'MCBaseUtils/Classes/MCObject/*.{h,m}'
#  end
#
#  s.subspec 'MCEmptyView' do |mcemptyview|
#     mcemptyview.source_files = 'MCBaseUtils/Classes/MCEmptyView/*.{h,m}'
#  end
#
#  s.subspec 'MCView' do |mcview|
#     mcview.source_files = 'MCBaseUtils/Classes/MCView/*.{h,m}'
#  end
  
 # s.subspec 'MCMacro' do |mcmacro|
 #    mcmacro.source_files = 'MCBaseUtils/Classes/MCMacro/*.h'
#  end
  
#  s.subspec 'MCCategory' do |mccategory|
    #  mccategory.public_header_files = 'MCBaseUtils/Classes/MCCategory/MCCategory.h'
      
    # mccategory.frameworks = 'UIKit','Foundation'
      
#      mccategory.subspec 'MCKit' do |mckit|
#        mckit.source_files = 'MCBaseUtils/Classes/MCCategory/MCKit/*.{h,m}'
#      end
#
#      mccategory.subspec 'MCFoundation' do |mcfoundation|
#        mcfoundation.source_files = 'MCBaseUtils/Classes/MCCategory/MCFoundation/*.{h,m}'
#      end
 # end
 
  # s.resource_bundles = {
  #   'MCBaseUtils' => ['MCBaseUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   # s.dependency 'MJRefresh'
   # s.dependency 'DZNEmptyDataSet'
   # s.dependency 'TABAnimated'
   # s.dependency 'AFNetworking'
end
