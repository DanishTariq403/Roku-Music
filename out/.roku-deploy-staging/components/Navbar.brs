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


end sub
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
