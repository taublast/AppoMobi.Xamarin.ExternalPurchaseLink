//  Created by Nick on 15/5/24.

import Foundation
import StoreKit

@objc(SwiftFrameworkProxy)
public class SwiftFrameworkProxy : NSObject {

    @objc public static func BindingsVersion() -> Double {
        return 1.1
    }
    
    //iOS 15
    @objc public static func canMakePayments() -> Bool {
        let result = AppStore.canMakePayments
        return result
    }
    
    // iOS 15.0
    @objc public static func getStorefrontId(completion: @escaping (String) -> Void) {
        Task {
            let result = await Storefront.current?.id
            completion(result ?? "")
        }
    }
    
    // iOS 15.0
    @objc public static func getStorefrontCountryCode(completion: @escaping (String) -> Void) {
        Task {
            let result = await Storefront.current?.countryCode
            completion(result ?? "")
        }
    }


    @objc public static func showManageSubscriptions(in scene: UIWindowScene) async throws {
        try await AppStore.showManageSubscriptions(in: scene)
    }


    // iOS 15.4
    @objc public static func checkCanOpenExternalPurchaseLink(completion: @escaping (Bool) -> Void) {
        Task {
            let result = await ExternalPurchaseLink.canOpen
            completion(result)
        }
    }

    //iOS 15.4
    @objc public static func openExternalLink() async throws {
        try await ExternalPurchaseLink.open()
    }
    

}
