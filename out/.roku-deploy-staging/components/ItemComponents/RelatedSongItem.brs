sub init()
    m.thumbnailPoster = m.top.findNode("thumbnailPoster")
    m.focus = m.top.findNode("focus")
    m.videoTitle = m.top.findNode("videoTitle")
    m.artistTitle = m.top.findNode("artistTitle")
end sub

sub onItemContent()
    content = m.top.itemContent
    if content = invalid then return
    m.artistTitle.text=content.creator
    m.videoTitle.text=content.videoTitle

    thumb = content.videoThumbnail

    if thumb <> invalid and thumb <> ""
        thumb = thumb.Replace("http:", "https:")
        m.thumbnailPoster.uri = thumb
    else
        m.thumbnailPoster.uri = "pkg:/images/GI.png"
    end if
end sub

sub onFocusChange()
    m.focus.visible = m.top.focusPercent > 0.5 and m.top.gridHasFocus
end sub
