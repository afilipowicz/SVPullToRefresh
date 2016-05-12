Pod::Spec.new do |s|
  s.name             = "SVPullToRefresh"
  s.version          = "0.5.1"
  s.platform         = :ios, '8.0'
  s.summary          = "Give pull-to-refresh to any UIScrollView with 1 line of code."
  s.description      = 'SVPullToRefresh allows you to easily add pull-to-refresh ' \
                       'functionality to any UIScrollView subclass with only 1 ' \
                       'line of code. Instead of depending on delegates and/or ' \
                       'subclassing UIViewController, SVPullToRefresh extends ' \
                       'UIScrollView with a addPullToRefreshWithActionHandler: ' \
                       'method as well as a pullToRefreshView property.'
  s.license          = 'MIT'
  s.homepage         = 'https://github.com/afilipowicz/SVPullToRefresh'
  s.author           = { 'Sam Vermette' => 'hello@samvermette.com' }
  s.source           = { :git => 'https://github.com/afilipowicz/SVPullToRefresh.git', :tag => s.version.to_s }
  s.frameworks       = 'QuartzCore', 'UIKit'
  s.source_files     = 'SVPullToRefresh/Classes/**/*'
  s.requires_arc     = true
  s.dependency 'CinoSpinner', '~> 1.0'
end
