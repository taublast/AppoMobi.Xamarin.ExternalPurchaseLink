# AppoMobi.Xamarin.ExternalPurchaseLink

Xamarin bindings to implement Apple ExternalPurchaseLink permission.

## Source Code

We have 2 parts:

### Native Wrapper

To edit on Mac: 
* Edit the wrapper code using XCode. Notice there are bundle signing credentials and bundle id to be replaced by yours.
* Execute `bash build.fat.sh` being in the `src` folder. This will compile everything, and replace bindings and the framework used by the .NET project. It requires Objective Sharpie to be installed.
* Then you might need to modify `ApiDefinitions.cs`, in my case i was just commenting out the `[Verify]` attributes that came from the new Objective Sharpie version.

### Xamarin iOS Bindings

The framework that came from the script is going to be in the `Framework` folder, and `ApiDefinitions.cs` came from native script too.

Can reference this project manually in your iOS app, if you install the nuget `Xamarin.iOS.SwiftRuntimeSupport` it would auto-reference the native framework for you, otherwise, you would need to add it manually to Native References.

## Nuget Package

todo
