-- Imports
import XMonad
import XMonad.Actions.CycleWS (nextWS, prevWS, shiftToNext, shiftToPrev)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.BoringWindows
import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.Minimize
import XMonad.Layout.Named
import XMonad.Layout.OneBig
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Reflect
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Util.NamedWindows
import XMonad.Util.Run (spawnPipe, safeSpawn)
import Graphics.X11.ExtraTypes.XF86
import System.IO (hPutStrLn)
import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- Start!
main = do
    workspaceBar <- spawnPipe myWorkspaceBar
    xmonad $ withUrgencyHook NotifyUrgencyHook $ ewmh defaultConfig {
        terminal = myTerminal,
        borderWidth = myBorderWidth,
        focusFollowsMouse = myFocusFollowsMouse,
        normalBorderColor = background,
        focusedBorderColor = color9,
        handleEventHook = fullscreenEventHook,
        workspaces = myWorkspaces,
        layoutHook = myLayoutHook,
        logHook = myLogHook workspaceBar,
        manageHook = myManageHook,
        keys = myKeys <+> keys defaultConfig
    }

-- Variables
myTerminal = "terminator"
myBorderWidth = 0
myFont = "Ubuntu:style=Regular:pixelsize=12"
myFocusFollowsMouse = False

-- Bars
myWorkspaceBar = "dzen2 -ta 'l' -fg '" ++ foreground ++  "' -bg '" ++ background ++ "' -fn '" ++ myFont ++ "'"

-- Colors from https://github.com/bohoomil
foreground = "#e6e6e6"
background = "#090c19"

color0  = "#222946"
color8  = "#8c8b89"

color1  = "#be1919"
color9  = "#dc2f32"

color2  = "#1aaa13"
color10 = "#5dce33"

color3  = "#ffaa3e"
color11 = "#fadd2d"

color4  = "#3753cc"
color12 = "#507cff"

color5  = "#be007f"
color13 = "#e65cd0"

color6  = "#14bdcc"
color14 = "#48f3f3"

color7  = "#aeaeae"
color15 = "#dbdde4"

-- Urgency Hook
data NotifyUrgencyHook = NotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook NotifyUrgencyHook where
    urgencyHook _ w = do
        name <- getName w
        ws <- gets windowset
        whenJust (W.findTag w ws) (notify name)
        where notify n w = safeSpawn "notify-send" $ ["XMonad", show n ++ " requests your attention on " ++ show w]

-- Workspaces
myWorkspaces = ["Shell", "Web", "Docs", "Chat"]

-- Log Hook
myLogHook h = dynamicLogWithPP $ defaultPP {
    ppOutput = hPutStrLn h,
    ppOrder = \(ws:l:t:_) -> [ws, l, t],
    ppWsSep = "  ",
    ppSep = "  ",
    ppCurrent = dzenColor color6 background . pad,
    ppUrgent = dzenColor foreground color1 . pad,
    ppVisible = dzenColor foreground background . pad,
    ppHidden = dzenColor foreground background . pad,
    ppHiddenNoWindows = dzenColor color0 background . pad,
    ppLayout = dzenColor background color11 . pad . layoutText,
    ppTitle = dzenColor color11 background . pad . titleText
}
    where
        titleText x = shorten 100 x
        layoutText x = x

-- Manage Hook
myManageHook = composeAll
    [
        -- Web workspace
        resource =? "chromium" --> doShiftAndGo (myWorkspaces !! 1),
        -- Docs workspace
        resource =? "zathura" --> doShiftAndGo (myWorkspaces !! 2),
        className =? "libreoffice-startcenter" --> doShiftAndGo (myWorkspaces !! 2),
        className =? "libreoffice-writer" --> doShiftAndGo (myWorkspaces !! 2),
        className =? "libreoffice-calc" --> doShiftAndGo (myWorkspaces !! 2),
        className =? "libreoffice-impress" --> doShiftAndGo (myWorkspaces !! 2),
        -- Chat workspace
        className =? "Pidgin" --> doShiftAndGo (myWorkspaces !! 3),
        -- Float
        className =? "feh" --> doCenterFloat,
        className =? "mplayer2" --> doCenterFloat,
        isDialog --> doCenterFloat,
        isFullscreen --> doFullFloat,
        fullscreenManageHook,
        manageDocks
    ]
    <+> manageHook defaultConfig
    where
        doShiftAndGo ws = doF (W.greedyView ws) <+> doShift ws

-- Layouts
myTile = named "T"
    $ spacing 2
    $ minimize
    $ ResizableTall 1 (5/100) (1/2) []

myOBig = named "O"
    $ spacing 2
    $ minimize
    $ OneBig (2/3) (2/3)

myFull = named "F"
    $ minimize
    $ fullscreenFocus Full

myChat = named "C"
    $ spacing 2
    $ minimize
    $ reflectHoriz
    $ withIM (1/5) (Title "Buddy List")
    $ GridRatio 2

myGrid = named "G"
    $ spacing 2
    $ minimize
    $ GridRatio 2

myLayoutHook = id
    $ avoidStruts
    $ boringWindows
    $ onWorkspace (myWorkspaces !! 3) chatLayout
    $ defaultLayout
    where
        defaultLayout = (myTile ||| myOBig ||| myGrid ||| myFull)
        chatLayout = myChat

-- Keybinding
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
    [
        ((mod1Mask, xK_F4), kill),
        ((mod4Mask, xK_l), spawn "xscreensaver-command --lock"),
        ((mod4Mask, xK_e), spawn "thunar"),
        ((mod4Mask, xK_r), spawn "gmrun"),
        ((mod1Mask .|. shiftMask .|. controlMask, xK_Left), shiftToPrev >> prevWS),
        ((mod1Mask .|. shiftMask .|. controlMask, xK_Right), shiftToNext >> nextWS),
        ((mod4Mask, xK_d), withFocused minimizeWindow),
        ((mod4Mask .|. shiftMask, xK_d), sendMessage RestoreNextMinimizedWin),

        ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5+"),
        ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5-"),
        ((0, xF86XK_AudioMute), spawn "amixer set Master toggle"),
        ((0, xK_Print), spawn "scrot '%F_%T_$wx$h.png'")
    ]
