# Live Music Recognition iOS App

Quick install

1. Clone the repo:

```zsh
git clone https://github.com/johannes-bln/LiveMusic.git
```

2. Enter the project folder:

```zsh
cd LiveMusic
```

3. If Homebrew isn’t installed, install it:

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Links:

- Homebrew website: https://brew.sh/
- Homebrew on GitHub: https://github.com/Homebrew/brew

4. Install dependencies from the Brewfile:

```zsh
brew bundle
```

5. Open the Xcode project:

```zsh
open LiveMusic.xcodeproj
```

6. Select the Scheme "Debug"

7. Change the Bundle Indetifier to your own identifier (both in debug and release) - having 2 bundle identifier, is more simple to see debug and release on the go!

8. Go to [developer.apple.com/account ](https://developer.apple.com/account)

8. Navigate to [indentifiers ](https://developer.apple.com/account/resources/identifiers/list) 

9. Create a new identifier ("App IDs" -> "App") or select a existing for this project

10. select "App Services" and checkmark "MusicKit" and "ShazamKit" 

11. Hit Save and Confirm

12. Repeat this for the same bundle identifier as a new bundle.identifier.**debug** with the ".debug" at the end

13. This sometimes takes up to 30 min, so if you encounter errors with the Frameworks (it should be normal in this time ^^)

14. Finaly: Build & Run 🔨

Enjoy! — Quick and simple.

## a11y - Accessibility:
It's really important. Here's a small example:
There's a song title and a song artist. Someone might not know what the title is and who the artist is, so VoiceOver MUST say this out loud. We do this by specifying it explicitly and also localising it.

## SwiftLint
Swift Lint shows you code formatting errors directly, as in this example. We have debugPrint because it automatically checks whether it is running in debug or release mode. Please note these warnings for clean code. THANK YOU! :)

<img width="1881" height="152" alt="image" src="https://github.com/user-attachments/assets/b4b5a57a-870e-41c9-b88e-53562d3d8fa6" />
*Pro tip: Press Control + Shift + I to format the code. 🙂*


## How it works? - Creating 2 Bundle with different App Namens (for Debug and Release) and Using them by the Scheme is quite simple

1. Add "CFBundleDisplayName" with is the "Bundle display name" and add as String "$(APP_DISPLAY_NAME)" 

2. Add a User defined Build Setting 

3. Name it "APP_DISPLAY_NAME"

4. Now you can Add a Name for the Debug and a Name for the Release