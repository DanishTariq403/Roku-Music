sub ShowMusicScreen(params as object)
    m.MusicScreen = CreateObject("roSGNode", "MusicScreen")
    m.MusicScreen.relatedContent = params.relatedContent

    if params.resumePosition <> invalid and params.resumePosition > 0
        m.MusicScreen.resumePosition = params.resumePosition
    end if

    if params.isVideoResume <> invalid
        m.MusicScreen.isVideoResume = params.isVideoResume
    end if

    if params.saveContinueWatching <> invalid
        m.MusicScreen.saveContinueWatching = params.saveContinueWatching
    else if params.isVideoResume <> invalid
        m.MusicScreen.saveContinueWatching = params.isVideoResume
    end if

    if params.autoPlayNext <> invalid
        m.MusicScreen.autoPlayNext = params.autoPlayNext
    end if

    if params.playlistTitle <> invalid
        m.MusicScreen.playlistTitle = params.playlistTitle
    end if

    if params.playlistThumbnail <> invalid
        m.MusicScreen.playlistThumbnail = params.playlistThumbnail
    end if

    ShowScreen(m.MusicScreen)
    m.MusicScreen.selectedTrack = params.selectedTrack
end sub