sub init()
    m.thumbnailPoster=m.top.findNode("thumbnailPoster")
    m.videoTitle=m.top.findNode("videoTitle")
    m.videoDuration=m.top.findNode("videoDuration")

    

end sub

sub onItemContent()
    m.itemContent=m.top.itemContent

    
    m.thumbnailPoster.uri=m.itemContent.videoThumbnail
    m.videoTitle.text=m.itemContent.videoTitle
    m.videoDuration.text=FormatDuration(m.itemContent.audioDuration)
    


end sub

function FormatDuration(value as dynamic) as string

    if value = invalid then return ""

    strValue = value.ToStr()

    ' Check if string is numeric
    seconds = Val(strValue)

    if seconds <= 0 and strValue <> "0"
        return strValue
    end if

    minutes = Int(seconds / 60)
    remainingSeconds = seconds mod 60

    return minutes.ToStr() + ":" + Right("0" + remainingSeconds.ToStr(), 2)

end function

sub showRowFocus()
    if m.top.rowHasFocus
      


    end if

end sub