sub init()
    m.scene = m.top.getScene()
    m.navBar = m.top.findNode("navBar")
    m.tracksGrid = m.top.findNode("tracksGrid")
    m.screenTitle = m.top.findNode("screenTitle")
    m.metaLabel = m.top.findNode("metaLabel")
    m.btnPlayAll = m.top.findNode("btnPlayAll")
    m.spinner = m.top.findNode("spinner")
    m.videoDurationTimer = m.top.findNode("videoDurationTimer")

    m.isPlayAllMode = false
    m.currentTrackIndex = -1
    m.videoObserverSet = false
    m.playlistInfo = invalid
    m.tracksTask = invalid
    m.gridBuildTask = invalid
    m.tracksLoadId = 0
    m.savedTrackFocus = -1
    m.largePlaylistThreshold = 40

    navBarInit("Home")

    if m.spinner <> invalid and m.spinner.poster <> invalid
        m.spinner.poster.uri = "pkg:/images/spinner.png"
    end if

    m.tracksGrid.observeField("ItemSelected", "onTrackSelect")
    m.tracksGrid.observeField("itemFocused", "onTrackFocused")
    m.btnPlayAll.observeField("buttonSelected", "onPlayAllSelect")
    m.videoDurationTimer.ObserveField("fire", "onVideoDurationChange")
    m.top.observeField("visible", "onVisibleChange")
end sub

function isPaywallActive() as boolean
    if m.scene = invalid then return false
    if m.scene.isSubscribed = true then return false
    return m.global.duration >= m.global.videoDurationLimit
end function

sub showSubPopup()
    if not m.top.isTrialExpired then return

    m.top.setFocus(false)
    endPlayAll()
    stopDurationTimer()

    if m.scene <> invalid and m.scene.video <> invalid
        m.scene.video.control = "pause"
    end if

    showAppLockPopup()
    m.top.isTrialExpired = false
end sub

sub showAppLockPopup()
    endPlayAll()
    stopDurationTimer()

    if m.scene <> invalid and m.scene.video <> invalid
        m.scene.video.control = "stop"
        m.scene.video.visible = false
    end if

    if m.AppLockPopup = invalid then return

    m.AppLockPopup.focusBitmapUri = "pkg:/images/subExpPopup.png"
    m.top.setFocus(false)
    m.AppLockPopup.visible = true
    m.AppLockPopup.setFocus(true)
end sub

sub stopDurationTimer()
    if m.videoDurationTimer <> invalid
        m.videoDurationTimer.control = "stop"
    end if
end sub

sub startDurationTimer()
    if m.videoDurationTimer = invalid then return
    if m.scene = invalid or m.scene.isSubscribed = true then return
    m.videoDurationTimer.control = "start"
end sub

sub onVideoDurationChange()
    if m.scene = invalid
        m.scene = m.top.getScene()
    end if
    if m.scene = invalid or m.scene.isSubscribed = true then return
    if not m.top.visible then return

    m.scene.callFunc("setCurrentDuration")
end sub

sub onPlaylistInfo()
    info = m.top.playlistInfo
    if info = invalid then return

    if m.tracksTask <> invalid
        m.tracksTask.unobserveField("content")
        m.tracksTask.control = "STOP"
        m.tracksTask = invalid
    end if

    stopGridBuildTask()

    m.tracksLoadId = m.tracksLoadId + 1
    loadId = m.tracksLoadId

    m.playlistInfo = info
    m.tracksGrid.content = invalid

    if info.title <> invalid
        m.screenTitle.text = info.title
    end if

    metaParts = []
    if info.sectionId = "moodPlaylists"
        metaParts.Push("Loading...")
    else if info.trackCount <> invalid and info.trackCount > 0
        metaParts.Push(info.trackCount.ToStr() + " Songs")
    else
        metaParts.Push("Loading...")
    end if
    if info.artist <> invalid and info.artist <> ""
        metaParts.Push(info.artist)
    end if
    m.metaLabel.text = JoinMeta(metaParts)

    m.spinner.visible = true
    m.tracksTask = CreateObject("roSGNode", "GetPlaylistTracksTask")
    m.tracksTask.playlistInfo = info
    m.tracksTask.loadId = loadId
    m.tracksTask.observeField("content", "onTracksLoaded")
    m.tracksTask.control = "RUN"
end sub

sub onTracksLoaded()
    task = m.tracksTask
    if task = invalid then return
    if task.loadId <> m.tracksLoadId then return

    result = task.content
    if result = invalid
        m.spinner.visible = false
        return
    end if

    if result.title <> invalid and result.title <> ""
        m.screenTitle.text = result.title
    end if

    tracks = result.tracks
    if tracks = invalid or tracks.Count() = 0
        m.spinner.visible = false
        m.metaLabel.text = "No songs available"
        return
    end if

    m.pendingTrackMeta = result
    if tracks.Count() > m.largePlaylistThreshold
        startAsyncGridBuild(tracks)
    else
        gridContent = buildTracksGridContent(tracks)
        finishTracksGridLoad(gridContent)
    end if
end sub

sub stopGridBuildTask()
    if m.gridBuildTask = invalid then return

    m.gridBuildTask.unobserveField("content")
    m.gridBuildTask.control = "STOP"
    m.gridBuildTask = invalid
end sub

sub startAsyncGridBuild(tracks as object)
    stopGridBuildTask()
    m.spinner.visible = true
    m.tracksGrid.content = invalid

    m.gridBuildTask = CreateObject("roSGNode", "BuildPlaylistGridTask")
    m.gridBuildTask.tracks = tracks
    m.gridBuildTask.loadId = m.tracksLoadId
    m.gridBuildTask.observeField("content", "onGridBuilt")
    m.gridBuildTask.control = "RUN"
end sub

sub onGridBuilt()
    task = m.gridBuildTask
    if task = invalid then return
    if task.loadId <> m.tracksLoadId then return

    gridContent = task.content
    stopGridBuildTask()
    finishTracksGridLoad(gridContent)
end sub

function buildTracksGridContent(tracks as object) as object
    gridContent = CreateObject("roSGNode", "ContentNode")
    rank = 1

    for each track in tracks
        if track = invalid then continue for

        item = gridContent.CreateChild("RowItemData")
        MapTrackToRowItem(item, track, rank)
        rank = rank + 1
    end for

    return gridContent
end function

sub finishTracksGridLoad(gridContent as object)
    m.spinner.visible = false

    if gridContent = invalid or gridContent.GetChildCount() = 0
        m.metaLabel.text = "No songs available"
        return
    end if

    m.tracksGrid.content = gridContent

    result = m.pendingTrackMeta
    metaParts = []
    metaParts.Push(gridContent.GetChildCount().ToStr() + " Songs")
    if result <> invalid and result.artist <> invalid and result.artist <> ""
        metaParts.Push(result.artist)
    else if m.playlistInfo <> invalid and m.playlistInfo.artist <> invalid and m.playlistInfo.artist <> ""
        metaParts.Push(m.playlistInfo.artist)
    end if
    m.metaLabel.text = JoinMeta(metaParts)

    syncPlayingIndicatorFromAudio()
    restoreTracksGridFocus()
end sub

sub saveTracksGridFocus(index as integer)
    if index = invalid then return
    m.savedTrackFocus = index
end sub

sub restoreTracksGridFocus()
    if m.tracksGrid = invalid then return
    if m.tracksGrid.content = invalid or m.tracksGrid.content.GetChildCount() = 0 then return

    focusIndex = resolveTracksGridFocusIndex()
    if focusIndex >= 0
        m.savedTrackFocus = focusIndex
        m.tracksGrid.jumpToItem = focusIndex
        m.tracksGrid.setFocus(true)
    end if
end sub

function resolveTracksGridFocusIndex() as integer
    content = m.tracksGrid.content
    if content = invalid then return -1

    trackCount = content.GetChildCount()
    if trackCount = 0 then return -1

    playingIndex = FindPlayingTrackIndex()
    if playingIndex >= 0
        return playingIndex
    end if

    if m.savedTrackFocus >= 0 and m.savedTrackFocus < trackCount
        return m.savedTrackFocus
    end if

    return 0
end function

function FindPlayingTrackIndex() as integer
    if m.tracksGrid.content = invalid then return -1
    if not IsPlaylistAudioActive() then return -1

    track = m.global.nowPlayingTrack
    if track <> invalid
        matchedIndex = FindTrackIndexByTrack(track)
        if matchedIndex >= 0
            return matchedIndex
        end if
    end if

    return FindTrackIndexByUrl(GetCurrentAudioUrl())
end function

function IsPlaylistAudioActive() as boolean
    m.scene = m.top.getScene()
    if m.scene = invalid or m.scene.video = invalid then return false

    state = m.scene.video.state
    if state <> "playing" and state <> "paused" then return false

    return GetCurrentAudioUrl() <> ""
end function

function FindTrackIndexByTrack(track as object) as integer
    content = m.tracksGrid.content
    if content = invalid or track = invalid then return -1

    trackId = ""
    if track.id <> invalid and track.id <> ""
        trackId = track.id
    end if

    trackUrl = GetTrackStreamUrl(track)

    for i = 0 to content.GetChildCount() - 1
        child = content.getChild(i)
        if child = invalid then continue for

        if trackId <> "" and child.id <> invalid and child.id = trackId
            return i
        end if

        if trackUrl <> ""
            childUrl = GetTrackStreamUrl(child)
            if childUrl <> "" and childUrl = trackUrl
                return i
            end if
        end if
    end for

    return -1
end function

function GetTrackStreamUrl(track as object) as string
    if track = invalid then return ""

    url = ""
    if track.videoUrl <> invalid and track.videoUrl <> ""
        url = track.videoUrl
    else if track.streamUrl <> invalid and track.streamUrl <> ""
        url = track.streamUrl
    end if

    return NormalizeStreamUrl(url)
end function

function NormalizeStreamUrl(url as string) as string
    if url = invalid or url = "" then return ""
    return url.Replace("http:", "https:")
end function

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

function JoinMeta(parts as object) as string
    result = ""
    for i = 0 to parts.Count() - 1
        if i > 0
            result = result + " • "
        end if
        result = result + parts[i]
    end for
    return result
end function

sub onPlayAllSelect()
    startPlayAll()
end sub

sub startPlayAll()
    if m.tracksGrid.content = invalid then return
    if m.tracksGrid.content.GetChildCount() = 0 then return

    if isPaywallActive()
        showAppLockPopup()
        return
    end if

    m.isPlayAllMode = true
    playTrackAtIndex(0)
end sub

sub playTrackAtIndex(index as integer)
    if m.tracksGrid.content = invalid then return

    trackCount = m.tracksGrid.content.GetChildCount()
    if index < 0 or index >= trackCount then return

    track = m.tracksGrid.content.getChild(index)
    if track = invalid or track.videoUrl = invalid or track.videoUrl = "" then return

    if isPaywallActive()
        showAppLockPopup()
        return
    end if

    m.currentTrackIndex = index
    saveTracksGridFocus(index)
    updatePlayingStates(index)
    m.global.nowPlayingTrack = track
    ensureVideoObserver()

    videoContent = CreateObject("roSGNode", "ContentNode")
    videoContent.url = track.videoUrl
    videoContent.title = track.videoTitle
    videoContent.streamFormat = "mp3"

    m.scene.video.content = videoContent
    m.scene.video.visible = true
    m.scene.video.control = "play"
end sub

sub updatePlayingStates(activeIndex as integer)
    content = m.tracksGrid.content
    if content = invalid then return

    for i = 0 to content.GetChildCount() - 1
        child = content.getChild(i)
        if child <> invalid
            child.isPlaying = (i = activeIndex)
        end if
    end for
end sub

sub ensureVideoObserver()
    if m.videoObserverSet = true then return

    m.scene = m.top.getScene()
    if m.scene = invalid or m.scene.video = invalid then return

    m.scene.video.observeField("state", "onVideoState")
    m.videoObserverSet = true
end sub

sub onVideoState()
    if not m.top.visible then return
    if m.scene = invalid or m.scene.video = invalid then return

    if m.scene.video.state = "playing"
        startDurationTimer()
    else if m.scene.video.state = "paused" or m.scene.video.state = "stopped" or m.scene.video.state = "finished"
        stopDurationTimer()
    end if

    if m.isPlayAllMode
        if m.scene.video.state = "finished"
            if isPaywallActive()
                showAppLockPopup()
                return
            end if

            nextIndex = m.currentTrackIndex + 1
            if m.tracksGrid.content <> invalid and nextIndex < m.tracksGrid.content.GetChildCount()
                playTrackAtIndex(nextIndex)
            else
                endPlayAll()
            end if
        end if
    else
        syncPlayingIndicatorFromAudio()
    end if
end sub

sub resetPlaylistUI()
    m.isPlayAllMode = false
    m.currentTrackIndex = -1
    updatePlayingStates(-1)
end sub

sub endPlayAll()
    resetPlaylistUI()
    stopDurationTimer()

    if m.scene <> invalid and m.scene.video <> invalid
        m.scene.video.control = "stop"
    end if
end sub

sub onTrackFocused()
    index = m.tracksGrid.itemFocused
    if index = invalid then return
    saveTracksGridFocus(index)
end sub

sub onTrackSelect(evt)
    index = evt.getData()
    saveTracksGridFocus(index)
    m.isPlayAllMode = false
    m.currentTrackIndex = index
    updatePlayingStates(index)
    openMusicScreen(index)
end sub

sub openMusicScreen(index as integer)
    if m.tracksGrid.content = invalid then return
    if m.tracksGrid.content.GetChildCount() = 0 then return
    if index < 0 or index >= m.tracksGrid.content.GetChildCount() then return

    selectedTrack = m.tracksGrid.content.getChild(index)
    if selectedTrack = invalid then return

    if isPaywallActive()
        showAppLockPopup()
        return
    end if

    m.scene.callFunc("ShowMusicScreen", {
        selectedTrack: selectedTrack
        relatedContent: m.tracksGrid.content
        autoPlayNext: true
        playlistTitle: getPlaylistTitle()
        playlistThumbnail: getPlaylistThumbnail()
    })
end sub

function getPlaylistTitle() as string
    if m.playlistInfo <> invalid and m.playlistInfo.title <> invalid
        return m.playlistInfo.title
    end if
    return ""
end function

function getPlaylistThumbnail() as string
    if m.playlistInfo <> invalid and m.playlistInfo.thumbnail <> invalid
        return m.playlistInfo.thumbnail
    end if
    return ""
end function

sub onVisibleChange()
    if m.top.visible
        ensureVideoObserver()
        syncPlayingIndicatorFromAudio()
        restoreTracksGridFocus()

        if m.AppLockPopup <> invalid and m.AppLockPopup.visible
            m.top.setFocus(false)
            m.AppLockPopup.setFocus(true)
        end if
    else
        stopDurationTimer()
        stopGridBuildTask()
    end if
end sub

sub syncPlayingIndicatorFromAudio()
    m.scene = m.top.getScene()
    if m.scene = invalid or m.scene.video = invalid then return
    if m.tracksGrid.content = invalid then return

    currentUrl = GetCurrentAudioUrl()
    if currentUrl = ""
        updatePlayingStates(-1)
        m.currentTrackIndex = -1
        return
    end if

    state = m.scene.video.state
    if state <> "playing" and state <> "paused"
        updatePlayingStates(-1)
        m.currentTrackIndex = -1
        return
    end if

    matchedIndex = FindTrackIndexByUrl(currentUrl)
    if matchedIndex < 0 and m.global.nowPlayingTrack <> invalid
        matchedIndex = FindTrackIndexByTrack(m.global.nowPlayingTrack)
    end if

    if matchedIndex >= 0
        m.currentTrackIndex = matchedIndex
        saveTracksGridFocus(matchedIndex)
        updatePlayingStates(matchedIndex)
    else if m.currentTrackIndex >= 0
        updatePlayingStates(m.currentTrackIndex)
    else
        updatePlayingStates(-1)
    end if
end sub

function GetCurrentAudioUrl() as string
    if m.scene = invalid or m.scene.video = invalid then return ""
    if m.scene.video.content = invalid then return ""
    if m.scene.video.content.url = invalid then return ""
    return m.scene.video.content.url
end function

function FindTrackIndexByUrl(url as string) as integer
    content = m.tracksGrid.content
    if content = invalid or url = "" then return -1

    normalizedUrl = NormalizeStreamUrl(url)

    for i = 0 to content.GetChildCount() - 1
        child = content.getChild(i)
        if child = invalid then continue for

        childUrl = GetTrackStreamUrl(child)
        if childUrl <> "" and childUrl = normalizedUrl
            return i
        end if
    end for

    return -1
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "down" and m.btnPlayAll.hasFocus()
        m.btnPlayAll.setFocus(false)
        m.tracksGrid.setFocus(true)
        return true
    else if key = "up" and m.tracksGrid.hasFocus()
        focusedIndex = m.tracksGrid.itemFocused
        if focusedIndex = 0
            m.tracksGrid.setFocus(false)
            m.btnPlayAll.setFocus(true)
            return true
        end if
    else if key = "back"
        if m.AppLockPopup <> invalid and m.AppLockPopup.hasFocus()
            m.AppLockPopup.visible = false
            m.AppLockPopup.setFocus(false)
            m.tracksGrid.setFocus(true)
            return true
        end if
        resetPlaylistUI()
        m.scene.callFunc("CloseCurrentScreen")
        return true
    end if

    return false
end function
