sub init()
    m.global.RAT = true
    m.isVideoResume = false
    m.pendingEraItem = invalid

    m.scene = m.top.getScene()
    m.scene.screenName = "Explore"
    m.currentCategory = "Explore"

    m.blurOL = m.top.findNode("blurOL")
    m.spinner = m.top.findNode("spinner")
    m.spinner.poster.observeField("loadStatus", "showspinner")
    m.spinner.poster.uri = "pkg:/images/spinnerGen.png"
    m.videosList = m.top.findNode("videosList")

    navBarInit("Explore")

    m.videosList.observeField("rowItemSelected", "onVideoSelect")
    m.videosList.observeField("rowItemFocused", "onVideoFocus")

    m.ExploreDataGetter = CreateObject("roSGNode", "GetExploreTask")
    m.ExploreDataGetter.observeField("content", "SetContent")

    m.EraTracksGetter = CreateObject("roSGNode", "GetEraTracksTask")
    m.EraTracksGetter.observeField("content", "OnEraTracksLoaded")

    if m.spinner <> invalid
        m.spinner.visible = true
    end if
    m.ExploreDataGetter.control = "RUN"

    m.top.observeField("visible", "onVisibleChange")
    m.savedListFocus = invalid
end sub

sub onVisibleChange()
    if m.top.visible
        m.scene.screenName = "Explore"
        m.scene.currentCategory = "Explore"
        navBarInit("Explore")
        restoreExploreListFocus()
    else
        if m.ExploreDataGetter <> invalid and m.ExploreDataGetter.state = "run"
            m.ExploreDataGetter.control = "STOP"
        end if
        if m.EraTracksGetter <> invalid and m.EraTracksGetter.state = "run"
            m.EraTracksGetter.control = "STOP"
        end if
    end if
end sub

sub saveExploreListFocus(index as object)
    if index = invalid then return
    m.savedListFocus = index
end sub

sub restoreExploreListFocus()
    if m.videosList = invalid then return

    if m.savedListFocus <> invalid and m.videosList.content <> invalid
        row = m.savedListFocus[0]
        col = m.savedListFocus[1]
        if row >= 0 and row < m.videosList.content.getChildCount()
            rowNode = m.videosList.content.getChild(row)
            if rowNode <> invalid and col >= 0 and col < rowNode.getChildCount()
                m.videosList.jumpToRowItem = m.savedListFocus
            end if
        end if
    end if

    m.videosList.setFocus(true)
end sub

sub SetContent()
    m.spinner.visible=false
    m.exploreArray = m.ExploreDataGetter.content
    if m.exploreArray = invalid then return

    videoGridContent = CreateObject("roSGNode", "ContentNode")
    BuildExploreRows(videoGridContent)

    if videoGridContent.GetChildCount() > 0
        m.videosList.content = videoGridContent
        m.videosList.setFocus(true)
    end if

    if m.spinner <> invalid
        m.spinner.visible = false
    end if
end sub

sub BuildExploreRows(videoGridContent as object)
    if m.exploreArray = invalid or m.exploreArray.sections = invalid or m.exploreArray.sectionOrder = invalid
        return
    end if

    sections = m.exploreArray.sections
    subscribed = m.scene <> invalid and m.scene.isSubscribed = true
    rowItemSizes = []
    rowItemSpacings = []
    rowHeights = []

    for each sectionId in m.exploreArray.sectionOrder
        if sectionId = invalid then continue for

        section = sections[sectionId]
        if section = invalid or section.items = invalid or section.items.Count() = 0
            continue for
        end if

        rowNode = CreateSectionRow(section, sectionId, subscribed)
        if rowNode <> invalid and rowNode.GetChildCount() > 0
            videoGridContent.AppendChild(rowNode)
            layout = section.layout
            if layout = invalid then layout = "square"
            AppendExploreRowLayoutArrays(layout, rowItemSizes, rowItemSpacings, rowHeights)
        end if
    end for

    ApplyVideosListRowLayouts(rowItemSizes, rowItemSpacings, rowHeights)
end sub

sub ApplyVideosListRowLayouts(rowItemSizes as object, rowItemSpacings as object, rowHeights as object)
    if rowItemSizes.Count() = 0 then return

    m.videosList.rowItemSize = rowItemSizes
    m.videosList.rowItemSpacing = rowItemSpacings
    m.videosList.rowHeights = rowHeights

    maxRowHeight = 0
    for each rowHeight in rowHeights
        if rowHeight > maxRowHeight
            maxRowHeight = rowHeight
        end if
    end for

    ' rowHeights controls each row; avoid inflating all rows to the tallest section
    if rowHeights.Count() > 0
        m.videosList.itemSize = [1759, rowHeights[0]]
    else if maxRowHeight > 0
        m.videosList.itemSize = [1759, maxRowHeight]
    end if
end sub

function CreateSectionRow(section as object, sectionId as string, subscribed as boolean) as object
    rowNode = CreateObject("roSGNode", "ContentNode")
    rowNode.title = section.title

    itemType = section.itemType
    if itemType = invalid
        itemType = "track"
    end if

    layout = section.layout
    if layout = invalid
        layout = "square"
    end if

    for each video in section.items
        if video = invalid then continue for

        item = rowNode.CreateChild("RowItemData")
        MapApiItemToRowItem(item, video, itemType, sectionId, layout, subscribed)

        if layout = "mood" and video.moodName <> invalid
            item.videoTitle = video.moodName
            item.moodName = video.moodName
            if video.moodColor <> invalid
                item.moodColor = video.moodColor
            end if
            if video.emoji <> invalid
                item.emoji = video.emoji
            end if
        else if layout = "era"
            if video.title <> invalid
                item.videoTitle = video.title
            end if
            if video.subtitle <> invalid
                item.subtitle = video.subtitle
            end if
            if video.era <> invalid
                item.era = video.era
            end if
        end if
    end for

    if rowNode.GetChildCount() = 0 then return invalid
    return rowNode
end function

sub MapApiItemToRowItem(item as object, video as object, itemType as string, sectionId as string, layout as string, subscribed as boolean)
    item.videoTitle = ""
    item.videoThumbnail = ""
    item.videoUrl = ""
    item.creator = ""
    item.audioDuration = ""
    item.id = ""
    item.sectionId = sectionId
    item.sectionLayout = layout
    item.itemType = itemType
    item.source = "audius"

    if video.title <> invalid
        item.videoTitle = video.title
    end if

    if video.thumbnail <> invalid
        item.videoThumbnail = video.thumbnail
    else if video.artwork <> invalid
        item.videoThumbnail = video.artwork
    else if video.artistImage <> invalid
        item.videoThumbnail = video.artistImage
    end if

    if video.subtitle <> invalid
        item.subtitle = video.subtitle
    else if video.artist <> invalid
        item.subtitle = video.artist
    else if video.creator <> invalid
        item.subtitle = video.creator
    end if

    if video.rank <> invalid
        item.rank = video.rank
    end if

    if video.badgeText <> invalid
        item.badgeText = video.badgeText
    end if

    if video.moodColor <> invalid
        item.moodColor = video.moodColor
    end if

    if video.era <> invalid
        item.era = video.era
    end if

    if itemType = "playlist" or itemType = "artist"
        if video.id <> invalid
            item.id = video.id
        end if

        if video.creator <> invalid
            item.creator = video.creator
        else if video.artist <> invalid
            item.creator = video.artist
        end if

        if video.trackCount <> invalid
            item.trackCount = video.trackCount
        end if

        if video.tracks <> invalid and Type(video.tracks) = "roArray" and video.tracks.Count() > 0
            item.tracksJson = FormatJson(video.tracks)
            track = video.tracks[0]
            if track <> invalid and track.streamUrl <> invalid
                item.videoUrl = track.streamUrl
                item.streamUrl = track.streamUrl
            end if
            if track <> invalid and track.duration <> invalid
                item.audioDuration = track.duration.ToStr()
            end if
        end if
    else if itemType = "era"
        if video.era <> invalid
            item.era = video.era
        end if
    else
        if video.id <> invalid
            item.id = video.id
        end if
        if video.artist <> invalid
            item.creator = video.artist
        end if
        if video.streamUrl <> invalid
            item.videoUrl = video.streamUrl
            item.streamUrl = video.streamUrl
        end if
        if video.duration <> invalid
            item.audioDuration = video.duration.ToStr()
        end if
    end if

    item.type = "Free"
end sub

sub onVideoFocus(evt)
    index = evt.getData()
    saveExploreListFocus(index)
    selectedRow = m.videosList.content.getChild(index[0])
    if selectedRow <> invalid
        m.videoIndex = selectedRow.getChild(index[1])
    end if
end sub

sub onVideoSelect(evt)
    m.isVideoResume = false
    index = evt.getData()
    saveExploreListFocus(index)

    selectedRow = m.videosList.content.getChild(index[0])
    if selectedRow = invalid then return

    m.videoIndex = selectedRow.getChild(index[1])
    m.currentVideoNode = m.videoIndex
    if m.videoIndex = invalid then return

    if m.videoIndex.itemType = "era" or m.videoIndex.sectionId = "browseByEra"
        LoadEraTracks(m.videoIndex)
        return
    end if

    parentNode = CreateObject("roSGNode", "ContentNode")
    for each item in selectedRow.getChildren(-1, 0)
        parentNode.AppendChild(item.Clone(true))
    end for

    if ShouldOpenPlaylistDetail(m.videoIndex)
        m.scene.callFunc("ShowPlaylistDetailScreen", {
            playlistInfo: BuildPlaylistInfo(m.videoIndex)
        })
        return
    end if

    if m.global.duration >= m.global.videoDurationLimit and m.top.getScene().isSubscribed = false
        showAppLockPopup()
    else
        m.scene.callFunc("ShowMusicScreen", {
            selectedTrack: m.videoIndex
            relatedContent: parentNode
        })
    end if
end sub

sub LoadEraTracks(eraItem as object)
    if eraItem = invalid then return

    era = eraItem.era
    if era = invalid or era = ""
        if eraItem.videoTitle <> invalid
            era = LCase(eraItem.videoTitle)
        end if
    end if
    if era = invalid or era = "" then return

    m.pendingEraItem = eraItem
    if m.spinner <> invalid
        m.spinner.visible = true
    end if

    if m.EraTracksGetter.state = "run"
        m.EraTracksGetter.control = "STOP"
    end if

    m.EraTracksGetter.era = era
    m.EraTracksGetter.control = "RUN"
end sub

sub OnEraTracksLoaded()
    if m.spinner <> invalid
        m.spinner.visible = false
    end if

    tracks = m.EraTracksGetter.content
    if tracks = invalid or tracks.Count() = 0 then return

    relatedContent = CreateObject("roSGNode", "ContentNode")
    for each track in tracks
        if track = invalid then continue for

        item = relatedContent.CreateChild("RowItemData")
        item.itemType = "track"
        item.sectionId = "browseByEra"
        item.sectionLayout = "square"
        item.type = "Free"

        if track.title <> invalid
            item.videoTitle = track.title
        end if
        if track.thumbnail <> invalid
            item.videoThumbnail = track.thumbnail
        end if
        if track.artist <> invalid
            item.creator = track.artist
            item.subtitle = track.artist
        end if
        if track.id <> invalid
            item.id = track.id
        end if
        if track.streamUrl <> invalid
            item.videoUrl = track.streamUrl
            item.streamUrl = track.streamUrl
        end if
        if track.duration <> invalid
            item.audioDuration = track.duration.ToStr()
        end if
    end for

    if relatedContent.GetChildCount() = 0 then return

    selectedTrack = relatedContent.getChild(0)

    if m.global.duration >= m.global.videoDurationLimit and m.top.getScene().isSubscribed = false
        showAppLockPopup()
    else
        m.scene.callFunc("ShowMusicScreen", {
            selectedTrack: selectedTrack
            relatedContent: relatedContent
        })
    end if
end sub

function ShouldOpenPlaylistDetail(item as object) as boolean
    if item = invalid then return false
    if item.sectionId = "moodPlaylists" then return true
    if item.itemType = "playlist" then return true
    return false
end function

function BuildPlaylistInfo(item as object) as object
    info = {
        id: ""
        title: ""
        artist: ""
        thumbnail: ""
        trackCount: 0
        sectionId: ""
        moodName: ""
        tracksJson: ""
    }

    if item.id <> invalid
        info.id = item.id
    end if
    if item.videoTitle <> invalid
        info.title = item.videoTitle
    end if
    if item.creator <> invalid
        info.artist = item.creator
    else if item.subtitle <> invalid
        info.artist = item.subtitle
    end if
    if item.videoThumbnail <> invalid
        info.thumbnail = item.videoThumbnail
    end if
    if item.trackCount <> invalid
        info.trackCount = item.trackCount
    end if
    if item.sectionId <> invalid
        info.sectionId = item.sectionId
    end if
    if item.moodName <> invalid
        info.moodName = item.moodName
    end if
    if item.tracksJson <> invalid
        info.tracksJson = item.tracksJson
    end if

    return info
end function

sub showSubPopup()
    if m.top.isTrialExpired
        m.top.setFocus(false)
        m.AppLockPopup.visible = true
        m.AppLockPopup.setFocus(true)
        m.scene.video.visible = false
        m.scene.video.control = "stop"
        m.top.isTrialExpired = false
    end if
end sub

sub showAppLockPopup()
    m.scene.video.control = "stop"
    m.scene.video.visible = false
    if m.AppLockPopup = invalid then return
    m.AppLockPopup.focusBitmapUri = "pkg:/images/subExpPopup.png"
    m.top.setFocus(false)
    m.AppLockPopup.visible = true
    m.AppLockPopup.setFocus(true)
end sub

function OnKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "back" and m.AppLockPopup.hasFocus()
        m.AppLockPopup.visible = false
        m.AppLockPopup.setFocus(false)
        m.videosList.setFocus(true)
        return true
    else if key = "left" and m.videosList.hasFocus()
        m.videosList.setFocus(false)
        m.blurOL.visible = true

        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoEF.png"
        m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaEUF.png"
        m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaEF.png"
        m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavEUF.png"
        m.btnFavN.focusBitmapUri = "pkg:/images/btnfavEF.png"
        m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubEUF.png"
        m.btnSubN.focusBitmapUri = "pkg:/images/btnSubEF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSS.png"
        m.btnSettingN.focusBitmapUri = "pkg:/images/btnBSEF.png"

        m.btnSettingN.setFocus(true)
        return true
    else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus())
        m.top.setFocus(false)
        m.videosList.setFocus(true)
        return true
    else if key = "down" and m.btnHomeN.hasFocus()
        m.btnHomeN.setFocus(false)
        m.btnSubN.setFocus(true)
        return true
    else if key = "down" and m.btnSubN.hasFocus()
        m.btnSubN.setFocus(false)
        m.btnFavN.setFocus(true)
        return true
    else if key = "down" and m.btnFavN.hasFocus()
        m.btnFavN.setFocus(false)
        m.btnSettingN.setFocus(true)
        return true
    else if key = "down" and m.btnSearchN.hasFocus()
        m.btnSearchN.setFocus(false)
        m.btnHomeN.setFocus(true)
        return true
    else if key = "up" and m.btnHomeN.hasFocus()
        m.btnHomeN.setFocus(false)
        m.btnSearchN.setFocus(true)
        return true
    else if key = "up" and m.btnSubN.hasFocus()
        m.btnSubN.setFocus(false)
        m.btnHomeN.setFocus(true)
        return true
    else if key = "up" and m.btnFavN.hasFocus()
        m.btnFavN.setFocus(false)
        m.btnSubN.setFocus(true)
        return true
    else if key = "up" and m.btnSettingN.hasFocus()
        m.btnSettingN.setFocus(false)
        m.btnFavN.setFocus(true)
        return true
    end if

    return false
end function
