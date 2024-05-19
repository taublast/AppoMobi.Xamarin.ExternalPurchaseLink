using Binding;
using Foundation;
using System;
using UIKit;

namespace TestBindings
{
    public partial class ViewController : UIViewController
    {
        private SwiftFrameworkProxy _proxy;

        public ViewController(IntPtr handle) : base(handle)
        {
            _proxy = new SwiftFrameworkProxy();
        }

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            Console.WriteLine($"Bindings Version: {SwiftFrameworkProxy.BindingsVersion}");

            Console.WriteLine($"CanMakePayments: {SwiftFrameworkProxy.CanMakePayments}");


            BeginInvokeOnMainThread(() =>
            {

                SwiftFrameworkProxy.CheckCanOpenExternalPurchaseLinkWithCompletion((result) =>
                {
                    Console.WriteLine($"Can Open Link {result}");
                });

                //will crash on simulator
                //SwiftFrameworkProxy.OpenExternalLinkWithCompletionHandler((error) =>
                //{
                //    if (error == null)
                //    {
                //        Console.WriteLine($"OpenLink no errors");
                //    }
                //    else
                //    {
                //        Console.WriteLine($"OpenLink error {error.Code} {error.Description}");
                //    }
                //});

                SwiftFrameworkProxy.GetStorefrontCountryCodeWithCompletion((code) =>
                {
                    Console.WriteLine($"Country Code {code}");
                });

            });
        }

        public override void DidReceiveMemoryWarning()
        {
            base.DidReceiveMemoryWarning();
            // Release any cached data, images, etc that aren't in use.
        }
    }
}