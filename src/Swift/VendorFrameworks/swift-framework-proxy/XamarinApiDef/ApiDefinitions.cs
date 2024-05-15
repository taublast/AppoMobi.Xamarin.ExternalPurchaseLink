using System;
using Foundation;

namespace Binding
{
	// @interface SwiftFrameworkProxy : NSObject
	[BaseType (typeof(NSObject))]
	interface SwiftFrameworkProxy
	{
		// +(NSInteger)BindingsVersion __attribute__((warn_unused_result("")));
		[Static]
		[Export ("BindingsVersion")]
		[Verify (MethodToProperty)]
		nint BindingsVersion { get; }

		// +(BOOL)canMakePayments __attribute__((warn_unused_result("")));
		[Static]
		[Export ("canMakePayments")]
		[Verify (MethodToProperty)]
		bool CanMakePayments { get; }

		// +(void)canOpenExternalPurchaseLinkWithCompletion:(void (^ _Nonnull)(BOOL))completion;
		[Static]
		[Export ("canOpenExternalPurchaseLinkWithCompletion:")]
		void CanOpenExternalPurchaseLinkWithCompletion (Action<bool> completion);

		// +(void)openExternalLinkWithCompletionHandler:(void (^ _Nonnull)(NSError * _Nullable))completionHandler;
		[Static]
		[Export ("openExternalLinkWithCompletionHandler:")]
		void OpenExternalLinkWithCompletionHandler (Action<NSError> completionHandler);
	}
}
