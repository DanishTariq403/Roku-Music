sub init()
    m.videoIndex = invalid
    m.progressBarWidth = 1608
    m.progressBarX = 154
    m.seekStepSeconds = 10
    m.isShuffleOn = false
    m.isRepeatOn = false
    m.isDarkModeOn = false
    m.playerLayoutState = "expanded"

    m.baseBg = m.top.findNode("baseBg")
    m.artistBg = m.top.findNode("artistBg")
    m.bgDim = m.top.findNode("bgDim")
    m.musicPlayerGroup = m.top.findNode("musicPlayerGroup")
    m.relatedLabel = m.top.findNode("relatedLabel")
    m.playerUpAnim = m.top.findNode("playerUpAnim")
    m.playerDownAnim = m.top.findNode("playerDownAnim")
    m.trackThumb = m.top.findNode("trackThumb")
    m.headerPlaylistThumb = m.top.findNode("headerPlaylistThumb")
    m.headerPlaylistTitle = m.top.findNode("headerPlaylistTitle")
    m.durationBar = m.top.findNode("durationBar")
    m.positionBar = m.top.findNode("positionBar")
    m.positionBar.width = 0
    m.btnPositionBlob = m.top.findNode("btnPositionBlob")
    m.progressTimer = m.top.findNode("progressTimer")
    m.collapseTimer = m.top.findNode("collapseTimer")
    m.btnPlay = m.top.findNode("btnPlay")
    m.btnShuffle = m.top.findNode("btnShuffle")
    m.btnPrev = m.top.findNode("btnPrev")
    m.btnNext = m.top.findNode("btnNext")
    m.btnRepeat = m.top.findNode("btnRepeat")
    m.btnSave = m.top.findNode("btnSave")
    m.btnDarkMode = m.top.findNode("btnDarkMode")
    m.btnUpgrade = m.top.findNode("btnUpgrade")
    m.videoDuration = m.top.findNode("videoDuration")
    m.videoPosition = m.top.findNode("videoPosition")
    m.titleName = m.top.findNode("titleName")
    m.creatorName = m.top.findNode("creatorName")
    m.relatedList = m.top.findNode("relatedList")
    m.videospinner = m.top.findNode("videospinner")
    m.videospinner.poster.uri = "pkg:/images/spinner.png"
    m.videoDurationTimer = m.top.findNode("videoDurationTimer")
    m.AppLockPopup = m.top.findNode("AppLockPopup")

    m.relatedList.observeField("ItemSelected", "onRelatedItemSelect")
    m.progressTimer.ObserveField("fire", "OnProgressTimer")
    m.collapseTimer.observeField("fire", "onCollapseTimerFire")
    m.btnPlay.observeField("buttonSelected", "onBtnPlaySelect")
    m.btnShuffle.observeField("buttonSelected", "onBtnShuffleSelect")
    m.btnPrev.observeField("buttonSelected", "onBtnPrevSelect")
    m.btnNext.observeField("buttonSelected", "onBtnNextSelect")
    m.btnRepeat.observeField("buttonSelected", "onBtnRepeatSelect")
    m.btnSave.observeField("buttonSelected", "onBtnSaveSelect")
    m.btnDarkMode.observeField("buttonSelected", "onBtnDarkModeSelect")
    m.btnUpgrade.observeField("buttonSelected", "onBtnUpgradeSelect")
    m.videoDurationTimer.ObserveField("fire", "onVideoDurationChange")
    if m.AppLockPopup <> invalid
        m.AppLockPopup.observeField("buttonSelected", "onAppLockPopupSelect")
    end if
    m.top.observeField("visible", "onVisibleChange")

    loadTogglePreferences()
    updateShuffleButton()
    updateRepeatButton()
    updateDarkModeUI()
end sub

sub onTrackSelected()
    if m.top.visible
        loadSelectedTrack()
    end if
end sub

sub onVisibleChange()
    if not m.top.visible
        stopCollapseTimer()
        return
    end if

    resetPlayerLayout()
    ensureSceneObservers()

    if m.top.selectedTrack <> invalid
        loadSelectedTrack()
    end if

    if m.AppLockPopup <> invalid and m.AppLockPopup.visible
        m.top.setFocus(false)
        m.AppLockPopup.setFocus(true)
    end if
end sub

function isPaywallActive() as boolean
    if m.scene = invalid then return false
    if m.scene.isSubscribed = true then return false
    return m.global.duration >= m.global.videoDurationLimit
end function

sub showSubPopup()
    if not m.top.isTrialExpired then return

    m.top.setFocus(false)
    stopPlaybackTimers()

    if m.scene <> invalid and m.scene.video <> invalid
        m.scene.video.control = "pause"
    end if

    showAppLockPopup()
    m.top.isTrialExpired = false
end sub

sub showAppLockPopup()
    stopPlaybackTimers()

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

sub stopPlaybackTimers()
    if m.videoDurationTimer <> invalid
        m.videoDurationTimer.control = "stop"
    end if
    if m.progressTimer <> invalid
        m.progressTimer.control = "stop"
    end if
end sub

sub onAppLockPopupSelect()
    m.scene.callFunc("ShowSubscriptionScreen")
end sub

sub resetPlayerLayout()
    stopCollapseTimer()
    hidePositionBlobSeek()
    applyPlayerLayoutState("expanded", false)
end sub

sub onCollapseTimerFire()
    if not m.top.visible then return
    if m.playerLayoutState <> "expanded" then return
    if m.relatedList.hasFocus() then return

    collapsePlayerLayout()
end sub

sub startCollapseTimer()
    if m.collapseTimer = invalid then return
    m.collapseTimer.control = "stop"
    m.collapseTimer.control = "start"
end sub

sub stopCollapseTimer()
    if m.collapseTimer = invalid then return
    m.collapseTimer.control = "stop"
end sub

sub collapsePlayerLayout()
    hidePositionBlobSeek()
    applyPlayerLayoutState("collapsed", true)
    m.top.setFocus(true)
end sub

sub expandPlayerLayout()
    stopCollapseTimer()
    applyPlayerLayoutState("expanded", false)
    startCollapseTimer()
end sub

sub raisePlayerLayout()
    if m.playerLayoutState = "related" then return
    stopCollapseTimer()
    applyPlayerLayoutState("related", true)
end sub

sub lowerPlayerLayout()
    if m.playerLayoutState <> "related" then return

    m.playerLayoutState = "expanded"
    if m.playerDownAnim <> invalid
        m.playerDownAnim.control = "start"
    else
        applyExpandedLayout(false)
    end if
    startCollapseTimer()
end sub

sub applyPlayerLayoutState(state as string, animate as boolean)
    m.playerLayoutState = state

    if state = "related"
        applyRelatedLayout(animate)
    else if state = "collapsed"
        applyCollapsedLayout(animate)
    else
        applyExpandedLayout(animate)
    end if

    if state <> "collapsed" and not m.isDarkModeOn
        refreshBackgroundDim()
    end if
end sub

sub applyExpandedLayout(animate as boolean)
    m.progressBarX = 154
    m.progressBarWidth = 1608

    m.musicPlayerGroup.translation = [0, 0]
    m.relatedLabel.translation = [80, 1003]
    m.relatedList.translation = [80, 1052]
    m.relatedLabel.visible = true
    m.relatedList.visible = true

    setHeaderVisible(true)

    m.trackThumb.visible = true
    m.trackThumb.translation = [80, 561]
    m.trackThumb.width = 216
    m.trackThumb.height = 216

    m.titleName.visible = true
    m.titleName.translation = [328, 627]
    m.titleName.width = 1512
    m.creatorName.visible = true
    m.creatorName.translation = [328, 728]

    m.btnSave.visible = true
    m.btnSave.translation = [1719, 475]

    m.videoPosition.visible = true
    m.videoPosition.translation = [80, 817]
    m.videoDuration.visible = true
    m.videoDuration.translation = [1786, 817]
    m.durationBar.visible = true
    m.durationBar.translation = [154, 825]
    m.durationBar.width = 1608
    m.positionBar.translation = [154, 825]
    syncProgressBlobPosition()

    m.btnShuffle.visible = true
    m.btnPrev.visible = true
    m.btnPlay.visible = true
    m.btnPlay.translation = [240, 863]
    m.btnNext.visible = true
    m.btnRepeat.visible = true
    m.btnDarkMode.visible = true

    m.btnShuffle.translation = [80, 863]
    m.btnPrev.translation = [160, 863]
    m.btnNext.translation = [320, 863]
    m.btnRepeat.translation = [400, 863]
    m.btnDarkMode.translation = [1681, 834]
    m.videospinner.visible = false
    m.videospinner.translation = [230, 853]
    refreshBackgroundDim()
end sub

sub applyCollapsedLayout(animate as boolean)
    m.progressBarX = 80
    m.progressBarWidth = 1760

    m.musicPlayerGroup.translation = [0, 0]
    m.relatedLabel.visible = false
    m.relatedList.visible = false

    setHeaderVisible(false)
    hidePositionBlobSeek()

    m.trackThumb.visible = true
    m.trackThumb.translation = [80, 850]
    m.trackThumb.width = 100
    m.trackThumb.height = 100

    m.titleName.visible = true
    m.titleName.translation = [200, 838]
    m.titleName.width = 1600
    m.creatorName.visible = true
    m.creatorName.translation = [200, 928]
    m.creatorName.width = 1200

    m.btnSave.visible = false
    m.btnShuffle.visible = false
    m.btnPrev.visible = false
    m.btnPlay.visible = false
    m.btnNext.visible = false
    m.btnRepeat.visible = false
    m.btnDarkMode.visible = false
    m.videospinner.visible = false

    m.videoPosition.visible = true
    m.videoPosition.translation = [80, 958]
    m.videoDuration.visible = true
    m.videoDuration.translation = [1786, 958]
    m.durationBar.visible = true
    m.durationBar.translation = [80, 990]
    m.durationBar.width = 1760
    m.positionBar.translation = [80, 990]

    position = getCurrentPlaybackPosition()
    UpdateProgressUI(position)
    refreshBackgroundDim()
end sub

sub setHeaderVisible(visible as boolean)
    if m.headerPlaylistThumb <> invalid
        m.headerPlaylistThumb.visible = visible
    end if
    if m.headerPlaylistTitle <> invalid
        m.headerPlaylistTitle.visible = visible
    end if
    if m.btnUpgrade <> invalid
        m.btnUpgrade.visible = visible
    end if
end sub

sub applyRelatedLayout(animate as boolean)
    applyExpandedLayout(false)
    m.relatedLabel.visible = true
    m.relatedList.visible = true

    if animate and m.playerUpAnim <> invalid
        m.musicPlayerGroup.translation = [0, 0]
        m.relatedLabel.translation = [80, 1003]
        m.relatedList.translation = [80, 1052]
        m.playerUpAnim.control = "start"
    else
        m.musicPlayerGroup.translation = [0, -280]
        m.relatedLabel.translation = [80, 683]
        m.relatedList.translation = [80, 712]
    end if
end sub

sub syncProgressBlobPosition()
    if m.btnPositionBlob = invalid or m.positionBar = invalid then return

    barY = m.positionBar.translation[1]
    blobX = m.btnPositionBlob.translation[0]
    m.btnPositionBlob.translation = [blobX, barY - 5]
end sub

sub hidePositionBlobSeek()
    if m.btnPositionBlob = invalid then return
    m.btnPositionBlob.visible = false
    if m.btnPositionBlob.hasFocus()
        m.btnPositionBlob.setFocus(false)
    end if
end sub

sub showPositionBlobSeek()
    if m.btnPositionBlob = invalid then return
    if m.playerLayoutState = "collapsed" then return

    position = getCurrentPlaybackPosition()
    UpdateProgressUI(position)
    syncPositionBlobFromPosition(position)

    m.btnPositionBlob.visible = true
    m.btnPositionBlob.setFocus(true)
end sub

function getCurrentPlaybackPosition() as integer
    if m.scene = invalid or m.scene.video = invalid then return 0
    position = Int(m.scene.video.position)
    if position < 0 then position = 0
    return position
end function

sub syncPositionBlobFromPosition(position as integer)
    if m.btnPositionBlob = invalid or m.positionBar = invalid then return

    duration = getTrackDuration()
    if duration <= 0 then return

    percent = position / duration
    if percent < 0 then percent = 0
    if percent > 1 then percent = 1

    currentWidth = Int(m.progressBarWidth * percent)
    blobX = m.progressBarX + currentWidth - 8
    if blobX < m.progressBarX
        blobX = m.progressBarX
    end if

    barY = m.positionBar.translation[1]
    m.btnPositionBlob.translation = [blobX, barY - 5]
end sub

function getTrackDuration() as integer
    if m.scene = invalid or m.scene.video = invalid then return 0

    duration = Int(m.scene.video.duration)
    if duration > 0 then return duration

    if m.videoIndex <> invalid and m.videoIndex.audioDuration <> invalid
        return Int(Val(m.videoIndex.audioDuration.ToStr()))
    end if

    return 0
end function

sub seekByOffset(deltaSeconds as integer)
    if m.scene = invalid or m.scene.video = invalid then return

    duration = getTrackDuration()
    if duration <= 0 then return

    newPos = getCurrentPlaybackPosition() + deltaSeconds
    if newPos < 0 then newPos = 0
    if newPos > duration then newPos = duration

    m.scene.video.seek = newPos
    UpdateProgressUI(newPos)
    syncPositionBlobFromPosition(newPos)
    restartCollapseTimerIfExpanded()
end sub

sub restartCollapseTimerIfExpanded()
    if m.playerLayoutState = "expanded"
        startCollapseTimer()
    end if
end sub

sub setSecondaryControlsVisible(visible as boolean)
    m.btnShuffle.visible = visible
    m.btnPrev.visible = visible
    m.btnNext.visible = visible
    m.btnRepeat.visible = visible
    m.btnDarkMode.visible = visible
    m.btnSave.visible = visible
end sub

sub loadTogglePreferences()
    sec = CreateObject("roRegistrySection", "MusicPlayerPrefs")
    if sec.Exists("darkMode")
        m.isDarkModeOn = (sec.Read("darkMode") = "true")
    end if
end sub

sub saveTogglePreferences()
    sec = CreateObject("roRegistrySection", "MusicPlayerPrefs")
    if m.isDarkModeOn
        sec.Write("darkMode", "true")
    else
        sec.Write("darkMode", "false")
    end if
    sec.Flush()
end sub

sub updateShuffleButton()
    if m.isShuffleOn
        m.btnShuffle.focusBitmapUri = "pkg:/images/btnMsShuffleOnF.png"
        m.btnShuffle.focusFootprintBitmapUri = "pkg:/images/btnMsShuffleOnUF.png"
    else
        m.btnShuffle.focusBitmapUri = "pkg:/images/btnMsShuffleF.png"
        m.btnShuffle.focusFootprintBitmapUri = "pkg:/images/btnMsShuffleUF.png"
    end if
end sub

sub updateRepeatButton()
    if m.isRepeatOn
        m.btnRepeat.focusBitmapUri = "pkg:/images/btnMsRepeatOnF.png"
        m.btnRepeat.focusFootprintBitmapUri = "pkg:/images/btnMsRepeatOnUF.png"
    else
        m.btnRepeat.focusBitmapUri = "pkg:/images/btnMsRepeatF.png"
        m.btnRepeat.focusFootprintBitmapUri = "pkg:/images/btnMsRepeatUF.png"
    end if
end sub

sub updateDarkModeButton()
    if m.isDarkModeOn
        m.btnDarkMode.focusBitmapUri = "pkg:/images/btnMsDarkOnF.png"
        m.btnDarkMode.focusFootprintBitmapUri = "pkg:/images/btnMsDarkOnUF.png"
    else
        m.btnDarkMode.focusBitmapUri = "pkg:/images/btnMsDarkF.png"
        m.btnDarkMode.focusFootprintBitmapUri = "pkg:/images/btnMsDarkUF.png"
    end if
end sub

sub updateDarkModeUI()
    if m.bgDim = invalid then return

    if m.isDarkModeOn
        m.bgDim.color = "0x000000FF"
        if m.baseBg <> invalid
            m.baseBg.visible = false
        end if
        if m.artistBg <> invalid
            m.artistBg.visible = false
        end if
    else
        if m.baseBg <> invalid
            m.baseBg.visible = true
        end if
        if m.artistBg <> invalid
            m.artistBg.visible = true
        end if
        refreshBackgroundDim()
    end if

    updateDarkModeButton()
end sub

sub refreshBackgroundDim()
    if m.bgDim = invalid or m.isDarkModeOn then return

    if m.playerLayoutState = "collapsed"
        m.bgDim.color = "0x00000055"
    else
        m.bgDim.color = "0x000000AA"
    end if
end sub

sub refreshSaveButtonState()
    if m.videoIndex = invalid or m.videoIndex.videoUrl = invalid or m.videoIndex.videoUrl = ""
        m.isTrackSaved = false
    else
        m.isTrackSaved = IsTrackFavorite(m.videoIndex.videoUrl)
    end if
    updateSaveButton()
end sub

sub updateSaveButton()
    if m.isTrackSaved
        m.btnSave.focusBitmapUri = "pkg:/images/btnMsSaveOnF.png"
        m.btnSave.focusFootprintBitmapUri = "pkg:/images/btnMsSaveOnUF.png"
    else
        m.btnSave.focusBitmapUri = "pkg:/images/btnMsSaveF.png"
        m.btnSave.focusFootprintBitmapUri = "pkg:/images/btnMsSaveUF.png"
    end if
end sub

sub ensureSceneObservers()
    m.scene = m.top.getScene()
    if m.scene = invalid then return

    if m.videoObserversSet <> true
        m.scene.video.ObserveField("state", "onVideoState")
        m.videoObserversSet = true
    end if
end sub

sub loadSelectedTrack()
    track = m.top.selectedTrack
    if track = invalid then return

    ensureSceneObservers()
    if m.scene = invalid or m.scene.video = invalid then return

    m.videoIndex = track
    m.global.nowPlayingTrack = track
    relatedContent = m.top.relatedContent
    if relatedContent <> invalid
        m.relatedList.content = relatedContent
    end if

    updatePlaylistHeader()
    updateTrackUI(track)

    if m.scene.video.state <> "playing"
        m.videospinner.visible = true
    end if

    m.scene.video.control = "stop"
    m.scene.video.content = invalid

    if m.videoIndex.videoUrl = invalid or m.videoIndex.videoUrl = ""
        m.videospinner.visible = false
        return
    end if

    if isPaywallActive()
        m.videospinner.visible = false
        showAppLockPopup()
        return
    end if

    m.videoContent = CreateObject("rosgNode", "ContentNode")
    m.videoContent.url = m.videoIndex.videoUrl
    m.videoContent.title = m.videoIndex.videoTitle
    m.videoContent.streamFormat = "mp3"

    m.positionBar.width = 0
    m.videoPosition.text = "00:00"
    m.videoDuration.text = FormatDuration(m.videoIndex.audioDuration)

    m.scene.video.visible = true
    m.scene.video.content = m.videoContent
    m.scene.video.control = "play"

    if m.top.resumePosition > 0
        m.scene.video.seek = m.top.resumePosition
    end if

    updatePlayPauseButton(false)
    refreshSaveButtonState()
    expandPlayerLayout()
    m.btnPlay.setFocus(true)
end sub

sub updatePlaylistHeader()
    if m.top.playlistTitle <> invalid and m.top.playlistTitle <> ""
        m.headerPlaylistTitle.text = m.top.playlistTitle
    else
        m.headerPlaylistTitle.text = "Now Playing"
    end if

    playlistThumb = m.top.playlistThumbnail
    if playlistThumb = invalid or playlistThumb = ""
        if m.videoIndex <> invalid and m.videoIndex.videoThumbnail <> invalid
            playlistThumb = m.videoIndex.videoThumbnail
        end if
    end if

    if playlistThumb <> invalid and playlistThumb <> ""
        m.headerPlaylistThumb.uri = playlistThumb.Replace("http:", "https:")
    else
        m.headerPlaylistThumb.uri = "pkg:/images/GI.png"
    end if
end sub

sub updateTrackUI(track as object)
    if track = invalid then return

    m.titleName.text = track.videoTitle

    if track.creator <> invalid
        m.creatorName.text = track.creator
    else if track.subtitle <> invalid
        m.creatorName.text = track.subtitle
    else
        m.creatorName.text = ""
    end if

    bgUri = invalid
    if track.artistImage <> invalid and track.artistImage <> ""
        bgUri = track.artistImage
    else if track.videoThumbnail <> invalid
        bgUri = track.videoThumbnail
    end if

    if bgUri <> invalid
        bgUri = bgUri.Replace("http:", "https:")
        m.artistBg.uri = bgUri
        m.trackThumb.uri = bgUri
    else
        m.artistBg.uri = "pkg:/images/BG.png"
        m.trackThumb.uri = "pkg:/images/GI.png"
    end if

    updateDarkModeUI()
end sub

sub updatePlayPauseButton(isPaused as boolean)
    if isPaused
        m.btnPlay.focusBitmapUri = "pkg:/images/btnMsPlayF.png"
        m.btnPlay.focusFootprintBitmapUri = "pkg:/images/btnMsPlayUF.png"
    else
        m.btnPlay.focusBitmapUri = "pkg:/images/btnMsPauseF.png"
        m.btnPlay.focusFootprintBitmapUri = "pkg:/images/btnMsPauseUF.png"
    end if
end sub

sub onVideoDurationChange()
    if m.scene = invalid
        m.scene = m.top.getScene()
    end if
    if m.scene = invalid or m.scene.isSubscribed = true then return
    if not m.top.visible then return

    m.scene.callFunc("setCurrentDuration")
end sub

sub OnProgressTimer()
    if m.scene = invalid
        m.scene = m.top.getScene()
    end if
    if m.scene = invalid or m.scene.video = invalid then return
    if m.btnPositionBlob <> invalid and m.btnPositionBlob.hasFocus() then return

    m.seekPosition = m.scene.video.position
    UpdateProgressUI(m.seekPosition)
end sub

sub onBtnPlaySelect()
    if m.playerLayoutState = "collapsed"
        expandPlayerLayout()
        m.btnPlay.setFocus(true)
        return
    end if

    if m.scene.video.state = "paused" or m.scene.video.state = "stopped"
        if isPaywallActive()
            showAppLockPopup()
            return
        end if

        if m.top.isVideoResume and m.top.resumePosition > 0
            m.scene.video.control = "resume"
        else
            m.scene.video.control = "resume"
        end if
    else
        m.scene.video.control = "pause"
    end if

    restartCollapseTimerIfExpanded()
end sub

sub onBtnShuffleSelect()
    restartCollapseTimerIfExpanded()
    m.isShuffleOn = not m.isShuffleOn
    updateShuffleButton()
end sub

sub onBtnRepeatSelect()
    restartCollapseTimerIfExpanded()
    m.isRepeatOn = not m.isRepeatOn
    updateRepeatButton()
end sub

sub onBtnPrevSelect()
    restartCollapseTimerIfExpanded()
    playAdjacentTrack(-1, false)
end sub

sub onBtnNextSelect()
    restartCollapseTimerIfExpanded()
    playAdjacentTrack(1, false)
end sub

sub onBtnSaveSelect()
    if m.videoIndex = invalid then return

    if IsTrackFavorite(m.videoIndex.videoUrl)
        RemoveFromFaves(m.videoIndex)
        m.isTrackSaved = false
    else
        AddToFaves(m.videoIndex)
        m.isTrackSaved = true
    end if

    updateSaveButton()
end sub

sub onBtnDarkModeSelect()
    m.isDarkModeOn = not m.isDarkModeOn
    updateDarkModeUI()
    saveTogglePreferences()
end sub

sub onBtnUpgradeSelect()
    m.scene.callFunc("ShowSubscriptionScreen")
end sub

sub onVideoState()
    if not m.top.visible then return

    if m.scene = invalid
        m.scene = m.top.getScene()
    end if
    if m.scene = invalid or m.scene.video = invalid then return

    if m.scene.video.state <> invalid and m.scene.video.state = "playing"
        m.positionBar.visible = true
        m.videospinner.visible = false
        m.videoDurationTimer.control = "start"
        m.progressTimer.control = "start"
        updatePlayPauseButton(false)
    else if m.scene.video.state = "finished" or m.scene.video.state = "paused" or m.scene.video.state = "stopped"
        m.videoDurationTimer.control = "stop"
        m.progressTimer.control = "stop"

        if m.scene.video.state = "finished"
            if isPaywallActive()
                showAppLockPopup()
                return
            end if

            m.positionBar.visible = false
            if m.top.saveContinueWatching and m.videoIndex <> invalid
                RemoveContinueWatching(m.videoIndex.videoUrl)
            end if

            if m.top.autoPlayNext = true or m.isRepeatOn = true
                if m.isRepeatOn
                    replayCurrentTrack()
                else
                    playAdjacentTrack(1, true)
                end if
            else
                closeMusicScreen()
            end if
        else if m.scene.video.state = "paused"
            updatePlayPauseButton(true)
            if m.top.saveContinueWatching and m.videoIndex <> invalid
                SaveContinueWatching(m.videoIndex, m.scene.video.position, m.scene.video.duration)
            end if
        end if
    end if
end sub

sub replayCurrentTrack()
    if m.videoIndex = invalid then return
    m.top.selectedTrack = m.videoIndex
    loadSelectedTrack()
end sub

sub onRelatedItemSelect(evt)
    index = evt.getData()

    ensureSceneObservers()
    if m.scene = invalid or m.scene.video = invalid then return

    if isPaywallActive()
        showAppLockPopup()
        return
    end if

    if m.relatedList.content = invalid then return

    track = m.relatedList.content.getChild(index)
    if track = invalid then return

    m.top.selectedTrack = track
    loadSelectedTrack()
    lowerPlayerLayout()
    m.btnPlay.setFocus(true)
end sub

sub playAdjacentTrack(direction as integer, allowClose as boolean)
    if isPaywallActive()
        showAppLockPopup()
        return
    end if

    if m.relatedList.content = invalid or m.videoIndex = invalid
        if allowClose
            closeMusicScreen()
        end if
        return
    end if

    currentIndex = FindTrackIndex(m.videoIndex.videoUrl)
    if currentIndex = -1
        if allowClose
            closeMusicScreen()
        end if
        return
    end if

    trackCount = m.relatedList.content.GetChildCount()
    nextIndex = currentIndex + direction

    if m.isShuffleOn and direction > 0
        nextIndex = Rnd(trackCount) - 1
    end if

    if nextIndex < 0
        nextIndex = trackCount - 1
    else if nextIndex >= trackCount
        if allowClose
            closeMusicScreen()
            return
        end if
        nextIndex = 0
    end if

    nextTrack = m.relatedList.content.getChild(nextIndex)
    if nextTrack = invalid or nextTrack.videoUrl = invalid or nextTrack.videoUrl = ""
        if allowClose
            closeMusicScreen()
        end if
        return
    end if

    m.top.selectedTrack = nextTrack
    loadSelectedTrack()
end sub

function FindTrackIndex(videoUrl as string) as integer
    if m.relatedList.content = invalid or videoUrl = "" then return -1

    for i = 0 to m.relatedList.content.GetChildCount() - 1
        child = m.relatedList.content.getChild(i)
        if child <> invalid and child.videoUrl = videoUrl
            return i
        end if
    end for

    return -1
end function

sub playNextTrack()
    playAdjacentTrack(1, true)
end sub

sub closeMusicScreen()
    if m.top.saveContinueWatching and m.videoIndex <> invalid
        SaveContinueWatching(m.videoIndex, m.scene.video.position, m.scene.video.duration)
    end if
    m.positionBar.visible = false
    m.scene.callFunc("CloseCurrentScreen")
end sub

sub UpdateProgressUI(position as integer)
    if m.scene = invalid
        m.scene = m.top.getScene()
    end if
    if m.scene = invalid or m.scene.video = invalid then return

    duration = getTrackDuration()
    if duration <= 0 then return

    percent = position / duration
    if percent < 0 then percent = 0
    if percent > 1 then percent = 1

    currentWidth = Int(m.progressBarWidth * percent)
    m.positionBar.width = currentWidth

    if m.btnPositionBlob <> invalid and m.btnPositionBlob.visible
        syncPositionBlobFromPosition(position)
    end if

    m.videoPosition.text = PositionToTime(position)

    remaining = duration - position
    if remaining < 0 then remaining = 0
    m.videoDuration.text = "-" + PositionToTime(remaining)
end sub

function PositionToTime(position as integer) as string
    minutes = Int(position / 60)
    seconds = position mod 60
    if seconds < 10
        return minutes.ToStr() + ":0" + seconds.ToStr()
    end if
    return minutes.ToStr() + ":" + seconds.ToStr()
end function

function FormatDuration(value as dynamic) as string
    if value = invalid then return "0:00"

    strValue = value.ToStr()
    seconds = Val(strValue)

    if seconds <= 0 and strValue <> "0"
        return strValue
    end if

    minutes = Int(seconds / 60)
    remainingSeconds = seconds mod 60
    if remainingSeconds < 10
        return minutes.ToStr() + ":0" + remainingSeconds.ToStr()
    end if
    return minutes.ToStr() + ":" + remainingSeconds.ToStr()
end function

sub AddToFaves(itemContent as object)
    sec = CreateObject("roRegistrySection", "FaveReg")

    jsonItem = {
        videoTitle: itemContent.videoTitle
        videoUrl: itemContent.videoUrl
        videoThumbnail: itemContent.videoThumbnail
        creator: itemContent.creator
        audioDuration: itemContent.audioDuration
    }

    entries = []
    if sec.Exists("entries")
        storedJson = sec.Read("entries")
        if storedJson <> ""
            entries = ParseJson(storedJson)
        end if
    end if

    filteredEntries = []
    for each entry in entries
        if entry.videoUrl <> jsonItem.videoUrl
            filteredEntries.Push(entry)
        end if
    end for

    filteredEntries.Push(jsonItem)

    if filteredEntries.Count() > 20
        filteredEntries = filteredEntries.slice(filteredEntries.Count() - 20)
    end if

    sec.Write("entries", FormatJson(filteredEntries))
    sec.Flush()
end sub

function IsTrackFavorite(videoUrl as string) as boolean
    if videoUrl = invalid or videoUrl = "" then return false

    sec = CreateObject("roRegistrySection", "FaveReg")
    if not sec.Exists("entries") then return false

    storedJson = sec.Read("entries")
    if storedJson = invalid or storedJson = "" then return false

    entries = ParseJson(storedJson)
    if entries = invalid then return false

    for each entry in entries
        if entry <> invalid and entry.videoUrl = videoUrl
            return true
        end if
    end for

    return false
end function

sub RemoveFromFaves(itemContent as object)
    if itemContent = invalid or itemContent.videoUrl = invalid then return

    sec = CreateObject("roRegistrySection", "FaveReg")
    entries = []

    if sec.Exists("entries")
        storedJson = sec.Read("entries")
        if storedJson <> ""
            entries = ParseJson(storedJson)
        end if
    end if

    if entries = invalid then return

    filteredEntries = []
    for each entry in entries
        if entry = invalid then continue for
        if entry.videoUrl <> itemContent.videoUrl
            filteredEntries.Push(entry)
        end if
    end for

    sec.Write("entries", FormatJson(filteredEntries))
    sec.Flush()
end sub

sub RemoveContinueWatching(videoId as string)
    sec = CreateObject("roRegistrySection", "ContinueWatching")
    sec.Delete(videoId)
    sec.Flush()
end sub

sub SaveContinueWatching(videoNode as object, position as float, duration as float)
    if videoNode = invalid then return

    sec = CreateObject("roRegistrySection", "ContinueWatching")
    dt = CreateObject("roDateTime")
    dt.Mark()

    data = {
        videoId: videoNode.videoUrl
        videoTitle: videoNode.videoTitle
        videoUrl: videoNode.videoUrl
        videoThumbnail: videoNode.videoThumbnail
        type: videoNode.type
        resumePosition: position
        duration: duration
        audioDuration: videoNode.audioDuration
        lastWatched: dt.AsSeconds()
    }
    sec.Write(data.videoId, FormatJson(data))
    sec.Flush()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "back"
        if m.AppLockPopup <> invalid and m.AppLockPopup.hasFocus()
            m.AppLockPopup.visible = false
            m.AppLockPopup.setFocus(false)
            m.btnPlay.setFocus(true)
            return true
        end if
        closeMusicScreen()
        return true
    else if key = "OK" and m.playerLayoutState = "collapsed"
        expandPlayerLayout()
        m.btnPlay.setFocus(true)
        return true
    else if key = "left"
        if m.btnPositionBlob <> invalid and m.btnPositionBlob.hasFocus()
            seekByOffset(-m.seekStepSeconds)
            return true
        end if
        if m.playerLayoutState = "collapsed" then return false
        return navigateControls(-1)
    else if key = "right"
        if m.btnPositionBlob <> invalid and m.btnPositionBlob.hasFocus()
            seekByOffset(m.seekStepSeconds)
            return true
        end if
        if m.playerLayoutState = "collapsed" then return false
        return navigateControls(1)
    else if key="down" and m.btnUpgrade.hasFocus()
        m.btnSave.setFocus(true)
        return true
        else if key="down" and m.btnSave.hasFocus()
        m.btnDarkMode.setFocus(true)
        return true
    else if key = "down" and m.btnPositionBlob <> invalid and m.btnPositionBlob.hasFocus()
        hidePositionBlobSeek()
        m.btnPlay.setFocus(true)
        return true
    else if key = "down" and (isControlFocused() or m.playerLayoutState = "collapsed")
        hidePositionBlobSeek()
        if m.playerLayoutState = "collapsed"
            m.top.setFocus(false)
        else
            unfocusCurrentControl()
        end if
        raisePlayerLayout()
        m.relatedList.setFocus(true)
        return true
    else if key = "up"
        if m.playerLayoutState = "collapsed"
            expandPlayerLayout()
            showPositionBlobSeek()
            return true
        else if m.relatedList.hasFocus()
            m.relatedList.setFocus(false)
            lowerPlayerLayout()
            m.btnPlay.setFocus(true)
            return true
        else if m.btnPositionBlob.hasFocus()
            m.btnSave.setFocus(true)
            return true
        else if isControlFocused()
            showPositionBlobSeek()
            return true
        else if m.btnSave.hasFocus() and m.btnUpgrade.visible
            m.btnUpgrade.setFocus(true)
            return true
        else if m.btnSave.hasFocus()
            m.btnPlay.setFocus(true)
            return true
        else if m.btnUpgrade.hasFocus()
            m.btnPlay.setFocus(true)
            return true
        end if
    end if

    return false
end function

function isControlFocused() as boolean
    return m.btnShuffle.hasFocus() or m.btnPrev.hasFocus() or m.btnPlay.hasFocus() or m.btnNext.hasFocus() or m.btnRepeat.hasFocus() or m.btnDarkMode.hasFocus()
end function

sub unfocusCurrentControl()
    controls = [m.btnShuffle, m.btnPrev, m.btnPlay, m.btnNext, m.btnRepeat, m.btnDarkMode]
    for each control in controls
        if control.hasFocus()
            control.setFocus(false)
            return
        end if
    end for
end sub

function navigateControls(direction as integer) as boolean
    controls = [m.btnShuffle, m.btnPrev, m.btnPlay, m.btnNext, m.btnRepeat, m.btnDarkMode]
    current = -1

    for i = 0 to controls.Count() - 1
        if controls[i].hasFocus()
            current = i
            exit for
        end if
    end for

    if current = -1 then return false

    nextIdx = current + direction
    if nextIdx < 0 or nextIdx >= controls.Count() then return false

    controls[current].setFocus(false)
    controls[nextIdx].setFocus(true)
    return true
end function
