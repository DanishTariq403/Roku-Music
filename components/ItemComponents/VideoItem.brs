sub init()
    m.thumbnailPoster=m.top.findNode("thumbnailPoster")
    m.videoTitle=m.top.findNode("videoTitle")
        m.badge=m.top.findNode("badge")
        m.focus=m.top.findNode("focus")


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
   m.thumbnailPoster.observeField("loadStatus","onLoadStatus")
   
     m.videoTitle.text=m.itemContent.videoTitle
      if m.itemContent.type="Paid"
        m.badge.visible=true
    else
        m.badge.visible=false
    end if


end sub

sub changeFocus()
    if m.top.focusPercent>0.6 and (m.top.gridHasFocus or m.top.rowHasFocus)
        m.focus.visible=true
    else
        m.focus.visible=false

 end if

end sub