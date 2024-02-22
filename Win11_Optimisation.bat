
@echo off
cls

echo =========================================================================
echo           Windows 11 Optimization Script By sbeteta@beteta.org                  
echo =========================================================================

:restorepoint
set /p createRestorePoint=Créer d'abord un point de restauration ? (y/n)
if /i "%createRestorePoint%"=="y" (
    wmic /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Optimization Script", 100, 7
    echo Point de restauration créé.
) else if /i "%createRestorePoint%"=="n" (
    echo Echec pour créer le point de restauration.
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto restorepoint
)

:disableipv6
set /p disableIPV6=Désactivé IPv6? (y/n)
if /i "%disableIPV6%"=="y" (
    netsh interface ipv6 set interface "Ethernet" disabled
    netsh interface ipv6 set interface "Wi-Fi" disabled
    echo IPv6 désactivé.
) else if /i "%disableIPV6%"=="n" (
    echo Echec Désactivation de IPv6.
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disableipv6
)

:optimizenetwork
set /p optimizeNetwork=Optimiser les paramètres réseaux ? (y/n)
if /i "%optimizeNetwork%"=="y" (
    netsh int tcp set global autotuninglevel=normal
    netsh int tcp set global rss=enabled
    reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "Value" /t REG_DWORD /d 0 /f
    reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "Value" /t REG_DWORD /d 0 /f
    echo Paramètres réseau optimisés.
) else if /i "%optimizeNetwork%"=="n" (
    echo Echec pour optimiser les paramètres réseau
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto optimizenetwork
)

:cleartempfiles
set /p clearTempFiles=Effacer les fichiers temporaires ? (y/n)
if /i "%clearTempFiles%"=="y" (
    del /s /q /f %temp%\*
    rd /s /q %temp%
    md %temp%
    echo Fichiers temporaires effacés.
) else if /i "%clearTempFiles%"=="n" (
    echo Echec sur la procédure "Fichiers temporaires effacés."
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto cleartempfiles
)

:defraghdd
set /p defragHDD=Défragmenter un disque dur? (y/n)
if /i "%defragHDD%"=="y" (
    defrag C: /U /V
    echo Disque dur défragmenté.
) else if /i "%defragHDD%"=="n" (
    echo Echec sur la défragmentation du disque.
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto defraghdd
)

:disablegamemode
set /p disableGameMode=Désactiver le mode jeu ? (y/n)
if /i "%disableGameMode%"=="y" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f
    echo Mode jeu désactivé.
) else if /i "%disableGameMode%"=="n" (
    echo Echec sur la procédure "Mode jeu désactivé."
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disablegamemode
)

:disablegamebar
set /p disableGameBar=Désactiver la barre de jeu ? (y/n)
if /i "%disableGameBar%"=="y" (
    PowerShell -Command "Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
    reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 0 /f
    echo Game Bar disabled.
) else if /i "%disableGameBar%"=="n" (
    echo Echec sur la procédure "Désactiver la barre de jeu".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disablegamebar
)

:disableindexing
set /p disableIndexing=Désactiver l'indexation sur tous les lecteurs ? (y/n)
if /i "%disableIndexing%"=="y" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowIndexingEncryptedStoresOrItems" /t REG_DWORD /d 0 /f
    echo Indexing disabled on all drives.
) else if /i "%disableIndexing%"=="n" (
    echo Echec de la procédure "Désactiver l'indexation sur tous les lecteurs".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disableindexing
)

:disablehibernation
set /p disableHibernation=Désactiver l'hibernation ? (y/n)
if /i "%disableHibernation%"=="y" (
    powercfg -h off
 reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v ShowHibernateOption /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 00000001 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 00000000 /f
    echo Hibernation disabled.
) else if /i "%disableHibernation%"=="n" (
    echo Echec de la procédure "Désactiver l'hibernation".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disablehibernation
)

:disabletelemetry
set /p disableTelemetry=Désactiver la télémétrie et la collecte de données ? (y/n)
if /i "%disableTelemetry%"=="y" (

    schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE
    schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /DISABLE
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /DISABLE
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /DISABLE
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "400" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d 4 /f
    echo Telemetry and data collection disabled.
) else if /i "%disableTelemetry%"=="n" (
    echo  echec de la procédure "Désactiver la télémétrie et la collecte de données".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disabletelemetry
)

:disabletips
set /p disableTips=Désactiver les conseils/suggestions Windows ? (y/n)
if /i "%disableTips%"=="y" (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f
    echo Windows tips/suggestions disabled.
) else if /i "%disableTips%"=="n" (
    echo Echec de la procédure "Désactiver les conseils/suggestions Windows".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disabletips
)

:disablehomegroup
set /p disableHomeGroup=Désactiver le groupe résidentiel ? (y/n)
if /i "%disableHomeGroup%"=="y" (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableHomeGroup" /t REG_DWORD /d 0 /f
    echo HomeGroup disabled.
) else if /i "%disableHomeGroup%"=="n" (
    echo Echec de la procédure "Désactiver le groupe résidentiel"
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disablehomegroup
)

:disablestickykeys
set /p disableStickyKeys=Désactiver l'invite des touches rémanentes ? (y/n)
if /i "%disableStickyKeys%"=="y" (
    reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
    echo Sticky keys prompt disabled.
) else if /i "%disableStickyKeys%"=="n" (
    echo Echec de la procédure "Désactiver l'invite des touches rémanentes".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disablestickykeys
)

:disablesuperfetch
set /p disableSuperfetch=Désactiver Superfetch ? (y/n)
if /i "%disableSuperfetch%"=="y" (
    sc config SysMain start=disabled
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f
    echo Superfetch disabled.
) else if /i "%disableSuperfetch%"=="n" (
    echo Echec de la procédure "Désactiver Superfetch".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto disablesuperfetch
)

:spooler
set /p disablespooler=Désactiver le spouleur d'impression (y/n)
if /i "%disablespooler%"=="y" (
    PowerShell -Command net stop spooler
    echo Spooler disabled.
) else if /i "%disablespooler%"=="n" (
    echo Echec de la procédure "Désactiver le spouleur".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto spooler
)

:WindowsInsiderService
set /p disableWindowsInsiderService= Désactiver le service Windows Insider (y/n)
if /i "%disableWindowsInsiderService%"=="y" (
    PowerShell -Command Set-Service wisvc -StartupType Disabled
    echo disabled Windows Insider Service.
) else if /i "%disableWindowsInsiderService%"=="n" (
    echo Echec de la procédure "Désactiver le service Windows Insider"
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto WindowsInsiderService
)

:DiagnosticServiceHost
set /p disableDiagnosticServiceHost= Désactiver l'hôte du service de diagnostic (y/n)
if /i "%disableDiagnosticServiceHost%"=="y" (
    PowerShell -Command "net stop DPS"
    echo Echec de la procédure "Désactiver l'hôte du service de diagnostic"
) else if /i "%disableDiagnosticServiceHost%"=="n" (
    echo Echec de la procédure"Désactiver l'hôte du service de diagnostic".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto DiagnosticServiceHost
)

:BITS
set /p disableBITS= Désactiver les BITS (y/n)
if /i "%disableBITS%"=="y" (
    net stop wuauserv
    net stop cryptSvc
    net stop bits
    net stop msiserver
    echo disabled BITS.
) else if /i "%disableBITS%"=="n" (
    echo Echec de la procédure "Désactiver les BITS".
) else (
    echo Entrée invalide. Entrez s'il vous plait y ou n.
    goto BITS


echo Optimisation terminée ! Merci
pause 
