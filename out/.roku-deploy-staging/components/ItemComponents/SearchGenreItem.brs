sub init()
    m.genreImage = m.top.findNode("genreImage")
    m.focus = m.top.findNode("focus")
end sub

sub onItemContent()
    m.itemContent = m.top.itemContent
    if m.itemContent = invalid then return

    uri = ""
    if m.itemContent.videoThumbnail <> invalid
        uri = m.itemContent.videoThumbnail
    end if

    m.genreImage.uri = uri
    m.genreImage.observeField("loadStatus", "onLoadStatus")
end sub

sub onLoadStatus()
    if m.genreImage.loadStatus = "failed"
        m.genreImage.uri = "pkg:/images/GI.png"
    end if
end sub

sub changeFocus()
    if m.top.focusPercent > 0.5 and (m.top.gridHasFocus or m.top.rowHasFocus)
        m.focus.visible = true
    else
        m.focus.visible = false
    end if
end sub
