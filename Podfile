# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

target 'iMusic' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iMusic
    pod 'GoogleSignIn'
#    pod 'EZAudio', '~> 1.1.4'
    pod 'DisplaySwitcher', '~> 2.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
