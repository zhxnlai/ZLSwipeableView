Pod::Spec.new do |s|
  s.name         = "ZLSwipeableView"
  s.version      = "0.0.8"
  s.summary      = "A simple view for building card like interface like Tinder and Potluck."
  s.description  = <<-DESC
                   ZLSwipeableView is a simple view for building card like interface like Tinder and Potluck. It uses dataSource pattern and is highly customizable.
                   DESC
  s.homepage     = "https://github.com/zhxnlai/ZLSwipeableView"
  s.screenshots  = "https://github.com/zhxnlai/ZLSwipeableView/raw/master/Previews/swipe.gif", "https://github.com/zhxnlai/ZLSwipeableView/raw/master/Previews/swipeLeft.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Zhixuan Lai" => "zhxnlai@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/zhxnlai/ZLSwipeableView.git", :tag => "0.0.8" }
  s.source_files  = "ZLSwipeableView", "ZLSwipeableView/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"
  s.framework  = "UIKit"
  s.requires_arc = true
end
