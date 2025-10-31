# Localisation

## Info.plist
Every permission we request from the user also needs a description as a string. I currently have these for English and German, so we can explain to the user in their language which permissions are required for what.

You can find the file for this in /App/InfoPlist.strings.

The format is quite simple – in both German and English, Xcode will show you InfoPlist (English) and InfoPlist (German). In VS Code, it is displayed in the folder ‘de.lproj’ and ‘en.lproj’. 

‘PERMISSION STRING’ = ‘Text of the permission request.’;

It is important that the strings clearly describe what is being requested in order to comply with Apple's HIG.

## General Locales
For general localisation, I use the Localizable.xcstrings catalogue.

Here we also have the English and German localisations.

# Principals
The structure is kept very simple:

‘ViewName - Exact String’ (this makes it easier to maintain and understand)
