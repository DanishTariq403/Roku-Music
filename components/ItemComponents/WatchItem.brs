sub init()
    m.thumbnailPoster=m.top.findNode("thumbnailPoster")
    m.videoTitle=m.top.findNode("videoTitle")
    m.focus=m.top.findNode("focus")
    m.badge=m.top.findNode("badge")
    m.progressBg=m.top.findNode("progressBg")
    m.progressfill=m.top.findNode("progressfill")

end sub
sub onLoadStatus()
 if m.thumbnailPoster.loadStatus="failed"
        m.thumbnailPoster.uri="pkg:/images/GI.png"
    end if
end sub


sub onItemContent()
    m.itemContent=m.top.itemContent

      m.itemContent.videoThumbnail.replace("http:","https:")

    m.thumbnailPoster.uri=m.itemContent.videoThumbnail

    if m.top.index=0 and m.global.audio.state<>invalid and m.global.audio.state="playing"
        m.top.findNode("state").uri="pkg:/images/pause.png"
    else
                m.top.findNode("state").uri="pkg:/images/play.png"

    end if
    if m.itemContent.duration<>0
    SetProgress((m.itemContent.resumePosition/m.itemContent.duration)*100)
    end if
       m.thumbnailPoster.observeField("loadStatus","onLoadStatus")
     

     m.videoTitle.text=m.itemContent.videoTitle
      if m.itemContent.type="Paid"
        m.badge.visible=true
    else
        m.badge.visible=false
    end if


end sub

sub SetProgress(percent as Float)

    maxWidth = 276

    if percent < 0 then percent = 0
    if percent > 100 then percent = 100

    fillWidth = int(maxWidth * percent / 100)

    m.progressFill.width = fillWidth

end sub

sub changeFocus()
    if m.top.focusPercent>0.6 and m.top.rowHasFocus
        m.focus.visible=true
    else
        m.focus.visible=false

 end if

end sub