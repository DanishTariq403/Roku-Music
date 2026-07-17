sub init()
    m.top.functionName = "BuildGrid"
end sub

sub BuildGrid()
    tracks = m.top.tracks
    if tracks = invalid or tracks.Count() = 0
        m.top.content = invalid
        return
    end if

    gridContent = CreateObject("roSGNode", "ContentNode")
    rank = 1

    for each track in tracks
        if track = invalid then continue for

        item = gridContent.CreateChild("RowItemData")
        MapTrackToRowItem(item, track, rank)
        rank = rank + 1
    end for

    m.top.content = gridContent
end sub

sub MapTrackToRowItem(item as object, track as object, rank as integer)
    item.rank = rank
    item.itemType = "track"
    item.type = "Free"
    item.source = "audius"
    item.isPlaying = false

    if track.title <> invalid
        item.videoTitle = track.title
    end if

    if track.artist <> invalid
        item.creator = track.artist
        item.subtitle = track.artist
    end if

    if track.thumbnail <> invalid
        item.videoThumbnail = track.thumbnail
    else if track.artwork <> invalid
        item.videoThumbnail = track.artwork
    end if

    if track.streamUrl <> invalid
        item.videoUrl = track.streamUrl
        item.streamUrl = track.streamUrl
    end if

    if track.id <> invalid
        item.id = track.id
    end if

    if track.duration <> invalid
        item.audioDuration = track.duration.ToStr()
    end if

    if track.artistImage <> invalid
        item.artistImage = track.artistImage
    end if
end sub
