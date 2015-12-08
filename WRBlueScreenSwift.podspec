Pod::Spec.new do |s|
   s.name     = 'WRBlueScreenSwift'
   s.version  = '1.0.3'
   s.license  = 'MIT'
   s.summary  = 'iOS error handling on old school Windows BSOD.'
   s.homepage = 'https://github.com/rafalwojcik/WRBlueScreen'
   s.authors  = 'Rafał Wójcik'
   s.source   = { :git => 'https://github.com/rafalwojcik/WRBlueScreen.git', :tag => s.version.to_s }

   s.platform     = :ios, '8.0'
   s.ios.deployment_target = '8.0'
   s.ios.resource_bundle = { 'WRBlueScreenBundle' => 'Resources/{WRBlueScreenViewSwift.xib,*.ttf}' }
   s.requires_arc = true   
   s.framework = "UIKit"
   s.source_files = "WRBlueScreen/**/*.swift"
end