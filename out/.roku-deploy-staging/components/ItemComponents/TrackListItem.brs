sub init()
    m.rowBg = m.top.findNode("rowBg")
    m.indexLabel = m.top.findNode("indexLabel")
    m.playIcon = m.top.findNode("playIcon")
    m.favIcon = m.top.findNode("favIcon")
    m.thumbnailPoster = m.top.findNode("thumbnailPoster")
    m.videoTitle = m.top.findNode("videoTitle")
    m.artistLabel = m.top.findNode("artistLabel")
    m.durationLabel = m.top.findNode("durationLabel")
end sub

sub onItemContent()
    if m.itemContentObserverSet = true and m.itemContent <> invalid
        m.itemContent.unobserveField("isPlaying")
    end if

    m.itemContent = m.top.itemContent
    if m.itemContent = invalid then return

    m.itemContent.observeField("isPlaying", "updatePlayingDisplay")
    m.itemContentObserverSet = true

    bindFields()
    updatePlayingDisplay()
    updateFavoriteDisplay()
end sub

sub bindFields()
    if m.itemContent.rank <> invalid and m.itemContent.rank > 0
        m.indexLabel.text = m.itemContent.rank.ToStr()
    else
        m.indexLabel.text = ""
    end if

    if m.itemContent.videoTitle <> invalid
        m.videoTitle.text = m.itemContent.videoTitle
    end if

    if m.itemContent.creator <> invalid
        m.artistLabel.text = m.itemContent.creator
    else if m.itemContent.subtitle <> invalid
        m.artistLabel.text = m.itemContent.subtitle
    end if

    if m.itemContent.audioDuration <> invalid
        m.durationLabel.text = FormatTrackDuration(m.itemContent.audioDuration)
    else
        m.durationLabel.text = ""
    end if

    thumb = m.itemContent.videoThumbnail
    if thumb <> invalid and thumb <> ""
        thumb = thumb.Replace("http:", "https:")
        m.thumbnailPoster.uri = thumb
    else
        m.thumbnailPoster.uri = "pkg:/images/GI.png"
    end if
end sub

sub updatePlayingDisplay()
    if m.itemContent = invalid then return

    focused = m.top.focusPercent > 0.5 and m.top.gridHasFocus
    isPlaying = m.itemContent.isPlaying = true

    if focused
        m.indexLabel.visible = false
        m.playIcon.visible = true
        if isPlaying
            m.playIcon.uri = "pkg:/images/btnpausetrue.png"
        else
            m.playIcon.uri = "pkg:/images/playtrue.png"
        end if
    ' else if isPlaying
    '     m.playIcon.uri = "pkg:/images/playTrue.png"
    '     m.playIcon.visible = true
    '     m.indexLabel.visible = false
    else
        m.playIcon.visible = false
        m.indexLabel.visible = true
    end if
end sub

sub updateFavoriteDisplay()
    videoUrl = ""
    if m.itemContent <> invalid and m.itemContent.videoUrl <> invalid
        videoUrl = m.itemContent.videoUrl
    end if

    if IsFavorite(videoUrl)
        m.favIcon.uri = "pkg:/images/favTrue.png"
    else
        m.favIcon.uri = "pkg:/images/favFalse.png"
    end if
end sub

function IsFavorite(videoUrl as string) as boolean
    if videoUrl = "" then return false

    section = CreateObject("roRegistrySection", "FaveReg")
    if not section.Exists("entries") then return false

    storedJson = section.Read("entries")
    if storedJson = invalid or storedJson = "" then return false

    entries = ParseJson(storedJson)
    if entries = invalid then return false

    for each entry in entries
        if entry <> invalid and entry.videoUrl = videoUrl
            return true
        end if
    end for

    return false
end function

sub onFocusChange()
    focused = m.top.focusPercent > 0.5 and m.top.gridHasFocus
    if focused
        m.rowBg.uri = "pkg:/images/TIBGF.png"
    else
        m.rowBg.uri = "pkg:/images/.png"
    end if
    updatePlayingDisplay()
end sub

function FormatTrackDuration(durationValue as dynamic) as string
    seconds = 0

    if Type(durationValue) = "roString" or Type(durationValue) = "String"
        seconds = durationValue.ToInt()
    else if Type(durationValue) = "roInt" or Type(durationValue) = "Integer"
        seconds = durationValue
    else if Type(durationValue) = "roFloat" or Type(durationValue) = "Float"
        seconds = Int(durationValue)
    end if

    if seconds <= 0 then return "0:00"

    mins = Int(seconds / 60)
    secs = seconds mod 60
    if secs < 10
        return mins.ToStr() + ":0" + secs.ToStr()
    end if
    return mins.ToStr() + ":" + secs.ToStr()
end function
