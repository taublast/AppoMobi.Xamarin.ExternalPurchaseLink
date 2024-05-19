# AppoMobi.Xamarin.ExternalPurchaseLink

Xamarin bindings to implement Apple StoreKit2 ` com.apple.developer.storekit.external-purchase-link` entitlement with [ExternalPurchaseLink](https://developer.apple.com/documentation/storekit/externalpurchaselink?language=objc) functionality.

Can reference Xamarin project manually in your iOS app, or install nuget.

Left project structure generic to be re-used as template for similar projects.

## Source Code

2 parts:

### Native Wrapper

To edit on Mac: 
* Edit the wrapper code using XCode. Notice there are bundle signing credentials and bundle id to be replaced by yours.
* Execute `bash build.fat.sh` being in the `src` folder. This will compile everything, and replace bindings and the framework used by the .NET project. It requires Objective Sharpie to be installed.
* Then you might need to modify `ApiDefinitions.cs`, in my case i was just commenting out the `[Verify]` attributes that came from the new Objective Sharpie version.

### Xamarin iOS Bindings

The framework that came from the script is going to be in the `Framework` folder, and `ApiDefinitions.cs` came from native script too.
