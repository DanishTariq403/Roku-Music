sub navBarInit(screenName as string)
    

    m.screenName = screenName
    m.seekPosition=0
    M.Nbg = m.top.findNode("NBG")
    m.scene = m.top.getScene()
    ?"Screen Name"m.screenName
    m.btnSubN = m.top.findNode("btnSubN")
    m.btnHomeN = m.top.findNode("btnHomeN")
    m.btnFavN = m.top.findNode("btnFavN")
    m.btnSettingN = m.top.findNode("btnSettingN")
    m.btnSearchN = m.top.findNode("btnSearchN")
    m.btnRSN = m.top.findNode("btnRSN")
    m.btnFFN = m.top.findNode("btnFFN")
    m.btnARN = m.top.findNode("btnARN")
    m.btnMEN = m.top.findNode("btnMEN")
    m.btnBWN = m.top.findNode("btnBWN")
    m.AppLockPopup = m.top.findNode("AppLockPopup")
    m.AppLockPopup.observeField("buttonSelected", "ShowSubscriptionScreen")
    ' m.btnSubN=m.top.findNode("btnSubN")
    if m.screenName <> "Sub"
        ?"NB1"
        m.btnSubN.observeField("buttonSelected", "ShowSubscriptionScreenByPress")
    else
        ?"subn"m.btnSubN
        m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubs.png"

    end if
    if m.screenName <> "Home"
        ?"NB2"
        m.btnHomeN.observeField("buttonSelected", "ShowHomeScreen")
    else
        ' m.btnHomeN.focusfootprintbitmapuri="pkg:/images/btnHos.png"
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoS.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"

    end if

    if m.screenName <> "Search"
        ?"NB3"
        m.btnSearchN.observeField("buttonSelected", "ShowSearchScreen")
    else
        m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeas.png"

    end if


    if m.screenName <> "Favorite"
        ?"NB5"
        m.btnFavN.observeField("buttonSelected", "ShowFavoriteScreen")
    else
        m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnFavS.png"

    end if

    if m.screenName <> "Explore" and m.screenName <> "Popular Playlists"
        ?"NB5"
        m.btnSettingN.observeField("buttonSelected", "ShowSettingScreen")

    else
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSS.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
    end if

    if m.screenName <> "Top Playlists" 
        m.btnRSN.observeField("buttonSelected", "ShowRSN")

    else

        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSS.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"



    end if

    if m.screenName <> "Recommended Playlists"
        m.btnFFN.observeField("buttonSelected", "ShowFFN")

    else

        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFS.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"



    end if

    if m.screenName <> "Top Artists"
        m.btnARN.observeField("buttonSelected", "ShowARN")

    else

        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnARS.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"



    end if

    if m.screenName <> "Acoustic"
        m.btnMEN.observeField("buttonSelected", "ShowMEN")

    else

        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMES.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"



    end if

    if m.screenName <> "Blues"
        m.btnBWN.observeField("buttonSelected", "ShowBWN")

    else

        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWS.png"



    end if



    '    m.scene=m.top.getScene()

    ' PaywallDisabledForTesting - TEMPORARY (2026-10-22): hide the Subscription
    ' tab and close its gap. No-op while the switch is off.
    NavBarApplyPaywallTestingSwitch()

end sub

' ---------------------------------------------------------------------------
' PaywallDisabledForTesting - TEMPORARY (2026-10-22). This file runs in each
' screen's own scope, which cannot see MainScene's PaywallDisabledForTesting(),
' so it reads the copy MainScene.init() publishes on m.global before any screen
' is created. Absent/invalid = switch off = original behaviour.
' ---------------------------------------------------------------------------
function IsPaywallDisabledForTesting() as boolean
    flag = m.global.paywallDisabledForTesting
    if flag = invalid then return false
    return flag = true
end function

' The bar's tabs top to bottom, as Navbar.xml lays them out (Search 137, Home
' 267, Sub 397, Fav 527, Setting 657). The legacy category buttons
' btnRSN..btnBWN are hidden in the XML and not part of the bar.
function NavBarTabOrder() as object
    return [m.btnSearchN, m.btnHomeN, m.btnSubN, m.btnFavN, m.btnSettingN]
end function

' PaywallDisabledForTesting - TEMPORARY (2026-10-22): hides btnSubN and moves
' the tabs below it (Fav, Setting) up, so the remaining tabs fill the first
' slots of the original layout and keep its even 130px pitch. Idempotent -
' navBarInit() runs again on most shows - because the slot positions are
' captured from the XML once per screen, before anything has moved.
sub NavBarApplyPaywallTestingSwitch()
    if not IsPaywallDisabledForTesting() then return
    if m.btnSubN = invalid then return

    tabs = NavBarTabOrder()
    if m.navTabSlotsY = invalid
        m.navTabSlotsY = []
        for each navTab in tabs
            if navTab <> invalid then m.navTabSlotsY.Push(navTab.translation[1])
        end for
    end if

    m.btnSubN.visible = false

    slot = 0
    for each navTab in tabs
        if navTab <> invalid
            if navTab.visible
                navTab.translation = [navTab.translation[0], m.navTabSlotsY[slot]]
                slot = slot + 1
            end if
        end if
    end for
end sub

' Up/down between navbar tabs. Focuses `target`, or - when it is hidden
' (PaywallDisabledForTesting hides btnSubN) - the next visible tab past it in
' the direction of travel; if there is none, focus stays on fromTab. With every
' tab visible this is exactly fromTab.setFocus(false) : target.setFocus(true),
' i.e. the original behaviour. TEMPORARY (2026-10-22) with the switch above.
sub NavBarMoveFocus(fromTab as object, target as object, key as string)
    dest = NavBarVisibleTab(target, key)
    if dest = invalid then return
    if fromTab <> invalid then fromTab.setFocus(false)
    dest.setFocus(true)
end sub

function NavBarVisibleTab(target as object, key as string) as object
    if target = invalid then return invalid
    if target.visible then return target

    tabs = NavBarTabOrder()
    stepBy = 1
    if key = "up" then stepBy = -1

    idx = -1
    for i = 0 to tabs.Count() - 1
        if tabs[i] <> invalid
            if tabs[i].isSameNode(target) then idx = i
        end if
    end for
    if idx < 0 then return invalid

    i = idx + stepBy
    while i >= 0 and i < tabs.Count()
        if tabs[i] <> invalid
            if tabs[i].visible then return tabs[i]
        end if
        i = i + stepBy
    end while
    return invalid
end function

sub navBarFocus()
    if m.scene.currentCategory = "All" or m.scene.CurrenCategory = ""
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoS.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
        
    else if m.scene.currentCategory = "BetterSleep"
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSS.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
            else if m.scene.currentCategory="Reduce Stress"
                 m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSS.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"

    else if m.scene.currentCategory="Focus & Flow"
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFS.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
    else if m.scene.currentCategory = "Anxiety Relief"
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
    
    else if m.scene.currentCategory="Morning Energy"
         m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMES.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
    else if m.scene.currentCategory="BreathWork"
         m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWS.png"



    end if

end sub
sub navBarFocusSet()
    ?"Called"
    if m.scene.currentCategory = "All" or m.scene.currentCategory = ""
        ?"1"
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoS.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
        m.btnHomeN.setFocus(true)
    else if m.scene.currentCategory = "Popular Playlists"
        ?"2"
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSS.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
                m.btnSettingN.setFocus(true)

            else if m.scene.currentCategory="Top Playlists"
                ?"3"
                 m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSS.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
                m.btnRSN.setFocus(true)


    else if m.scene.currentCategory="Recommended Playlists"
        ?"4"
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFS.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
                m.btnFFN.setFocus(true)

    else if m.scene.currentCategory = "Top Artists"
        ?"5"
        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
            m.btnARN.setFocus(true)

    else if m.scene.currentCategory="Acoustic"
        ?"6"
         m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMES.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWEUF.png"
                m.btnMEN.setFocus(true)

    else if m.scene.currentCategory="Blues"
        ?"7"
         m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnRSN.focusfootprintbitmapUri = "pkg:/images/btnRSEUF.png"
        m.btnFFN.focusfootprintbitmapUri = "pkg:/images/btnFFEUF.png"
        m.btnARN.focusfootprintbitmapUri = "pkg:/images/btnAREUF.png"
        m.btnMEN.focusfootprintbitmapUri = "pkg:/images/btnMEEUF.png"
        m.btnBWN.focusfootprintbitmapUri = "pkg:/images/btnBWS.png"
        m.btnBWN.setFocus(true)



    end if

end sub
sub ShowRSN()
    m.scene.currentCategory = "Top Playlists"

    m.btnRSN.unobserveField("buttonSelected")

    m.scene.callFunc("ShowSettingScreen")

end sub
sub ShowFFN()
    m.scene.currentCategory = "Recommended Playlists"

    m.btnFFN.unobserveField("buttonSelected")

    m.scene.callFunc("ShowSettingScreen")

end sub

sub ShowARN()
    m.scene.currentCategory = "Top Artists"

    m.btnARN.unobserveField("buttonSelected")

    m.scene.callFunc("ShowSettingScreen")

end sub

sub ShowMEN()
    m.scene.currentCategory = "Acoustic"

    m.btnMEN.unobserveField("buttonSelected")

    m.scene.callFunc("ShowSettingScreen")

end sub

sub ShowBWN()
    m.scene.currentCategory = "Blues"

    m.btnBWN.unobserveField("buttonSelected")

    m.scene.callFunc("ShowSettingScreen")

end sub

sub ShowHomeScreen()
    m.scene.currentCategory = "All"

    m.btnHomeN.unobserveField("buttonSelected")

    m.scene.callFunc("ShowHomeScreen")






end sub

sub UpdateProgressUI(position as Integer)

    duration = m.scene.video.duration

    if duration <= 0 then return

    percent = position / duration

    if percent < 0 then percent = 0
    if percent > 1 then percent = 1

    totalWidth = 653
    currentWidth = Int(totalWidth * percent)
    ' if currentWidth>15
    '     m.positionBar.uri="pkg:/images/positionPoster.png"
    ' else 
    ' m.positionBar.uri="pkg:/images/positionBarInit.png"

    ' end if

    m.positionBar.width = currentWidth

    blobX = 154 + currentWidth - 19

    if blobX < 154
        blobX = 154
    end if

    m.positionBlob.translation = [blobX, 909]

    m.videoPosition.text = PositionToTime(position)

end sub

function PositionToTime(position as integer) as string

    minutes = Int(position / 60)
    seconds = position mod 60

    return minutes.ToStr() + ":" + Right("0" + seconds.ToStr(), 2)

end function

sub ShowSearchScreen()

    ' if m.global.dura>=  m.global.audioDurationLimit and m.scene.isSubscribed=false
    '            ShowDialogToUser()

    '         else
    m.btnSearchN.unobserveField("buttonSelected")

    m.scene.callFunc("ShowSearchScreen")


    ' end if


end sub

sub ShowFavoriteScreen()

    m.scene.callFunc("ShowFavoriteScreen")
    m.btnFavN.unobserveField("buttonSelected")

end sub

sub ShowSettingScreen()
    m.scene.currentCategory = "Explore"

    m.btnSettingN.unobserveField("buttonSelected")
    m.scene.callFunc("ShowSettingScreen")

end sub



' sub ShowInputScreen()
'     if m.scene.isSubscribed=false and m.global.appLaunchCount>m.scene.AppLimit
'                 ShowDialogToUser()

'             else

'     m.scene.callFunc("ShowAggregatorScreen")

'             end if
'     m.btnInputN.unobserveField("buttonSelected")

' end sub

sub ShowSubscriptionScreenByPress()
    m.scene.isSubScreenSelected = true

    ShowSubscriptionScreen()


end sub


sub ShowSubscriptionScreen()
    if m.subscriptionDialog <> invalid and m.subscriptionDialog.buttonSelected = 0

        m.subscriptionDialog.close = true
    end if
    m.scene.callFunc("ShowSubscriptionScreen")
    m.btnSubN.unobserveField("buttonSelected")




end sub

sub ShowDialogToUser()
    m.AppLockPopup.visible = true
    m.AppLockPopup.setFocus(true)
end sub

' sub ShowEmptyDialogToUser()
'     if m.emptyDialog=invalid
'     m.emptyDialog = createObject("roSGNode", "StandardMessageDialog")
'     end if
'     m.emptyDialog.title = "Add A Playlist"
'     m.emptyDialog.message = ["There are no playlists added right now. Please Add atleast 1 Playlist to Continue."]
'     m.emptyDialog.buttons = ["OK"]

'     ' observe the dialog's buttonSelected field to handle button selections
'     m.emptyDialog.observeField("buttonSelected", "onEmptyDialog")

'     m.scene.dialog = m.emptyDialog


' end sub

' sub onEmptyDialog()
'     m.emptyDialog.close=true


' end sub

' function hasPlaylists() as Boolean
'     sec = CreateObject("roRegistrySection", "PlaylistReg")

'     if sec.Exists("playlistNames")
'         storedNames = sec.Read("playlistNames")
'         if storedNames <> ""
'             playlistList = ParseJson(storedNames)
'             if playlistList.Count() > 0
'                 return true
'             end if
'         end if
'     end if

'     return false
' end function
