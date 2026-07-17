sub init()
    m.global.RAT = true

    m.scene = m.top.getScene()
    m.scene.screenName = "Trend"

    m.navbar = m.top.findNode("navBar")
    m.blurOL = m.top.findNode("blurOL")

    navBarInit("Favorite")

    m.videosList = m.top.findNode("videosList")
    m.btnBack = m.top.findNode("btnBack")

    m.btnNoFav = m.top.findNode("btnNoFav")
    m.focusTimer = m.top.findNode("focusTimer")
    m.focusTimer.ObserveField("fire", "onTimerFire")
    SetContent()
    m.videosList.observeField("itemSelected", "onVideoSelect")
    m.videosList.observeField("itemFocused", "onVideoFocus")

    m.btnNoFav.ObserveField("buttonSelected", "onbtnNoFavSelect")
    m.top.observeField("visible", "onVisibleChange")

    m.global.microphoeSearchKeyboard.hideTextBox = true
    m.global.microphoeSearchKeyboard.textEditBox.observeField("text", "onTrend")
    m.global.microphoeSearchKeyboard.textEditBox.observeField("isDictating", "onTrend")

end sub

sub onTrend()
    if m.scene.screenName = "Trend"

        m.videosList.setFocus(true)
    end if
end sub

sub showSubPopup()
    if m.top.isTrialExpired

        m.top.setFocus(false)
        m.AppLockPopup.visible = true
        m.AppLockPopup.setFocus(true)
        m.scene.video.visible = false
        m.scene.video.control = "stop"

        m.top.isTrialExpired = false

    end if

end sub



' sub SetContent()

'     videoGridContent = CreateObject("roSGNode", "ContentNode")
'     allVideos = []

'     for each categoryName in m.global.videoArray

'         categoryData = m.global.videoArray[categoryName]

'         if categoryData <> invalid and categoryData.type = "track"

'             for each video in categoryData.items
'                 allVideos.Push(video)
'             end for

'         end if

'     end for

'     ' Shuffle videos
'     for i = allVideos.Count() - 1 to 1 step -1

'         j = Rnd(i + 1) - 1

'         temp = allVideos[i]
'         allVideos[i] = allVideos[j]
'         allVideos[j] = temp

'     end for

'     maxItems = 1000

'     if allVideos.Count() < maxItems
'         maxItems = allVideos.Count()
'     end if

'     for i = 0 to maxItems - 1

'         video = allVideos[i]

'         childContent = videoGridContent.CreateChild("RowItemData")

'         childContent.itemType = "track"

'         childContent.videoTitle = video.title
'         childContent.videoThumbnail = video.thumbnail
'         childContent.videoUrl = video.streamUrl

'         childContent.id = video.id
'         childContent.creator = video.artist
'         childContent.audioDuration = video.duration

'         childContent.type = "Free"

'     end for

'     m.videosList.content = videoGridContent

'     if m.videosList.content.getChildCount() > 0

'         m.videosList.setFocus(true)

'     else

'         m.btnNoFav.visible = true
'         m.focusTimer.control = "start"

'     end if

' end sub

sub SetContent()

    videoGridContent = CreateObject("roSGNode", "ContentNode")

    favVideos = GetFaves()

    if favVideos = invalid
        favVideos = []
    end if

    for each video in favVideos

        childContent = videoGridContent.CreateChild("RowItemData")

        childContent.itemType = "track"

        childContent.videoTitle = video.videoTitle
        childContent.videoThumbnail = video.videoThumbnail
        childContent.videoUrl = video.videoUrl

        childContent.creator = video.creator
        childContent.audioDuration = video.audioDuration

        childContent.type = "Free"

    end for

    m.videosList.content = videoGridContent

    if videoGridContent.GetChildCount() > 0

        m.btnNoFav.visible = false
        m.videosList.setFocus(true)

    else

        m.btnNoFav.visible = true
        m.btnFavN.setFocus(true)

    end if

end sub

sub ShowRemoveFavesHintDialog()
    regSection = "AppPrefs"
    regKey = "hideRemoveFavoritesHint"

    reg = CreateObject("roRegistrySection", regSection)
    if reg.Read(regKey) = "true"
        return ' Don't show if previously dismissed
    end if

    dialog = CreateObject("roSGNode", "StandardMessageDialog")
    dialog.title = "Remove from Favorites"
    dialog.message = ["Press * on the remote to remove videos from your favorites."]
    dialog.buttons = ["OK", "Don't Show Again"]
    dialog.observeField("buttonSelected", "OnRemoveFavesHintDismissed")

    m.scene.dialog = dialog
end sub

sub OnRemoveFavesHintDismissed()
    idx = m.top.dialog.buttonSelected

    if idx = 1 ' "Don't Show Again"
        reg = CreateObject("roRegistrySection", "AppPrefs")
        reg.Write("hideRemoveFavoritesHint", "true")
        reg.Flush()
    end if

    m.scene.dialog = invalid
end sub



sub RemoveFromFaves(itemContent as object)
    section = CreateObject("roRegistrySection", "FaveReg")
    entries = []

    ' Read existing entries
    if section.Exists("entries")
        storedJson = section.Read("entries")
        if storedJson <> ""
            parsed = ParseJson(storedJson)
            if parsed <> invalid and parsed.count() > 0
                entries = parsed
            end if
        end if
    end if

    ' Filter out the item matching by videoUrl
    filteredEntries = []
    for each entry in entries
        if entry.videoUrl <> itemContent.videoUrl
            filteredEntries.Push(entry)
        end if
    end for

    ' Write updated list back to registry
    section.Write("entries", FormatJson(filteredEntries))
    section.Flush()

    ' Optional: show confirmation

    ShowFavoritesRemovedDialog()
    SetContent()
end sub

sub ShowFavoritesRemovedDialog()
    dialog = CreateObject("roSGNode", "Dialog")
    dialog.title = "Removed"
    dialog.message = "Video removed from favorites."
    dialog.buttons = ["OK"]
    dialog.observeField("buttonSelected", "OnDismissConfirmationDialog")

    m.scene.dialog = dialog
end sub

sub OnDismissConfirmationDialog()
    m.scene.dialog = invalid
end sub





sub revertButtons()
    m.blurOL.visible = false

    m.NBG.width = 198
    m.NBG.uri = "pkg:/images/NBC.png"

    m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoUF.png"
    m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoF.png"
    m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaUF.png"
    m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaF.png"
    m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavF.png"
    m.btnFavN.focusBitmapUri = "pkg:/images/btnfavF.png"
    m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubUF.png"
    m.btnSubN.focusBitmapUri = "pkg:/images/btnSubF.png"
    m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnSetUF.png"
    m.btnSettingN.focusBitmapUri = "pkg:/images/btnSetF.png"

end sub
sub onVisibleChange()
    if m.top.visible
        m.scene.screenName = "Trend"

        navBarInit("Favorite")
        ' revertButtons()
        SetContent()



    end if

end sub


sub onTimerFire()
    m.videosList.setFocus(false)
    m.btnFavN.setFocus(true)

end sub

sub onbtnNoFavSelect()
    ?"Homescreen called"
    m.top.getScene().callFunc("CallHomeScreen")

end sub

sub onVideoFocus(evt)
    index = evt.getData()
    m.videoIndex = m.videosList.content.getChild(index)

end sub

sub onVideoSelect(evt)
    index = evt.getData()
    m.videoIndex = m.videosList.content.getChild(index)
    if m.global.duration >= m.global.videoDurationLimit and m.top.getScene().isSubscribed = false
        showAppLockPopup()
    else
        m.scene.callFunc("ShowMusicScreen", {
            selectedTrack: m.videoIndex
            relatedContent: m.videosList.content
        })
    end if
end sub

sub ShowApplockPopup()

    m.scene.video.control = "stop"
    m.scene.video.visible = false
    m.AppLockPopup.focusBitmapUri = "pkg:/images/subExpPopup.png"

    m.top.setFocus(false)
    m.AppLockPopup.visible = true
    m.AppLockPopup.setFocus(true)

end sub
sub onM3U8Fixed()
    fixedUrl = m.fixTask.fixedUrl
    if fixedUrl <> invalid
        m.videoContent.url = fixedUrl
        ' m.scene.video.content = m.videoContent
        m.scene.video.content = m.videoContent
        m.scene.video.visible = true
        m.scene.video.control = "play"

        m.scene.video.setFocus(true)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    result = false

    if press

        if key = "back" and m.AppLockPopup.hasFocus()
            m.AppLockPopup.visible = false
            m.AppLockPopup.setFocus(false)

            m.videosList.setFocus(true)
            return true
            m.videosList.setFocus(true)
            return true
        else if key = "left" and (m.videosList.hasFocus() or m.btnNoFav.hasFocus())
            m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnFavS.png"
            m.videosList.setFocus(false)
            m.btnNoFav.setFocus(false)
            m.blurOL.visible = true

            '   m.NBG.width=658
            m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
            m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoEF.png"
            m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaEUF.png"
            m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaEF.png"
            m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavS.png"
            m.btnFavN.focusBitmapUri = "pkg:/images/btnfavEF.png"
            m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubEUF.png"
            m.btnSubN.focusBitmapUri = "pkg:/images/btnSubEF.png"
            m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
            m.btnSettingN.focusBitmapUri = "pkg:/images/btnBSEF.png"

            m.btnFavN.setFocus(true)
            return true
        else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus() or m.btnRSN.hasFocus() or m.btnFFN.hasFocus() or m.btnARN.hasFocus() or m.btnMEN.hasFocus() or m.btnBWN.hasFocus())
            m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnFavS.png"
            ' revertButtons()
            if m.videosList.content <> invalid and m.videosList.content.GetChildCount() > 0
                m.top.setFocus(false)

                m.videosList.setFocus(true)
            end if
            return true
        else if key = "down" and m.btnHomeN.hasFocus()
            m.btnHomeN.setFocus(false)
            m.btnSubN.setFocus(true)
            return true
        else if key = "down" and m.btnSubN.hasFocus()
            m.btnSubN.setFocus(false)
            m.btnFavN.setFocus(true)
            return true

        else if key = "down" and m.btnFavN.hasFocus()
            m.btnFavN.setFocus(false)
            m.btnSettingN.setFocus(true)
            return true
        else if key = "down" and m.btnSearchN.hasFocus()
            m.btnSearchN.setFocus(false)
            m.btnHomeN.setFocus(true)
            return true
        ' else if key = "down" and m.btnSettingN.hasFocus()
        '     m.btnSettingN.setFocus(false)
        '     m.btnRSN.setFocus(true)
        '     return true
        else if key = "down" and m.btnRSN.hasFocus()
            m.btnRSN.setFocus(false)
            m.btnFFN.setFocus(true)
            return true
        else if key = "down" and m.btnFFN.hasFocus()
            m.btnFFN.setFocus(false)
            m.btnARN.setFocus(true)
            return true
        else if key = "down" and m.btnARN.hasFocus()
            m.btnARN.setFocus(false)
            m.btnMEN.setFocus(true)
            return true
        else if key = "down" and m.btnMEN.hasFocus()
            m.btnMEN.setFocus(false)
            m.btnBWN.setFocus(true)
            return true
        else if key = "down" and m.btnSearchN.hasFocus()
            m.btnSearchN.setFocus(false)
            m.btnHomeN.setFocus(true)
            return true

        else if key = "up" and m.btnBWN.hasFocus()
            m.btnBWN.setFocus(false)
            m.btnMEN.setFocus(true)
            return true
        else if key = "up" and m.btnMEN.hasFocus()
            m.btnMEN.setFocus(false)
            m.btnARN.setFocus(true)
            return true
        else if key = "up" and m.btnARN.hasFocus()
            m.btnARN.setFocus(false)
            m.btnFFN.setFocus(true)
            return true
        else if key = "up" and m.btnFFN.hasFocus()
            m.btnFFN.setFocus(false)
            m.btnRSN.setFocus(true)
            return true
        else if key = "up" and m.btnRSN.hasFocus()
            m.btnRSN.setFocus(false)
            m.btnSettingN.setFocus(true)
            return true

        else if key = "up" and m.btnHomeN.hasFocus()
            m.btnHomeN.setFocus(false)
            m.btnSearchN.setFocus(true)
            return true


        else if key = "up" and m.btnSubN.hasFocus()
            m.btnSubN.setFocus(false)
            m.btnHomeN.setFocus(true)
            return true
        else if key = "up" and m.btnFavN.hasFocus()
            m.btnFavN.setFocus(false)
            m.btnSubN.setFocus(true)
            return true
        else if key = "up" and m.btnSettingN.hasFocus()
            m.btnSettingN.setFocus(false)
            m.btnFavN.setFocus(true)
            return true

        else if key = "options" and m.videosList.hasFocus()
            RemoveFromFaves(m.videoIndex)
            return true




        end if

    end if

    return result
end function


function GetFaves() as object
    section = CreateObject("roRegistrySection", "FaveReg")
    entries = []

    if section.Exists("entries")
        storedJson = section.Read("entries")
        if storedJson <> ""
            parsed = ParseJson(storedJson)
            if parsed <> invalid and parsed.count() > 0
                entries = parsed
            end if
        end if
    end if

    return entries
end function