# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Booking-Hotel' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Neobis_iOS_WeatherApp
  pod 'SnapKit', '~> 5.0.0'
  pod 'JVFloatLabeledTextField'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end
