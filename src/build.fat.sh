# Builds a fat library for a given xcode project (framework)

echo "Define parameters"
IOS_SDK_VERSION="17.2" # xcodebuild -showsdks
SWIFT_PROJECT_NAME="SwiftFrameworkProxy"
SWIFT_PROJECT_PATH="Swift/$SWIFT_PROJECT_NAME/$SWIFT_PROJECT_NAME.xcodeproj"
SWIFT_BUILD_PATH="Swift/$SWIFT_PROJECT_NAME/build"
SWIFT_OUTPUT_PATH="Swift/VendorFrameworks/swift-framework-proxy"
XAMARIN_BINDING_PATH="Xamarin/SwiftFrameworkProxy.Binding"

echo "STEP 1: Build iOS framework for simulator and device"
rm -Rf "$SWIFT_BUILD_PATH"
xcodebuild -sdk iphonesimulator$IOS_SDK_VERSION -project "$SWIFT_PROJECT_PATH" -configuration Release
xcodebuild -sdk iphoneos$IOS_SDK_VERSION -project "$SWIFT_PROJECT_PATH" -configuration Release

echo "STEP 2: Create fat binaries for Release-iphoneos and Release-iphonesimulator configuration"
echo "Copy one build as a fat framework"
cp -R "$SWIFT_BUILD_PATH/Release-iphoneos" "$SWIFT_BUILD_PATH/Release-fat"

echo "STEP 3: Combine modules from another build with the fat framework modules"
cp -R "$SWIFT_BUILD_PATH/Release-iphonesimulator/$SWIFT_PROJECT_NAME.framework/Modules/$SWIFT_PROJECT_NAME.swiftmodule/" "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/Modules/$SWIFT_PROJECT_NAME.swiftmodule/"

echo "STEP 4: Strip arm64 architecture from simulator binary"
lipo -remove arm64 -output "$SWIFT_BUILD_PATH/Release-iphonesimulator/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME-x86_64" "$SWIFT_BUILD_PATH/Release-iphonesimulator/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME"

echo "STEP 5: Combine iphoneos + stripped iphonesimulator configuration as fat libraries"
lipo -create -output "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME" "$SWIFT_BUILD_PATH/Release-iphoneos/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME" "$SWIFT_BUILD_PATH/Release-iphonesimulator/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME-x86_64"

echo "STEP 6: Verify results"
lipo -info "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME"

echo "STEP 7: Copy fat frameworks to the output folder"
rm -Rf "$SWIFT_OUTPUT_PATH"
mkdir "$SWIFT_OUTPUT_PATH"
cp -Rf "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework" "$SWIFT_OUTPUT_PATH"

echo "STEP 8: Generating binding api definition and structs"
sharpie bind --sdk=iphoneos$IOS_SDK_VERSION --output="$SWIFT_OUTPUT_PATH/XamarinApiDef" --namespace="Binding" --scope="$SWIFT_OUTPUT_PATH/$SWIFT_PROJECT_NAME.framework/Headers/" "$SWIFT_OUTPUT_PATH/$SWIFT_PROJECT_NAME.framework/Headers/$SWIFT_PROJECT_NAME-Swift.h"

echo "STEP 9: Replace existing metadata with the updated"
cp -Rf "$SWIFT_OUTPUT_PATH/XamarinApiDef/." "$XAMARIN_BINDING_PATH/"

echo "STEP 10: Replace referenced native framework at $XAMARIN_BINDING_PATH/Framework"
cp -R "$SWIFT_BUILD_PATH/Release-fat/"* "$XAMARIN_BINDING_PATH/Framework/"


echo "Operations completed!"
