
import System.IO
import System.Exit
import XMonad
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WindowGo
import XMonad.Config.Azerty
import System.Environment (getEnvironment)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import qualified XMonad.Layout.IndependentScreens as LIS
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import qualified Data.Map        as M


xmobarTitleColor = "#FFB6B0"
xmobarCurrentWorkspaceColor = "#CEFFAC"

myWorkspaces = ["1:work", "2:prog", "3:web"] ++ map show [4..6]

myConfig = azertyConfig {
    workspaces = myWorkspaces,
    manageHook = manageDocks,
    startupHook = setWMName "LG3D"
}

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ myConfig {
--        modMask = mod4Mask,
        borderWidth = 4,
        normalBorderColor="#7c7c7c",
        focusedBorderColor="#ffb6b0",
        layoutHook = customLayout,
        logHook = dynamicLogWithPP xmobarPP {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor xmobarTitleColor "" . shorten 100,
            ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "",
            ppSep = "   "
        } >> updatePointer Nearest
    } `additionalKeysP` myKeys

myKeys = [  (("M-f"), runOrRaise "firefox" (className =? "Firefox")) ]

customLayout = avoidStruts $ tiled ||| Mirror tiled ||| Full
  where
    tiled = spacing 5 $ Tall nmaster delta ratio
    nmaster = 2
    ratio = 1/3
    delta = 5/100

