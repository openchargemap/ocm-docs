REM Output Splashscreen Various Sizes
SET INKSCAPE=c:\progra~2\inkscape\inkscape.exe
%INKSCAPE% ..\splashscreens\AppSplashscreen.svg --export-png=..\splashscreens\output\AppSplashscreen_320x460.png --export-width=320 --export-height=460 --export-background=FFFFFF
%INKSCAPE% ..\splashscreens\AppSplashscreen.svg --export-png=..\splashscreens\output\AppSplashscreen_320x480.png --export-width=320 --export-height=480 --export-background=FFFFFF
%INKSCAPE% ..\splashscreens\AppSplashscreen.svg --export-png=..\splashscreens\output\AppSplashscreen_640x960.png --export-width=640 --export-height=960 --export-background=FFFFFF
%INKSCAPE% ..\splashscreens\AppSplashscreen480x800.svg --export-png=..\splashscreens\output\AppSplashscreen_480x800.png --export-width=480 --export-height=800 --export-background=FFFFFF
%INKSCAPE% ..\splashscreens\AppSplashscreen480x800.svg --export-png=..\build-output\android\splash.png --export-width=480 --export-height=800 --export-background=FFFFFF
%INKSCAPE% ..\splashscreens\AppSplashscreen.svg --export-png=..\splashscreens\output\AppSplashscreen_768x1004.png --export-width=768 --export-height=1004 --export-background=FFFFFF
%INKSCAPE% ..\splashscreens\AppSplashscreen.svg --export-png=..\splashscreens\output\AppSplashscreen_1000x800.png --export-width=1000 --export-height=800 --export-background=FFFFFF

REM Output AppIcon Various Sizes
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_16x16.png --export-width=16 --export-height=16
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_32x32.png --export-width=32 --export-height=32
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_36x36.png --export-width=36 --export-height=36
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\build-output\android\ldpi\icon.png --export-width=36 --export-height=36
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_48x48.png --export-width=48 --export-height=48
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\build-output\android\mdpi\icon.png --export-width=48 --export-height=48
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_57x57.png --export-width=57 --export-height=57
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_62x62.png --export-width=62 --export-height=62
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_64x64.png --export-width=64 --export-height=64
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_72x72.png --export-width=72 --export-height=72
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\build-output\android\hdpi\icon.png --export-width=72 --export-height=72
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\build-output\android\xhdpi\icon.png --export-width=96 --export-height=96
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_99x99.png --export-width=99 --export-height=99
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_114x114.png --export-width=114 --export-height=114
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_128x128.png --export-width=128 --export-height=128
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_173x173.png --export-width=173 --export-height=173
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_200x200.png --export-width=200 --export-height=200
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_256x256.png --export-width=256 --export-height=256
%INKSCAPE% ..\app-icons\AppIcon.svg --export-png=..\app-icons\output\AppIcon_512x512.png --export-width=512 --export-height=512
