source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
platform :ios, '10.0'
target "DXDoctor" do
    
pod 'Alamofire', '~> 4.0'
pod 'SwiftyJSON'
pod 'Kingfisher', '~> 3.0'
pod 'IBAnimatable'


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
end

