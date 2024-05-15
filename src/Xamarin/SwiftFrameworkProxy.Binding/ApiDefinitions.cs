using System;
using Foundation;
using UIKit;

namespace Binding
{
	// @interface SwiftFrameworkProxy : NSObject
	[BaseType (typeof(NSObject))]
	interface SwiftFrameworkProxy
	{
		// +(double)BindingsVersion __attribute__((warn_unused_result("")));
		[Static]
		[Export ("BindingsVersion")]
		//[Verify (MethodToProperty)]
		double BindingsVersion { get; }

		// +(BOOL)canMakePayments __attribute__((warn_unused_result("")));
		[Static]
		[Export ("canMakePayments")]
		//[Verify (MethodToProperty)]
		bool CanMakePayments { get; }

		// +(void)getStorefrontIdWithCompletion:(void (^ _Nonnull)(NSString * _Nonnull))completion;
		[Static]
		[Export ("getStorefrontIdWithCompletion:")]
		void GetStorefrontIdWithCompletion (Action<NSString> completion);

		// +(void)getStorefrontCountryCodeWithCompletion:(void (^ _Nonnull)(NSString * _Nonnull))completion;
		[Static]
		[Export ("getStorefrontCountryCodeWithCompletion:")]
		void GetStorefrontCountryCodeWithCompletion (Action<NSString> completion);

		// +(void)showManageSubscriptionsIn:(UIWindowScene * _Nonnull)scene completionHandler:(void (^ _Nonnull)(NSError * _Nullable))completionHandler;
		[Static]
		[Export ("showManageSubscriptionsIn:completionHandler:")]
		void ShowManageSubscriptionsIn (UIWindowScene scene, Action<NSError> completionHandler);

		// +(void)checkCanOpenExternalPurchaseLinkWithCompletion:(void (^ _Nonnull)(BOOL))completion;
		[Static]
		[Export ("checkCanOpenExternalPurchaseLinkWithCompletion:")]
		void CheckCanOpenExternalPurchaseLinkWithCompletion (Action<bool> completion);

		// +(void)openExternalLinkWithCompletionHandler:(void (^ _Nonnull)(NSError * _Nullable))completionHandler;
		[Static]
		[Export ("openExternalLinkWithCompletionHandler:")]
		void OpenExternalLinkWithCompletionHandler (Action<NSError> completionHandler);
	}
}
