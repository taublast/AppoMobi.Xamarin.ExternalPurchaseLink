using Binding;
using Foundation;
using System;
using UIKit;

namespace TestBindings
{
    public partial class ViewController : UIViewController
    {
        private SwiftFrameworkProxy _proxy;

        public ViewController (IntPtr handle) : base (handle)
        {
            _proxy = new SwiftFrameworkProxy();
        }

        public override void ViewDidLoad ()
        {
            base.ViewDidLoad ();

            Console.WriteLine($"Bindings Version: {SwiftFrameworkProxy.BindingsVersion}");

            Console.WriteLine($"CanMakePayments: {SwiftFrameworkProxy.CanMakePayments}");
        }

        public override void DidReceiveMemoryWarning ()
        {
            base.DidReceiveMemoryWarning ();
            // Release any cached data, images, etc that aren't in use.
        }
    }
}
