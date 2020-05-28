workspace 'HeyWeatherApp.xcworkspace'
use_frameworks!
inhibit_all_warnings!

abstract_target 'Shared' do 

use_frameworks!
inhibit_all_warnings!

    pod 'RxCocoa'
    pod 'NSObject+Rx'
    pod 'SwiftLint'

    target 'Core' do

       pod 'YALAPIClient/Alamofire', '2.9.1'
       pod 'YALAPIClient/Core', '2.9.1'
       pod 'DBClient/Core', '1.4.2'
       pod 'DBClient/CoreData', '1.4.2'
       pod 'DBClient/Realm', '1.4.2'
       pod 'KeychainAccess'

    end

    target 'HeyWeatherApp' do
  
       pod 'Swinject'
       pod 'SwinjectAutoregistration'
       pod 'RxCocoa'
       pod 'NSObject+Rx'
       pod 'RxDataSources'
       pod 'SwiftGen', '~> 6.0'

    end

end



