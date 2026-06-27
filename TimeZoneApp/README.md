# TimeZoneApp - World Clocks for iOS

A simple iOS app that displays up to 6 selected timezone times with widget support.

## Features

- **Select up to 6 timezones** from a curated list of major cities
- **Real-time clock updates** - times update every second
- **iOS Widget support** - view your selected times right on your home screen
- **Clean, modern interface** with dark mode support
- **Easy timezone management** - add, remove, and reorder timezones

## App Preview

The app allows users to:
1. View current time in up to 6 different timezones
2. Add/remove timezones from a selection of major cities
3. See live updates every second
4. View timezone information in a widget on the home screen

## Project Structure

```
TimeZoneApp/
├── TimeZoneApp/              # Main app target
│   ├── Models/
│   │   └── TimeZoneModel.swift  # Data models and timezone management
│   ├── ViewControllers/
│   │   ├── TimeZoneListViewController.swift  # Main list view
│   │   └── TimeZoneSelectionViewController.swift  # Timezone picker
│   ├── Views/
│   │   ├── TimeZoneCell.swift  # Custom cell for timezone display
│   │   └── TimeZoneSelectionCell.swift  # Custom cell for selection
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── Info.plist
├── TimeZoneAppWidget/        # Widget extension
│   ├── TimeZoneAppWidget.swift  # Widget implementation
│   └── Info.plist
└── TimeZoneApp.xcodeproj     # Xcode project file
```

## Setup Instructions

### Prerequisites

1. **Xcode 15+** - Download from the Mac App Store
2. **Apple Developer Account** - Free account for development, $99/year for App Store submission
3. **iOS 15+** - The app requires iOS 15 or later

### Step 1: Clone and Open the Project

```bash
# Clone the repository
git clone https://github.com/sghinescu/myrepo.git
cd myrepo/TimeZoneApp

# Open in Xcode
open TimeZoneApp.xcodeproj
```

### Step 2: Configure the Project

1. **Set your bundle identifier**:
   - In Xcode, select the project in the Project Navigator
   - Go to "General" tab
   - Change "Bundle Identifier" to something unique like `com.yourname.TimeZoneApp`

2. **Enable App Groups for Widget Sharing**:
   - Go to "Signing & Capabilities" tab
   - Click "+ Capability"
   - Add "App Groups"
   - Create a new app group: `group.com.yourname.TimeZoneApp`
   - Make sure both the main app and widget extension have this capability

3. **Update the App Group in Code**:
   - Open `TimeZoneModel.swift`
   - Change the app group identifier to match what you created:
   ```swift
   private let userDefaults = UserDefaults(suiteName: "group.com.yourname.TimeZoneApp")
   ```

### Step 3: Configure the Widget

1. **Update Widget Bundle Identifier**:
   - Open `TimeZoneAppWidget/Info.plist`
   - Change the `CFBundleIdentifier` to match your app: `com.yourname.TimeZoneApp.TimeZoneAppWidget`

2. **Update Widget Group Identifier**:
   - Make sure the widget uses the same app group as the main app

### Step 4: Build and Run

1. **Select a simulator or device** in Xcode
2. **Click the Run button** (or press Cmd+R)
3. **Test the app**:
   - Add timezones by tapping the + button
   - Verify times update every second
   - Test the widget on the home screen

## App Store Submission Guide

### Step 1: Prepare Your App for Submission

#### 1. Create App Store Connect Record
1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Click "My Apps"
3. Click the + button and select "New App"
4. Fill in the details:
   - **App Name**: World Clocks (or your preferred name)
   - **Bundle ID**: Must match your Xcode project (e.g., com.yourname.TimeZoneApp)
   - **SKU**: A unique identifier for your app (e.g., WORLD-CLOCKS-001)
   - **Primary Language**: Select your main language

#### 2. Prepare App Metadata

**App Information:**
- **Subtitle**: Display times from around the world
- **Category**: Utilities or Travel
- **Age Rating**: 4+ (no objectionable content)
- **Price**: Free (or set your price)

**App Privacy:**
- **Data Collection**: Select "No" for all options (this app doesn't collect any data)

**Pricing and Availability:**
- **Price**: Free
- **Availability**: All countries/regions

### Step 2: Create App Store Assets

#### 1. App Icons
Create icons in the following sizes:
- **App Icon**: 1024x1024 (for App Store)
- **iOS App Icon**: 180x180, 167x167, 152x152, etc.

Use the standard iOS app icon template. You can create these using:
- **Sketch** or **Figma** (recommended)
- **Online tools** like appicon.co
- **Xcode's built-in icon generator**

#### 2. Screenshots
Create screenshots for different device sizes:
- **6.5" Display** (iPhone 11 Pro Max, 12 Pro Max, etc.): 1242x2688
- **5.5" Display** (iPhone 8 Plus, etc.): 1242x2208
- **5.8" Display** (iPhone 11 Pro, 12 Pro, etc.): 1125x2436
- **12.9" Display** (iPad Pro): 2048x2732

**Screenshot Requirements:**
- Show the main functionality (timezone list, selection screen)
- Highlight key features
- Use real device screenshots (not simulator)
- No status bar in screenshots

#### 3. App Preview Video (Optional but Recommended)
- **Duration**: 15-30 seconds
- **Format**: M4V, MP4, or MOV
- **Resolution**: Match the device you're targeting
- **Show**: App launch, adding timezones, widget in action

### Step 3: Configure App in Xcode

#### 1. Set Version and Build Number
1. In Xcode, select the project
2. Go to "General" tab
3. **Version**: 1.0.0 (or your version)
4. **Build**: 1 (increment for each submission)

#### 2. Set App Store Metadata
1. Select the project target
2. Go to "General" tab
3. **Display Name**: World Clocks
4. **Bundle Identifier**: com.yourname.TimeZoneApp
5. **Version**: 1.0.0
6. **Build**: 1

### Step 4: Archive and Upload the App

#### 1. Archive the App
1. Make sure your device/simulator is selected
2. Go to **Product > Archive** in Xcode
3. Wait for the archive to complete
4. The Organizer window will open

#### 2. Upload to App Store Connect
1. In the Organizer, select your archive
2. Click **Distribute App**
3. Select **App Store Connect**
4. Click **Next**
5. Select **Upload** (not Export)
6. Select your **Team**
7. Select your **App** from the list
8. Click **Next**
9. Wait for the upload to complete
10. Click **Done**

### Step 5: Submit for Review

#### 1. Complete App Store Connect Setup
1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Select your app
3. Go to **App Store > App Information** and complete all required fields
4. Go to **App Store > Features** and add your screenshots and videos
5. Go to **App Store > App Privacy** and complete the questionnaire
6. Go to **App Store > Pricing and Availability** and set your price

#### 2. Prepare for Review
1. Go to **App Store > Prepare for Submission**
2. **Build**: Select the build you uploaded
3. **What's New in This Version**: Initial release of World Clocks app
4. **Promotional Text** (optional): "Keep track of time around the world with this simple and elegant app."
5. **Description**:
   ```
   World Clocks is a simple and elegant app that helps you keep track of time in different timezones around the world.
   
   Features:
   - Display up to 6 different timezone times simultaneously
   - Real-time updates every second
   - Beautiful iOS widget for quick access
   - Easy timezone selection from major cities worldwide
   - Clean, modern interface with dark mode support
   - No ads, no tracking, completely free
   
   Perfect for:
   - Frequent travelers
   - Remote workers with international teams
   - Anyone who needs to coordinate across timezones
   ```

6. **Keywords**: timezone, world clock, time, international, travel, widget, utility
7. **Support URL**: Your website or GitHub repository
8. **Marketing URL** (optional): Your marketing website

#### 3. Submit for Review
1. Click **Save** in the top right
2. Click **Submit for Review**
3. Confirm the submission

### Step 6: Wait for Review

- **Review Time**: Typically 1-3 days, but can take longer
- **Status**: You'll receive email notifications about the review status
- **Possible Outcomes**:
  - **Approved**: Your app will be available on the App Store within 24 hours
  - **Rejected**: You'll receive details about what needs to be fixed
  - **Metadata Rejected**: Only your metadata needs changes, not the binary

## Common App Store Rejection Reasons and Fixes

### 1. Missing Privacy Policy
**Issue**: Apps that collect user data must have a privacy policy
**Fix**: Even though this app doesn't collect data, add a simple privacy policy URL in App Store Connect

### 2. App Crashes on Launch
**Issue**: App crashes during review
**Fix**: Test thoroughly on all supported devices and iOS versions

### 3. Missing App Icons
**Issue**: App icons not properly configured
**Fix**: Make sure all required icon sizes are included in the Assets catalog

### 4. Widget Not Working
**Issue**: Widget doesn't display or update
**Fix**: 
- Ensure App Groups are properly configured
- Test widget on a real device
- Make sure the widget extension is included in the archive

### 5. Bundle Identifier Mismatch
**Issue**: Bundle ID in Xcode doesn't match App Store Connect
**Fix**: Update the bundle identifier in both places to match exactly

## Testing Your App

### Test Cases to Verify

1. **Basic Functionality**
   - [ ] App launches without crashing
   - [ ] Can add timezones
   - [ ] Can remove timezones
   - [ ] Times update every second
   - [ ] Maximum of 6 timezones enforced

2. **Widget Functionality**
   - [ ] Widget displays on home screen
   - [ ] Widget shows selected timezones
   - [ ] Widget updates every second
   - [ ] Widget shows correct number of timezones

3. **Edge Cases**
   - [ ] App works in portrait and landscape (if supported)
   - [ ] App works in dark mode
   - [ ] App handles timezone changes correctly
   - [ ] App persists selected timezones between launches

4. **Device Compatibility**
   - [ ] Test on iPhone (various sizes)
   - [ ] Test on iPad (if supported)
   - [ ] Test on different iOS versions (15+)

## Troubleshooting

### Widget Not Showing Up
1. Make sure you've added the widget in the Today View or Home Screen
2. Check that App Groups are properly configured
3. Verify the widget extension is included in your app target
4. Restart your device

### Times Not Updating
1. Check that the timer is running in TimeZoneListViewController
2. Verify that the widget timeline is set to refresh every second
3. Make sure the timezone identifiers are valid

### App Crashes on Launch
1. Check the console for error messages
2. Verify all IBOutlets are connected properly
3. Make sure all required files are included in the target

## Next Steps for Your App

### Version 2.0 Ideas
1. **Custom Timezones**: Allow users to search for any timezone, not just major cities
2. **Timezone Conversion**: Add a feature to convert between timezones
3. **World Map View**: Show selected timezones on a map
4. **Customization**: Allow users to customize colors, fonts, and widget appearance
5. **Notifications**: Add reminders for specific times in different timezones
6. **iCloud Sync**: Sync selected timezones across devices
7. **Apple Watch App**: Companion watch app

### Marketing Your App
1. **Create a Website**: Simple landing page with screenshots and download link
2. **Social Media**: Share on Twitter, Instagram, Reddit
3. **App Preview Video**: Create a compelling demo video
4. **Press Kit**: Prepare screenshots and descriptions for bloggers
5. **ASO (App Store Optimization)**: Use relevant keywords in your description

## Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [WidgetKit Documentation](https://developer.apple.com/documentation/widgetkit/)

## License

This project is provided as-is for educational purposes. Feel free to use it as a starting point for your own app.

## Support

If you have questions or need help with the App Store submission process, feel free to reach out.

---

**Happy Coding!** 🚀

Your first iOS app is ready for the App Store! Follow these steps carefully, and you'll have your app available for download in no time.
