--Imports.
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.Dishes
import XMonad.Layout.StackTile
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import qualified Data.Map        as M

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { 
      ppTitle   = xmobarColor "#00FF00" "" . shorten 100
    , ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" 
}

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Layouts
myLayout = avoidStruts $ 
--    Tall 1 (3/100) (1/2) |||
    ResizableTall 1 (3/100) (1/2) [] |||
    Mirror (ResizableTall 1 (3/100) (1/2) []) |||
--    tabbed shrinkText tabConfig |||
--    spiral (6/7) |||
--    Mirror (Dishes 2 (1/6)) |||
--    StackTile 1 (3/100) (1/2) |||
--    Mirror (StackTile 1 (3/100) (1/2)) |||
    Full


tabConfig = defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
}



-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig 
    {   modMask    = modMask'
      , terminal   = terminal'
      , workspaces = workspaces'
      , keys       = keys' <+> keys defaultConfig
      , layoutHook = layoutHook'
      , manageHook = manageHook' 
    }

modMask' = mod4Mask

keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList
    [
    -- Dmenu
      ((modMask, xK_d), 
       spawn "dmenu_run")

     , ((modMask, xK_a), 
       sendMessage MirrorShrink)
 
     , ((modMask, xK_z), 
       sendMessage MirrorExpand)

    -- Mute volume.
    , ((modMask .|. controlMask, xK_m),
       spawn "amixer -q set Master toggle")
  
    -- Decrease volume.
    , ((modMask .|. controlMask, xK_j),
       spawn "amixer -q set Master 10%-")
  
    -- Increase volume.
    , ((modMask .|. controlMask, xK_k),
       spawn "amixer -q set Master 10%+")
  
    -- Audio previous.
    , ((0, 0x1008FF16),
       spawn "")
  
    -- Play/pause.
    , ((0, 0x1008FF14),
       spawn "")
  
    -- Audio next.
    , ((0, 0x1008FF17),
       spawn "")
    ]

terminal' = "urxvt"

workspaces' = ["1-main", "2-web", "3-media", "4-im", "5-torrents", "6", "7", "8", "9"]

layoutHook' = smartBorders $ myLayout

manageHook' = composeAll
                 [   isFullscreen                    --> doFullFloat
                   , className =? "Google-chrome"    --> doShift "2-web"
                   , className =? "Spotify"          --> doShift "3-media"
                   , className =? "Skype"            --> doShift "4-im"
                   , className =? "Transmission-gtk" --> doShift "5-torrents"
		   , className =? "Gimp"             --> doFloat
		   , insertPosition Below Newer
		   , transience'
		 ]
