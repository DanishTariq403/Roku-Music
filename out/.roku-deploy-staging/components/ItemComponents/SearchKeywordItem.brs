sub init()
    m.label = m.top.findNode("label")
    m.focus = m.top.findNode("focus")
end sub

sub onItemContent()
    m.itemContent = m.top.itemContent
    if m.itemContent = invalid then return

    m.label.text = ""
    if m.itemContent.videoTitle <> invalid
        m.label.text = m.itemContent.videoTitle
    end if
end sub

sub changeFocus()
    hasFocus = m.top.focusPercent > 0.5 and (m.top.gridHasFocus or m.top.rowHasFocus)

    if hasFocus
        m.focus.visible = true
        ' m.bg.visible = false
        m.label.color = "#FFFFFF"
    else
        m.focus.visible = false
        ' m.bg.visible = true
        m.label.color = "#FFFFFF"
    end if
end sub
