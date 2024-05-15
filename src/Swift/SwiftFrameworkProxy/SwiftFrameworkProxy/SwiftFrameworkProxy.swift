//  Created by Nick on 15/5/24.

import Foundation
import StoreKit

@objc(SwiftFrameworkProxy)
public class SwiftFrameworkProxy : NSObject {

    @objc public static func BindingsVersion() -> Int {
            return 1
    }
        
    //iOS 15
    @objc public static func canMakePayments() -> Bool {
        let result = AppStore.canMakePayments
        return result
    }

    
    // iOS 15.4
    @objc public static func canOpenExternalPurchaseLink(completion: @escaping (Bool) -> Void) {
        Task {
            let result = await ExternalPurchaseLink.canOpen
            print("ExternalPurchaseLink.canOpen: \(result)")
            completion(result)
        }
    }


    //iOS 15.4
    @objc public static func openExternalLink() async throws {
        try await ExternalPurchaseLink.open()
    }
    

}
