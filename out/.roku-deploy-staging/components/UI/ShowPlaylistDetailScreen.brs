sub ShowPlaylistDetailScreen(params as object)
    m.PlaylistDetailScreen = CreateObject("roSGNode", "PlaylistDetailScreen")
    ShowScreen(m.PlaylistDetailScreen)

    if params <> invalid and params.playlistInfo <> invalid
        m.PlaylistDetailScreen.playlistInfo = params.playlistInfo
    end if
end sub
