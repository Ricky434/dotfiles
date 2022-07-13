  -- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust, isJust)
import Data.Monoid
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WorkspaceHistory

    -- Layouts
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
import XMonad.Util.Dmenu --inutile??
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

   -- ColorScheme module (SET ONLY ONE!)
      -- Possible choice are:
      -- DoomOne
      -- Dracula
      -- GruvboxDark
      -- MonokaiPro
      -- Nord
      -- OceanicNext
      -- Palenight
      -- SolarizedDark
      -- SolarizedLight
      -- TomorrowNight
import Colors.DoomOne

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "kitty"    -- Sets default terminal

myBrowser :: String
myBrowser = "firefox"  -- Sets firefox as browser

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' "  -- Makes emacs keybindings easier to type

myEditor :: String
myEditor = "nvim"  -- Sets nvim as editor
-- myEditor = myTerminal ++ " -e vim "    -- Sets vim as editor

myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows

myNormColor :: String       -- Border color of normal windows
myNormColor   = colorBack   -- This variable is imported from Colors.THEME

myFocusColor :: String      -- Border color of focused windows
myFocusColor  = color15     -- This variable is imported from Colors.THEME

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
          spawn "killall trayer"

          spawnOnce "killall dunst; dunst"
          spawnOnce "nitrogen --restore &"
          spawnOnce "picom"
          spawnOnce "xinput --set-prop \"Logitech G203 Prodigy Gaming Mouse\" 'libinput Accel Profile Enabled' 0, 1 &"
          spawnOnce "xset s off; xset dpms 0 0 3600 &"
          spawnOnce "killall redshift; redshift-gtk -t 6500:4550 &"
          spawnOnce "/usr/lib/polkit-kde-authentication-agent-1 &"
          -- spawnOnce "polybar -q bottom -c $HOME/.config/polybar/current/config.ini &"
          spawn ("sleep 2 && trayer --edge bottom --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --transparent true --alpha 0 --iconspacing 3 " ++ colorTrayer ++ " --height 22")
          spawnOnce "nm-applet --indicator &"
          spawnOnce "pasystray"
          setWMName "XMONAD"
          spawnOnce "emacs --daemon"

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "calculator" spawnCalc findCalc manageCalc
                ]
  where
    spawnTerm  = myTerminal ++ " --title scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnCalc  = "kcalc"
    findCalc   = className =? "kcalc"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
magnifyReplaced  = renamed [Replace "magnify"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20 simplestFloat

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = color15
                 , inactiveColor       = color08
                 , activeBorderColor   = color15
                 , inactiveBorderColor = colorBack
                 , activeTextColor     = colorBack
                 , inactiveTextColor   = color16
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Ubuntu:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth tall
                                 ||| magnifyReplaced
                                 ||| noBorders monocle
                                 -- ||| floats
                                 ||| noBorders tabs

myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
-- myWorkspaces = [" dev ", " www ", " sys ", " doc ",  vbox ", " chat ", " mus ", " vid ", " gfx "]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces and the names would be very long if using clickable workspaces.
     [ className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "gufw"            --> doFloat
     , className =? "Pavucontrol"     --> doFloat
     , className =? "Yad"             --> doCenterFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     -- , className =? "Yad"             --> doCenterFloat
     , title =? "Oracle VM VirtualBox Manager"  --> doFloat
     , title =? "calcurse" --> doFloat
     -- , title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 1 )
     -- , className =? "mpv"             --> doShift ( myWorkspaces !! 7 )
     -- , className =? "VirtualBox Manager" --> doShift  ( myWorkspaces !! 4 )
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
     , isFullscreen -->  doFullFloat
     ] <+> namedScratchpadManageHook myScratchPads

-- START_KEYS
myKeys :: [(String, X ())]
myKeys =
    -- Xmonad
        [ ("M-C-r", spawn "xmonad --recompile")       -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")         -- Restarts xmonad
        , ("M-S-q", io exitSuccess)                   -- Quits xmonad

    -- KB_GROUP Get Help
        , ("M-S-/", spawn "~/.xmonad/xmonad_keys.sh") -- Get list of keybindings

    -- KB_GROUP Run Prompt
        -- , ("M-S-<Return>", spawn "dmenu_run -i -p \"Run: \"") -- Dmenu
        , ("M-<Space>", spawn "rofi -show drun -theme prompt") -- Rofi
        , ("M1-<Tab>", spawn "rofi -show window") -- Mostra programmi aperti, windowcd mostra programmi aperti nel workspace corrente

    -- KB_GROUP Useful programs to have a keybinding for launch
        , ("M-<Return>", spawn (myTerminal))
        , ("M-b", spawn (myBrowser))
        , ("M-M1-h", spawn (myTerminal ++ " -e htop"))

    -- KB_GROUP Kill windows
        , ("M-S-c", kill1)     -- Kill the currently focused client
        -- (RISCHIOSO) , ("M-S-a", killAll)   -- Kill all windows on current workspace

    -- KB_GROUP Workspaces
        , ("M-.", moveTo Next nonNSP)  -- Switch focus to next monitor
        , ("M-,", moveTo Prev nonNSP)  -- Switch focus to prev monitor
        , ("M-S-.", shiftTo Next nonNSP >> moveTo Next nonNSP)       -- Shifts focused window to next ws
        , ("M-S-,", shiftTo Prev nonNSP >> moveTo Prev nonNSP)  -- Shifts focused window to prev ws

    -- KB_GROUP Floating windows
        , ("M-f", sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
        , ("M-t", withFocused $ windows . W.sink)  -- Push floating window back to tile
        , ("M-S-t", sinkAll)                       -- Push ALL floating windows to tile

    -- KB_GROUP Increase/decrease spacing (gaps)
        , ("C-M1-j", decWindowSpacing 4)         -- Decrease window spacing
        , ("C-M1-k", incWindowSpacing 4)         -- Increase window spacing
        , ("C-M1-h", decScreenSpacing 4)         -- Decrease screen spacing
        , ("C-M1-l", incScreenSpacing 4)         -- Increase screen spacing

    -- KB_GROUP Windows navigation
        , ("M-m", windows W.focusMaster)  -- Move focus to the master window
        , ("M-j", windows W.focusDown)    -- Move focus to the next window
        , ("M-k", windows W.focusUp)      -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
        , ("M-<Backspace>", promote)      -- Moves focused window to master, others maintain order
        , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
        , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack

    -- KB_GROUP Layouts
        , ("M-<Tab>", sendMessage NextLayout)           -- Switch to next layout
        , ("M-S-<Return>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full

    -- KB_GROUP Increase/decrease windows in the master pane or the stack
        , ("M-S-<Up>", sendMessage (IncMasterN 1))      -- Increase # of clients master pane
        , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Decrease # of clients master pane
        , ("M-C-<Up>", increaseLimit)                   -- Increase # of windows
        , ("M-C-<Down>", decreaseLimit)                 -- Decrease # of windows

    -- KB_GROUP Window resizing
        , ("M-h", sendMessage Shrink)                   -- Shrink horiz window width
        , ("M-l", sendMessage Expand)                   -- Expand horiz window width
        , ("M-M1-j", sendMessage MirrorShrink)          -- Shrink vert window width
        , ("M-M1-k", sendMessage MirrorExpand)          -- Expand vert window width

    -- KB_GROUP Sublayouts
    -- This is used to push windows to tabbed sublayouts, or pull them out of it.
        , ("M-C-h", sendMessage $ pullGroup L)
        , ("M-C-l", sendMessage $ pullGroup R)
        , ("M-C-k", sendMessage $ pullGroup U)
        , ("M-C-j", sendMessage $ pullGroup D)
        , ("M-C-m", withFocused (sendMessage . MergeAll))
        -- , ("M-C-u", withFocused (sendMessage . UnMerge))
        , ("M-C-/", withFocused (sendMessage . UnMergeAll))
        , ("M-C-.", onGroup W.focusUp')    -- Switch focus to next tab
        , ("M-C-,", onGroup W.focusDown')  -- Switch focus to prev tab

    -- KB_GROUP Scratchpads
    -- Toggle show/hide these programs.  They run on a hidden workspace.
    -- When you toggle them to show, it brings them to your current workspace.
    -- Toggle them to hide and it sends them back to hidden workspace (NSP).
        , ("M-s t", namedScratchpadAction myScratchPads "terminal")
        , ("M-s c", namedScratchpadAction myScratchPads "calculator")

    -- KB_GROUP Multimedia Keys
        , ("<XF86AudioPlay>", spawn "playerctl play-pause")
        , ("<XF86AudioPrev>", spawn "playerctl prev")
        , ("<XF86AudioNext>", spawn "playerctl next")
        , ("<XF86AudioMute>", spawn "amixer set Master toggle") --non ho il tasto assegnato sulla tastiera
        , ("<XF86AudioLowerVolume>", spawn "pulseaudio-control --volume-max 130 down")
        , ("<XF86AudioRaiseVolume>", spawn "pulseaudio-control --volume-max 130 up")
        , ("<XF86Calculator>", runOrRaise "kcalc" (resource =? "kcalc"))
        , ("<Print>", spawn "spectacle")

    -- KB_GROUP Keyboard
        , ("M-C-<Space>", spawn ("keymaptoggle.sh"))

        ]
    -- The following lines are needed for named scratchpads.
          where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
                nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))
-- END_KEYS

main :: IO ()
main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe ("xmobar -x 0 $HOME/.config/xmobar/xmobarrc")
    -- the xmonad, ya know...what the WM is named after!
    xmonad $ ewmh def
        { manageHook         = myManageHook <+> manageDocks
        -- , handleEventHook    = docks
                               -- Uncomment this line to enable fullscreen support on things like YouTube/Netflix.
                               -- This works perfect on SINGLE monitor systems. On multi-monitor systems,
                               -- it adds a border around the window if screen does not have focus. So, my solution
                               -- is to use a keybinding to toggle fullscreen noborders instead.  (M-<Space>)
                               -- <+> fullscreenEventHook
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook  -- show nomi workspaces quando li cambi
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook = dynamicLogWithPP $ filterOutWsPP [scratchpadWorkspaceTag] $ xmobarPP
              -- XMOBAR SETTINGS
              { ppOutput = \x -> hPutStrLn xmproc0 x   -- xmobar on monitor 1
                -- Current workspace
              , ppCurrent = xmobarColor color06 "" . wrap
                            ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">") "</box>"
                -- Visible but not current workspace
              , ppVisible = xmobarColor color06 "" . clickable
                -- Hidden workspace
              , ppHidden = xmobarColor color05 "" . wrap
                           ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">") "</box>" . clickable
                -- Hidden workspaces (no windows)
              , ppHiddenNoWindows = xmobarColor color05 ""  . clickable
                -- Title of active window
              , ppTitle = xmobarColor color16 "" . shorten 60
                -- Separator character
              , ppSep =  "<fc=" ++ color09 ++ "> <fn=1>|</fn> </fc>"
                -- Urgent workspace
              , ppUrgent = xmobarColor color02 "" . wrap "!" "!"
                -- Adding # of windows on current workspace to the bar
              , ppExtras  = [windowCount]
                -- order of things in xmobar
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
              }
        } `additionalKeysP` myKeys
