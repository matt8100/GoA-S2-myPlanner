# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Homework App (GOAS2)' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Homework App (GOAS2)
pod 'JTAppleCalendar', '~> 7.0'

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
