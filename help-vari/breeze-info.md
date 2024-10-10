# Breeze Packages
## breeze-icons (breeze icon theme):
- icons/breeze
- icons/breeze-dark
## breeze (Artwork, styles and assets for the Breeze visual style for the Plasma Desktop):
- icons/Breeze_Light
- icons/breeze_cursors
- color-schemes/BreezeClassic.colors
- color-schemes/BreezeDark.colors
- color-schemes/BreezeLight.colors
- wallpapers
## breeze-gtk:
- themes/Breeze
- themes/Breeze-Dark
## breeze5 (needed for qt5 breeze styles. Needs breeze as dependency):
- qt5/plugins/styles/breeze5.so

# Configuration
- mouse: breeze_cursors (it now is the one from breeze6, the one from breeze5 was better but I can't be bothered to install it manually)
- qt: BreezeDark
- gtk: Adwaita-dark (Breeze gtk theme is not that good, some apps don't look good with it)
- icons: PapirusDark

## When I'm not in KDE
### QT_QPA_PLATFORMTHEME=KDE (assuming kde and breeze5 installed)
- qt6 apps work well
- qt5 apps don't use/find Breeze, even though inside kde they do use it
### QT_QPA_PLATFORMTHEME=qt5ct (assuming kde(haven't tried without it) and breeze5 installed)
- qt6ct: default Breeze version is light. If you use the darker color-scheme it's better, but colors are different than kde.\
    -> use qt6ct-kde (aur): it allows you to select other color-schemes, i suppose those in /usr/local/color-schemes. Selecting Breeze Dark (KColorscheme) it works well.
- qt5ct: selecting Breeze with default color-scheme it works well
