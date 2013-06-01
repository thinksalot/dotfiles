-- Import statements
import XMonad
import Control.Monad
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ManageDocks			-- tray management
import XMonad.Hooks.DynamicLog			-- Status bar
import qualified XMonad.StackSet as W
import System.IO

import XMonad.Hooks.EwmhDesktops		-- Google chrome fullscreen hook
import XMonad.Hooks.SetWMName			-- Java window drawing bug

-- default terminal
myTerminal="gnome-terminal"

-- workspaces
myWorkspaces=["1:web","2:skype","3:vim","4:command","5:filemanager","6:firefox","7:extra1","8:extra2","9:extra3"]

myManageHooks=composeAll.concat $
	[
		[className=? "Google-chrome" --> doShift "1:web"],

	 	[className=? "Skype" --> doShift "2:skype"],

	 	[title=? "Syncro SVN Client" --> doShift "4:command"],

	 	[className=? "Nautilus" --> doShift "5:filemanager"],

	 	[className=? "Firefox" --> doShift "6:firefox"]
	]


-- Run XMonad with the defaults
main=do
	xmproc <- spawnPipe "xbindkeys"
	xmproc <- spawnPipe "feh --bg-fill ~/Pictures/red.png"
	xmonad $defaultConfig {
		terminal=myTerminal,
		workspaces=myWorkspaces,

		-- Java window drawing bug
		-- This makes xmonad 'appear' as other WM for Java apps
		startupHook=setWMName "LG3D",

		-- xmobar wont start correctly w/o these 2 lines
		manageHook=myManageHooks,
		layoutHook=avoidStruts $ layoutHook defaultConfig,

		borderWidth=2,

		-- Google chrome fullscreen
		handleEventHook= fullscreenEventHook

	}