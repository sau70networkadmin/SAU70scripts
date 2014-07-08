#!/bin/sh

# BE ROOT.

# Der Flounder script to suppress iCloud popup on first login.
# From http://derflounder.wordpress.com/2013/10/27/disabling-the-icloud-sign-in-pop-up-message-on-lion-and-later/
# Marion added about 100 other things to do to the local user template spring 2014 

# Determine OS version
osvers=$(sw_vers -productVersion | awk -F. '{print $2}')
sw_vers=$(sw_vers -productVersion)
 
# Set the login and logout hooks
defaults write com.apple.loginwindow LoginHook /usr/local/bin/LoginHooks.sh 
defaults write com.apple.loginwindow LogoutHook /usr/local/bin/LogoutHooks.sh 

# Checks first to see if the Mac is running 10.7.0 or higher. 
# If so, the script writes to the system default user templates so that new accounts inherit settings
# Equivalents of most of these commands live in /usr/loca/bin/LoginHooks.sh
 
if [[ ${osvers} -ge 7 ]]; then
 
 for USER_TEMPLATE in "/System/Library/User Template"/*
  do
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
    defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences NSNavPanelExpandedStateForSaveMode -bool TRUE
    defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences AppleShowAllExtensions -bool true
    defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences PMPrintingExpandedStateForPrint -bool true
    defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences NSDocumentSaveNewDocumentsToCloud -bool false
    defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences AppleKeyboardUIMode -int 3
    defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences ApplePressAndHoldEnabled -bool false
    defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences KeyRepeat -int 0
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.finder NewWindowTarget -string "PfLo"
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.finder NewWindowTargetPath -string "file:///Users/$THISUSER/"
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.finder ShowPathbar -bool true
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.finder ShowStatusBar -bool true
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.finder _FXShowPosixPathInTitle -bool true
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.finder FXPreferredViewStyle -string "Nlsv"
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.loginwindow TALLogoutSavesState 0
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.LaunchServices LSQuarantine -bool false
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.universalaccess closeViewScrollWheelToggle -bool true
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.universalaccess closeViewZoomFollowsFocus -bool true
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.airplay showInMenuBarIfPresent -bool false
  done
fi

# ---------------------------

# Put the com.apple.sidebarlists.plist file in the User Template/English.lproj folder;
# chown root:wheel it;
# chmod 600 it;
# xattr -c it

# KILL the notification center altogether.
defaults write /System/Library/LaunchAgents/com.apple.notificationcenterui KeepAlive -bool false

# Show useful info on the login screen if you click the datetime. This may already be built-in nowadays.
defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Suppress Time Machine icon in menu bar? doesn't seem to work.
defaults write System/Library/CoreServices/ManagedClient.app/Contents/Resources/com.apple.mcxMenuExtras.manifest/Contents/Resources/com.apple.mcxMenuExtras.manifest TimeMachine.menu -bool NO 