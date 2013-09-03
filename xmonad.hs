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

	 	[className=? "Firefox" --> doShift "6:firefox"],
		
		[manageDocks] -- Must for trayer to appear on all workspaces
	]


-- Run XMonad with the defaults
main=do
	xmproc <- spawnPipe "xbindkeys"
	xmproc <- spawnPipe "feh --bg-fill ~/Pictures/pattern-wallpaper.png"
	xmproc <- spawnPipe "nautilus --no-desktop -n" -- Show all partitions in nautilus
	xmporc <- spawnPipe "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x000000 --height 17 &"
	xmproc <- spawnPipe "nm-applet --sm-disable &"
	xmproc <- spawnPipe "gnome-power-manager &"
	xmproc <- spawnPipe "dropbox start"
	xmproc <- spawnPipe "xmobar"

	xmonad $defaultConfig {
		logHook = dynamicLogWithPP xmobarPP
		{ 
			ppOutput = hPutStrLn xmproc,
			ppTitle = xmobarColor "green" "" . shorten 50
		},

		terminal=myTerminal,
		workspaces=myWorkspaces,

		-- Java window drawing bug
		-- This makes xmonad 'appear' as other WM for Java apps
		startupHook=setWMName "LG3D",

		-- xmobar wont start correctly w/o these 2 lines
		manageHook=myManageHooks <+> manageHook defaultConfig,
		layoutHook=avoidStruts $ layoutHook defaultConfig,

		borderWidth=1,

		-- Google chrome fullscreen
		handleEventHook= fullscreenEventHook

	}
