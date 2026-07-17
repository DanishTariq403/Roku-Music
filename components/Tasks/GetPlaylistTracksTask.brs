sub init()
    m.top.functionName = "LoadPlaylistTracks"
    m.apiBase = "http://185.194.218.34:3001"
    m.audiusBase = "https://api.audius.co/v1"
end sub

sub LoadPlaylistTracks()
    info = m.top.playlistInfo
    if info = invalid
        m.top.content = { tracks: [] }
        return
    end if

    tracks = invalid

    if info.tracksJson <> invalid and info.tracksJson <> ""
        parsed = ParseJson(info.tracksJson)
        if parsed <> invalid and Type(parsed) = "roArray" and parsed.Count() > 0
            tracks = parsed
        end if
    end if

    if tracks = invalid or tracks.Count() = 0
        tracks = FetchTracksFromApi(info)
    end if

    if tracks = invalid
        tracks = []
    end if

    m.top.content = {
        tracks: tracks
        title: info.title
        artist: info.artist
        thumbnail: info.thumbnail
        trackCount: tracks.Count()
    }

    ? "Playlist tracks loaded: "; tracks.Count()
end sub

function FetchTracksFromApi(info as object) as object
    if info = invalid then return []

    if info.sectionId = "moodPlaylists"
        moodName = info.moodName
        if moodName = invalid or moodName = ""
            moodName = info.title
        end if
        if moodName <> invalid and moodName <> ""
            return FetchMoodTracks(moodName)
        end if
    end if

    endpoints = GetEndpointsForSection(info.sectionId)
    for each endpoint in endpoints
        json = FetchApi(m.apiBase + endpoint + GetListLimitQuery(endpoint))
        playlist = FindPlaylistInResponse(json, info.id, info.title)
        if playlist <> invalid
            tracks = ResolvePlaylistTracks(playlist)
            if tracks.Count() > 0
                return tracks
            end if
        end if
    end for

    if info.id <> invalid and info.id <> ""
        tracks = FetchAudiusPlaylistTracks(info.id)
        if tracks.Count() > 0
            return tracks
        end if
    end if

    return []
end function

function GetListLimitQuery(endpoint as string) as string
    if endpoint.Instr("/api/playlists/") > 0
        if endpoint.Instr("?") > 0
            return ""
        end if
        return "?limit=100"
    end if
    return ""
end function

function GetEndpointsForSection(sectionId as string) as object
    if sectionId = "quickPicks" or sectionId = "popularPlaylists"
        return ["/api/playlists/popular"]
    else if sectionId = "recommended"
        return ["/api/playlists/most-relevant", "/api/playlists/trending"]
    else if sectionId = "newReleases" or sectionId = "featuredAlbums"
        return ["/api/playlists/new-releases"]
    else if sectionId = "hero"
        return ["/api/playlists/trending"]
    end if

    return [
        "/api/playlists/popular"
        "/api/playlists/most-relevant"
        "/api/playlists/new-releases"
        "/api/playlists/trending"
    ]
end function

function FetchMoodTracks(moodName as string) as object
    transfer = CreateObject("roUrlTransfer")
    url = m.apiBase + "/api/playlists/mood?mood=" + transfer.Escape(moodName)
    json = FetchApi(url)
    items = ExtractItems(json)
    if items.Count() = 0 then return []

    allTracks = []
    seenIds = {}
    audiusFetches = 0

    for each playlist in items
        if playlist = invalid then continue for

        tracks = ExtractTracksFromPlaylist(playlist)
        if tracks.Count() = 0 and playlist.id <> invalid and playlist.id <> "" and audiusFetches < 6
            tracks = FetchAudiusPlaylistTracks(playlist.id)
            audiusFetches = audiusFetches + 1
        end if

        AppendUniqueTracks(allTracks, seenIds, tracks)
    end for

    return allTracks
end function

function ResolvePlaylistTracks(playlist as object) as object
    if playlist = invalid then return []

    tracks = ExtractTracksFromPlaylist(playlist)
    if tracks.Count() > 0
        return tracks
    end if

    if playlist.id <> invalid and playlist.id <> ""
        return FetchAudiusPlaylistTracks(playlist.id)
    end if

    return []
end function

sub AppendUniqueTracks(allTracks as object, seenIds as object, tracks as object)
    if tracks = invalid or tracks.Count() = 0 then return

    for each track in tracks
        if track = invalid then continue for

        trackId = ""
        if track.id <> invalid
            trackId = track.id
        end if

        if trackId <> "" and seenIds.DoesExist(trackId)
            continue for
        end if

        if trackId <> ""
            seenIds[trackId] = true
        end if

        normalized = NormalizeTrack(track)
        if normalized <> invalid
            allTracks.Push(normalized)
        end if
    end for
end sub

function FetchAudiusPlaylistTracks(playlistId as string) as object
    if playlistId = invalid or playlistId = "" then return []

    allTracks = []
    offset = 0
    limit = 100
    page = 0

    while page < 5
        url = m.audiusBase + "/playlists/" + playlistId + "/tracks?app_name=MusicApp&limit=" + limit.ToStr() + "&offset=" + offset.ToStr()
        json = FetchApi(url)
        if json = invalid then exit while

        data = invalid
        if json.data <> invalid and Type(json.data) = "roArray"
            data = json.data
        else
            data = ExtractItems(json)
        end if

        if data = invalid or data.Count() = 0 then exit while

        for each track in data
            normalized = NormalizeTrack(track)
            if normalized <> invalid
                allTracks.Push(normalized)
            end if
        end for

        if data.Count() < limit then exit while
        offset = offset + limit
        page = page + 1
    end while

    return allTracks
end function

function NormalizeTrack(track as object) as object
    if track = invalid then return invalid

    title = ""
    if track.title <> invalid
        title = track.title
    end if

    artist = ""
    if track.artist <> invalid and track.artist <> ""
        artist = track.artist
    else if track.user <> invalid and track.user.name <> invalid
        artist = track.user.name
    end if

    thumbnail = ""
    if track.thumbnail <> invalid and track.thumbnail <> ""
        thumbnail = track.thumbnail
    else
        thumbnail = GetArtworkUri(track.artwork)
    end if

    streamUrl = ""
    if track.streamUrl <> invalid
        streamUrl = track.streamUrl
    else if track.id <> invalid
        streamUrl = m.audiusBase + "/tracks/" + track.id + "/stream"
    end if

    duration = invalid
    if track.duration <> invalid
        duration = track.duration
    end if

    trackId = invalid
    if track.id <> invalid
        trackId = track.id
    end if

    return {
        id: trackId
        title: title
        artist: artist
        thumbnail: thumbnail
        duration: duration
        streamUrl: streamUrl
    }
end function

function GetArtworkUri(artwork as dynamic) as string
    if artwork = invalid then return ""
    if Type(artwork) = "roString" and artwork <> "" then return artwork

    if Type(artwork) = "roAssociativeArray"
        sizes = ["480x480", "_480x480", "150x150", "_150x150", "1000x1000", "_1000x1000"]
        for each size in sizes
            if artwork.DoesExist(size) and artwork[size] <> invalid and artwork[size] <> ""
                return artwork[size]
            end if
        end for
    end if

    return ""
end function

function FindPlaylistInResponse(json as object, playlistId as string, playlistTitle as string) as object
    items = ExtractItems(json)
    for each item in items
        if item = invalid then continue for
        if playlistId <> invalid and playlistId <> "" and item.id = playlistId
            return item
        end if
        if playlistTitle <> invalid and playlistTitle <> "" and item.title = playlistTitle
            return item
        end if
    end for
    return invalid
end function

function ExtractTracksFromPlaylist(playlist as object) as object
    if playlist = invalid then return []

    if playlist.tracks <> invalid and Type(playlist.tracks) = "roArray" and playlist.tracks.Count() > 0
        return playlist.tracks
    end if

    if playlist.streamUrl <> invalid
        return [playlist]
    end if

    return []
end function

function FetchApi(url as string) as object
    transfer = CreateObject("roUrlTransfer")
    transfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    transfer.InitClientCertificates()
    transfer.SetUrl(url)
    transfer.SetMinimumTransferRate(1, 12)

    port = CreateObject("roMessagePort")
    transfer.SetMessagePort(port)

    if not transfer.AsyncGetToString()
        return invalid
    end if

    timer = CreateObject("roTimespan")
    timer.Mark()
    timeoutMs = 15000

    while true
        msg = wait(250, port)
        if type(msg) = "roUrlEvent"
            if msg.GetResponseCode() = 200
                response = msg.GetString()
                if response = invalid or response = "" then return invalid
                return ParseJson(response)
            end if
            return invalid
        else if timer.TotalMilliseconds() > timeoutMs
            transfer.AsyncCancel()
            return invalid
        end if
    end while

    return invalid
end function

function ExtractItems(json as object) as object
    if json = invalid then return []

    if Type(json) = "roArray"
        return json
    end if

    if json.items <> invalid and Type(json.items) = "roArray"
        return json.items
    end if

    if json.results <> invalid and Type(json.results) = "roArray"
        return json.results
    end if

    return []
end function
