## Version 3.5.0 RC 3

- [Changelog](http://www.hockeyapp.net/help/sdk/ios/3.5.0rc3/docs/docs/Changelog.html)

## Introduction

This article describes how to integrate HockeyApp into your iOS apps. The SDK allows testers to update your app to another beta version right from within the application. It will notify the tester if a new update is available. The SDK also allows to send crash reports. If a crash has happened, it will ask the tester on the next start whether he wants to send information about the crash to the server.

This document contains the following sections:

- [Requirements](#requirements)
- [Download & Extract](#download)
- [Set up Xcode](#xcode)
- [Modify Code](#modify)
- [Mac Desktop Uploader](#mac)
- [Xcode Documentation](#documentation)

<a id="requirements"></a> 
## Requirements

The SDK runs on devices with iOS 5.0 or higher.

<a id="download"></a> 
## Download & Extract

1. Download the latest [HockeySDK-iOS](http://www.hockeyapp.net/releases/) framework.

2. Unzip the file. A new folder `HockeySDK-iOS` is created.

3. Move the folder into your project directory. We usually put 3rd-party code into a subdirectory named `Vendor`, so we move the directory into it.

<a id="xcode"></a> 
## Set up Xcode

1. Drag & drop `HockeySDK.embeddedframework` from your project directory to your Xcode project.

2. Similar to above, our projects have a group `Vendor`, so we drop it there.

3. Select `Create groups for any added folders` and set the checkmark for your target. Then click `Finish`.

    <img src="XcodeCreateGroups_normal.png"/>

4. Select your project in the `Project Navigator` (⌘+1).

5. Select your project.

6. Select the tab `Info`.

7. Expand `Configurations`.

8. Select `HockeySDK.xcconfig` for all your configurations (if you don't already use a `.xcconfig` file)
    
    <img src="XcodeFrameworks1_normal.png"/>
    
    **Note:** You can also add the required frameworks manually to your targets `Build Phases` and continue with step `10.` instead.

9. If you are already using a `.xcconfig` file, simply add the following line to it

    `#include "../Vendor/HockeySDK/Support/HockeySDK.xcconfig"`
    
    (Adjust the path depending where the `Project.xcconfig` file is located related to the Xcode project package)
    
    **Important note:** Check if you overwrite any of the build settings and add a missing `$(inherited)` entry on the projects build settings level, so the `HockeySDK.xcconfig` settings will be passed through successfully.

10. If you are getting build warnings, then the `.xcconfig` setting wasn't included successfully or its settings in `Other Linker Flags` get ignored because `$(interited)` is missing on project or target level. Either add `$(inherited)` or link the following frameworks manually in `Link Binary With Libraries` under `Build Phases`:
    - `CoreText`
    - `CoreGraphics`
    - `Foundation`
    - `QuartzCore`
    - `Security`
    - `SystemConfiguration`
    - `UIKit`    


<a id="modify"></a> 
## Modify Code

1. Open your `AppDelegate.h` file.

2. Add the following line at the top of the file below your own #import statements:

        #import <HockeySDK/HockeySDK.h>

3. Let the AppDelegate implement the protocols `BITHockeyManagerDelegate`:


        @interface AppDelegate : UIResponder <UIApplicationDelegate, BITHockeyManagerDelegate>
        @property (strong, nonatomic) UIWindow *window;
        @end

4. Search for the method `application:didFinishLaunchingWithOptions:`

5. Add the following lines:

        [[BITHockeyManager sharedHockeyManager] configureWithBetaIdentifier:@"BETA_IDENTIFIER"
                                                             liveIdentifier:@"LIVE_IDENTIFIER"
                                                                   delegate:self];
        [[BITHockeyManager sharedHockeyManager] startManager];

6. Replace `BETA_IDENTIFIER` with the app identifier of your beta app. If you don't know what the app identifier is or how to find it, please read [this how-to](http://support.hockeyapp.net/kb/how-tos/how-to-find-the-app-identifier). 

7. Replace `LIVE_IDENTIFIER` with the app identifier of your release app. We suggest to setup different apps on HockeyApp for your test and production builds. You usually will have way more test versions, but your production version usually has way more crash reports. This helps to keep data separated, getting a better overview and less trouble setting the right app versions downloadable for your beta users.

8. If you want to use the beta distribution feature on iOS 7 or later with In-App Updates, restrict versions to specific users or want to know who is actually testing your app, you need to follow the instructions on our guide [Identify and authenticate users of Ad-Hoc or Enterprise builds](HowTo-Authenticating-Users-on-iOS)

*Note:* The SDK is optimized to defer everything possible to a later time while making sure e.g. crashes on startup can also be caught and each module executes other code with a delay some seconds. This ensures that applicationDidFinishLaunching will process as fast as possible and the SDK will not block the startup sequence resulting in a possible kill by the watchdog process.


<a id="mac"></a> 
## Mac Desktop Uploader

The Mac Desktop Uploader can provide easy uploading of your app versions to HockeyApp. Check out the [installation tutorial](Guide-Installation-Mac-App).

<a id="documentation"></a> 
## Xcode Documentation

This documentation provides integrated help in Xcode for all public APIs and a set of additional tutorials and HowTos.

1. Copy `de.bitstadium.HockeySDK-iOS-3.5.0.docset` into ~`/Library/Developer/Shared/Documentation/DocSet`

The documentation is also available via the following URL: [http://hockeyapp.net/help/sdk/ios/3.5.0rc3/](http://hockeyapp.net/help/sdk/ios/3.5.0rc3/)
