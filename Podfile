platform :ios, '12.0'
target 'Homework App (GOAS2)' do
use_frameworks!

  # Pods for Homework App (GOAS2)
pod 'JTAppleCalendar'
pod 'Hue'



  target 'Homework App (GOAS2)Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Homework App (GOAS2)UITests' do
    inherit! :search_paths
    # Pods for testing
  end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == 'Debug'
                config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
            end
        end
    end
end
end
