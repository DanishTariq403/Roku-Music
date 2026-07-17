sub init()
    m.global.RAT = true
    m.isVideoResume = false

    m.scene = m.top.getScene()
    m.scene.screenName = "Home"
    m.currentRow = 0
    m.blurOL = m.top.findNode("blurOL")
    m.watchList = m.top.findNode("watchList")
    m.watchList.visible = false

    m.exitPopup = m.top.findNode("exitPopup")
    m.btnExit = m.top.findNode("btnExit")
    m.btnClaim = m.top.findNode("btnClaim")
    m.btnClaim.observeField("buttonSelected", "onbtnClaimSelect")
    m.btnExit.observeField("buttonSelected", "onbtnExitSelect")
    m.watchList.observeField("rowItemSelected", "onWatchVideoSelect")
    m.busyspinner = m.top.findNode("spinner")

    m.btnCat1 = m.top.findNode("btnCat1")
    m.btnCat2 = m.top.findNode("btnCat2")
    m.btnCat3 = m.top.findNode("btnCat3")
    m.btnCat5 = m.top.findNode("btnCat5")
    m.btnCat4 = m.top.findNode("btnCat4")
    m.btnCat6 = m.top.findNode("btnCat6")
    m.btnCat7 = m.top.findNode("btnCat7")
    m.videosGrid = m.top.findNode("videosGrid")
    m.videosGroup = m.top.findNode("videosGroup")


    m.navbar = m.top.findNode("navbar")
    m.dotGroup = m.top.findNode("dotGroup")
    m.isPrevHero = true
    m.currentCategory = m.scene.currentCategory
    m.savedListFocus = invalid
    navBarInit("Home")

    m.herodownAnim = m.top.findNode("herodownAnim")
    m.heroupAnim = m.top.findNode("heroupAnim")
    m.videosupAnim = m.top.findNode("videosupAnim")
    m.videosdownAnim = m.top.findNode("videosdownAnim")
    ' m.scene.video = m.top.findNode("videoPlayer")
    m.global.audio = m.scene.video
    m.scene.video.ObserveField("state", "onVideoState")
    m.ChangeImageTimer = m.top.findNode("ChangeImageTimer")
    m.ChangeImageTimer.ObserveField("fire", "changeImage")

    m.videosList = m.top.findNode("videosList")
    m.heroList = m.top.findNode("heroList")
    m.nowPlayingGroup = m.top.findNode("nowPlayingGroup")
    m.npThumb = m.top.findNode("npThumb")
    m.npTitle = m.top.findNode("npTitle")
    m.npArtist = m.top.findNode("npArtist")
    m.btnHeroPlayPause = m.top.findNode("btnHeroPlayPause")
    m.btnHeroPlayPause.observeField("buttonSelected", "onHeroPlayPauseSelect")
    m.addToFavInstruction = m.top.findNode("AddTofavInstruction")
    m.global.observeField("nowPlayingTrack", "onNowPlayingTrackChange")
    m.videosGrid.observeField("itemSelected", "onHeroSelect")
    m.videosGrid.observeField("itemFocused", "onHeroFocus")
    m.videosList.observeField("rowitemSelected", "onVideoSelect")
    m.videosList.observeField("rowitemFocused", "onVideoFocus")
    m.watchList.observeField("rowitemFocused", "onWatchVideoFocus")
    if m.global.videoArray = invalid
        m.VideoArrayGetter = CreateObject("roSGNode", "GetJsonTask")
        m.VideoArrayGetter.ObserveField("content", "SetContent")
        m.VideoArrayGetter.control = "RUN"
    else
        ShowCategory(m.scene.currentCategory)
    end if

    ' ShowAddToFavoritesHintDialog()
    m.top.observeField("visible", "onVisibleChange")
    m.dotContainer = m.top.findNode("dotContainer")
    createDots(4)
    m.btnCat1.observeField("buttonSelected", "onbtnCat1Select")
    m.btnCat2.observeField("buttonSelected", "onbtnCat2Select")
    m.btnCat3.observeField("buttonSelected", "onbtnCat3Select")
    m.btnCat4.observeField("buttonSelected", "onbtnCat4Select")
    m.btnCat5.observeField("buttonSelected", "onbtnCat5Select")
    m.btnCat6.observeField("buttonSelected", "onbtnCat6Select")
    m.btnCat7.observeField("buttonSelected", "onbtnCat7Select")

    m.global.microphoeSearchKeyboard.hideTextBox = true
    m.global.microphoeSearchKeyboard.textEditBox.observeField("text", "OnmicKeyboardTextFieldChanged")
    m.global.microphoeSearchKeyboard.textEditBox.observeField("isDictating", "onDictating")

    updateHeroNowPlaying()
end sub

sub OnmicKeyboardTextFieldChanged()
    ?"1"
    if m.scene.screenName = "Home"
        m.videosList.setFocus(true)
    end if

end sub

sub onDictating()
    ' m.keyboardGroup.visible=false
    OnmicKeyboardTextFieldChanged()


end sub

sub UpdateContinueWatchingRow(videoNode as object)
    RefreshContinueWatchingUI()
end sub
sub onbtnClaimSelect()
    m.top.btnDiscountSelect = true

end sub
sub onbtnExitSelect()
    m.scene.appExit = true


end sub

sub resetButtonsUri()
    m.btnCat1.focusBitmapUri = "pkg:/images/btnCat1F.png"
    m.btnCat1.focusfootprintbitmapuri = "pkg:/images/btnCat1UF.png"
    m.btnCat2.focusBitmapUri = "pkg:/images/btnCat2F.png"
    m.btnCat2.focusfootprintbitmapuri = "pkg:/images/btnCat2UF.png"
    m.btnCat3.focusBitmapUri = "pkg:/images/btnCat3F.png"
    m.btnCat3.focusfootprintbitmapuri = "pkg:/images/btnCat3UF.png"
    m.btnCat4.focusBitmapUri = "pkg:/images/btnCat4F.png"
    m.btnCat4.focusfootprintbitmapuri = "pkg:/images/btnCat4UF.png"
    m.btnCat5.focusBitmapUri = "pkg:/images/btnCat5F.png"
    m.btnCat5.focusfootprintbitmapuri = "pkg:/images/btnCat5UF.png"
    m.btnCat6.focusBitmapUri = "pkg:/images/btnCat6F.png"
    m.btnCat6.focusfootprintbitmapuri = "pkg:/images/btnCat6UF.png"
    m.btnCat7.focusBitmapUri = "pkg:/images/btnCat7F.png"
    m.btnCat7.focusfootprintbitmapuri = "pkg:/images/btnCat7UF.png"

end sub

sub ShowCategory(categoryName as string)


    m.videosArray = m.global.videoArray




    BuildRows()

end sub



' sub BuildRows()

'     videoGridContent = CreateObject("roSGNode", "ContentNode")

'     RefreshContinueWatchingUI()

'     ' ---------------------------------
'     ' Collect all subcategory rows
'     ' ---------------------------------
'     rows = []

'     for each mainCategory in m.videosArray

'         categoryData = m.videosArray[mainCategory]

'         for each subCategory in categoryData

'             rowArray = categoryData[subCategory]

'             if Type(rowArray) = "roArray"

'                 rows.Push({
'                     title: subCategory
'                     videos: rowArray
'                 })

'             end if

'         end for

'     end for

'     ' ---------------------------------
'     ' Rotate rows based on current time
'     ' ---------------------------------
'     if rows.Count() > 1

'         dt = CreateObject("roDateTime")
'         offset = dt.AsSeconds() mod rows.Count()

'         rotatedRows = []

'         for i = 0 to rows.Count() - 1

'             index = (i + offset) mod rows.Count()
'             rotatedRows.Push(rows[index])

'         end for

'         rows = rotatedRows

'     end if

'     ' ---------------------------------
'     ' Build ContentNodes from rows
'     ' ---------------------------------
'     for each rowData in rows

'         rowNode = CreateObject("roSGNode", "ContentNode")
'         rowNode.title = rowData.title

'         i = 0

'         for each video in rowData.videos

'             if video = invalid
'                 continue for
'             end if

'             item = rowNode.CreateChild("RowItemData")

'             item.videoTitle = video.title
'             item.videoUrl = video.mp3_url
'             item.videoThumbnail = video.thumbnail

'             if m.scene.isSubscribed
'                 item.type = "Free"
'             else
'                 item.type = "Free"
'                 ' if i >= 5 then item.type = "Paid"
'             end if

'             i = i + 1

'         end for

'         videoGridContent.AppendChild(rowNode)

'     end for

'     m.videosList.content = videoGridContent
'     m.videosList.setFocus(true)

' end sub

sub BuildRows()

    videoGridContent = CreateObject("roSGNode", "ContentNode")

    if m.videosArray = invalid or Type(m.videosArray) <> "roAssociativeArray" then
        m.busyspinner.visible = false
        refreshHeroNowPlayingIfVisible()
        return
    end if

    if m.videosArray.sectionOrder <> invalid and m.videosArray.sections <> invalid
        BuildDesignedHomeRows(videoGridContent)
        if videoGridContent.GetChildCount() > 0
            m.videosList.content = videoGridContent
            m.videosList.setFocus(true)
        end if
        m.busyspinner.visible = false
        refreshHeroNowPlayingIfVisible()
        return
    end if

    BuildLegacyHomeRows(videoGridContent)

    if videoGridContent.GetChildCount() > 0
        m.videosList.content = videoGridContent
    end if

    m.busyspinner.visible = false
    m.videosList.setFocus(true)

    refreshHeroNowPlayingIfVisible()
end sub

sub refreshHeroNowPlayingIfVisible()
    if m.top.visible
        updateHeroNowPlaying()
    end if
end sub

sub BuildDesignedHomeRows(videoGridContent as object)
    sections = m.videosArray.sections
    subscribed = m.scene <> invalid and m.scene.isSubscribed = true

    for each sectionId in m.videosArray.sectionOrder
        if sectionId = invalid then continue for

        section = sections[sectionId]
        if section = invalid or section.items = invalid or section.items.Count() = 0
            continue for
        end if

        if sectionId = "hero"
            BuildHeroUI(section)
            continue for
        end if

        rowNode = CreateSectionRow(section, sectionId, subscribed)
        if rowNode <> invalid and rowNode.GetChildCount() > 0
            videoGridContent.AppendChild(rowNode)
        end if
    end for

    continueRow = BuildContinueWatchingRow(subscribed)
    if continueRow <> invalid
        insertIndex = GetContinueWatchingRowInsertIndex(videoGridContent)
        videoGridContent.InsertChild(continueRow, insertIndex)
    end if

    RebuildVideosListRowLayouts(videoGridContent)
    m.videosList.translation = [161,610]
end sub

sub ApplyVideosListRowLayouts(rowItemSizes as object, rowItemSpacings as object, rowHeights as object)
    if rowItemSizes.Count() = 0
        if m.videosArray <> invalid and m.videosArray.rowItemSize <> invalid
            m.videosList.rowItemSize = m.videosArray.rowItemSize
            m.videosList.rowItemSpacing = m.videosArray.rowItemSpacing
            m.videosList.rowHeights = m.videosArray.rowHeights
            rowHeights = m.videosArray.rowHeights
        else
            return
        end if
    else
        m.videosList.rowItemSize = rowItemSizes
        m.videosList.rowItemSpacing = rowItemSpacings
        m.videosList.rowHeights = rowHeights
    end if

    maxRowHeight = 0
    if rowHeights <> invalid
        for each rowHeight in rowHeights
            if rowHeight > maxRowHeight
                maxRowHeight = rowHeight
            end if
        end for
    end if

    if maxRowHeight > 0
        m.videosList.itemSize = [1756, maxRowHeight]
    end if
end sub

sub BuildHeroUI(section as object)
    featured = section.items[0]
    if featured = invalid then return

    m.featuredPlaylist = featured

    thumb = m.top.findNode("thumbnailPoster")
    titleLabel = m.top.findNode("videoTitle")
    optionLabel = m.top.findNode("optionTitle")

    if section.label <> invalid
        optionLabel.text = section.label
    else
        optionLabel.text = "FEATURED PLAYLIST"
    end if

    if featured.title <> invalid
        titleLabel.text = featured.title
    end if

    thumbUri = GetHeroImageUri(featured)
    applyHeroImage(thumb, thumbUri)
    updateAddToFavInstruction(featured)
end sub

sub applyHeroImage(thumb as object, thumbUri as string)
    if thumb = invalid or thumbUri = "" then return
    thumb.uri = thumbUri
end sub

sub updateHeroFromItem(item as object)
    if item = invalid then return

    optionLabel = m.top.findNode("optionTitle")
    titleLabel = m.top.findNode("videoTitle")
    thumb = m.top.findNode("thumbnailPoster")

    optionLabel.text = BuildHeroOptionText(item)

    if item.videoTitle <> invalid
        titleLabel.text = item.videoTitle
    end if

    thumbUri = GetHeroImageUri(item)
    applyHeroImage(thumb, thumbUri)
    updateAddToFavInstruction(item)
end sub

function BuildHeroOptionText(item as object) as string
    if item = invalid then return ""

    if ShouldShowTrackCount(item)
        parts = []
        if item.creator <> invalid and item.creator <> ""
            parts.Push(item.creator)
        else if item.subtitle <> invalid and item.subtitle <> ""
            parts.Push(item.subtitle)
        end if

        trackCount = GetItemTrackCount(item)
        if trackCount > 0
            if trackCount = 1
                parts.Push("1 Song")
            else
                parts.Push(trackCount.ToStr() + " Songs")
            end if
        else if item.source <> invalid and item.source <> ""
            parts.Push(item.source)
        end if

        return JoinHeroOptionParts(parts)
    end if

    durationSec = GetHeroDurationSeconds(item)

    if item.source <> invalid and item.source <> "" and durationSec > 0
        return item.creator + " • " + item.source + " • " + durationSec.ToStr() + " seconds"
    else if durationSec > 0
        return item.creator + " • " + durationSec.ToStr() + " seconds"
    else if item.creator <> invalid and item.source <> invalid
        return item.creator + " • " + item.source
    else if item.subtitle <> invalid and item.subtitle <> ""
        return item.subtitle
    end if

    return ""
end function

function ShouldShowTrackCount(item as object) as boolean
    if item = invalid then return false
    if item.isAlbum = true then return true
    if item.sectionLayout = "album" then return true
    if item.sectionId = "featuredAlbums" then return true
    if item.itemType = "playlist" then return true
    return false
end function

function GetHeroDurationSeconds(item as object) as integer
    if item = invalid then return -1

    if item.duration <> invalid and item.duration > 0
        return Int(item.duration + 0.5)
    end if

    if item.audioDuration <> invalid and item.audioDuration <> ""
        durationSec = Val(item.audioDuration)
        if durationSec > 0
            return Int(durationSec + 0.5)
        end if
    end if

    return -1
end function

function GetItemTrackCount(item as object) as integer
    if item = invalid then return 0

    if item.trackCount <> invalid and item.trackCount > 0
        return item.trackCount
    end if

    if item.tracksJson <> invalid and item.tracksJson <> ""
        tracks = ParseJson(item.tracksJson)
        if tracks <> invalid and Type(tracks) = "roArray"
            return tracks.Count()
        end if
    end if

    return 0
end function

function JoinHeroOptionParts(parts as object) as string
    if parts = invalid or parts.Count() = 0 then return ""

    result = parts[0]
    for i = 1 to parts.Count() - 1
        result = result + " • " + parts[i]
    end for
    return result
end function

function GetHeroImageUri(source as object) as string
    if source = invalid then return ""

    if source.thumbnail <> invalid and source.thumbnail <> ""
        return source.thumbnail.Replace("http:", "https:")
    end if

    if source.videoThumbnail <> invalid and source.videoThumbnail <> "" and source.videoThumbnail <> "pkg:/images/VAPH.png"
        return source.videoThumbnail.Replace("http:", "https:")
    end if

    if source.artwork <> invalid and source.artwork <> ""
        return source.artwork.Replace("http:", "https:")
    end if

    if source.artistImage <> invalid and source.artistImage <> ""
        return source.artistImage.Replace("http:", "https:")
    end if

    if source.tracks <> invalid and Type(source.tracks) = "roArray" and source.tracks.Count() > 0
        track = source.tracks[0]
        if track <> invalid and track.thumbnail <> invalid and track.thumbnail <> ""
            return track.thumbnail.Replace("http:", "https:")
        end if
        if track <> invalid and track.artistImage <> invalid and track.artistImage <> ""
            return track.artistImage.Replace("http:", "https:")
        end if
    end if

    tracksJson = invalid
    if source.tracksJson <> invalid and source.tracksJson <> ""
        tracksJson = source.tracksJson
    end if
    if tracksJson <> invalid
        tracks = ParseJson(tracksJson)
        if tracks <> invalid and Type(tracks) = "roArray" and tracks.Count() > 0
            track = tracks[0]
            if track <> invalid and track.thumbnail <> invalid and track.thumbnail <> ""
                return track.thumbnail.Replace("http:", "https:")
            end if
            if track <> invalid and track.artistImage <> invalid and track.artistImage <> ""
                return track.artistImage.Replace("http:", "https:")
            end if
        end if
    end if

    return ""
end function

function BuildContinueWatchingRow(subscribed as boolean) as object
    videos = GetContinueWatchingVideos()
    if videos.Count() = 0 then return invalid

    SortVideosByLastWatched(videos)
    return BuildContinueWatchingRowFromVideos(videos, subscribed)
end function

function BuildContinueWatchingRowFromVideos(videos as object, subscribed as boolean) as object
    rowNode = CreateObject("roSGNode", "ContentNode")
    rowNode.title = "Recently Played"

    for each video in videos
        if video = invalid then continue for

        item = rowNode.CreateChild("RowItemData")
        item.sectionId = "continueWatching"
        item.sectionLayout = "continue"
        item.itemType = "track"
        item.videoTitle = video.videoTitle
        item.videoUrl = video.videoUrl
        item.videoThumbnail = video.videoThumbnail
        item.creator = video.creator
        item.resumePosition = video.resumePosition
        item.duration = video.duration
        if video.audioDuration <> invalid
            if Type(video.audioDuration) = "roString" or Type(video.audioDuration) = "String"
                item.audioDuration = video.audioDuration
            else
                item.audioDuration = video.audioDuration.ToStr()
            end if
        end if
        item.id = video.videoId
        item.type = "Free"
    end for

    if rowNode.GetChildCount() = 0 then return invalid
    return rowNode
end function

function FindContinueWatchingRowIndex(rootContent as object) as integer
    if rootContent = invalid then return -1

    for i = 0 to rootContent.getChildCount() - 1
        row = rootContent.getChild(i)
        if row = invalid then continue for
        if row.title = "Recently Played" or row.title = "Continue Watching"
            return i
        end if
    end for

    return -1
end function

function GetContinueWatchingRowInsertIndex(rootContent as object) as integer
    if rootContent = invalid then return 0

    totalRows = rootContent.GetChildCount()
    if totalRows <= 0 then return 0

    middleIndex = Int(totalRows / 2)
    if middleIndex < 1 and totalRows > 1
        middleIndex = 1
    end if

    return middleIndex
end function

sub RebuildVideosListRowLayouts(rootContent as object)
    rowItemSizes = []
    rowItemSpacings = []
    rowHeights = []

    if rootContent = invalid then return

    for i = 0 to rootContent.getChildCount() - 1
        row = rootContent.getChild(i)
        layout = "square"

        if row <> invalid and row.getChildCount() > 0
            firstItem = row.getChild(0)
            if firstItem.sectionLayout <> invalid and firstItem.sectionLayout <> ""
                layout = firstItem.sectionLayout
            end if
        end if

        AppendRowLayoutArrays(layout, rowItemSizes, rowItemSpacings, rowHeights)
    end for

    ApplyVideosListRowLayouts(rowItemSizes, rowItemSpacings, rowHeights)
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

    if video.rankChange <> invalid
        item.rankChange = video.rankChange
    end if

    if video.badgeText <> invalid
        item.badgeText = video.badgeText
    end if

    if video.description <> invalid
        item.description = video.description
    end if

    if video.moodColor <> invalid
        item.moodColor = video.moodColor
    end if

    if video.releaseYear <> invalid
        item.releaseYear = video.releaseYear
    end if

    if video.genre <> invalid
        item.genre = video.genre
    end if

    if video.artistImage <> invalid
        item.artistImage = video.artistImage
    end if

    if video.handle <> invalid
        item.handle = video.handle
    end if

    if video.isAlbum = true or layout = "album"
        item.isAlbum = true
    end if

    if itemType = "playlist" or itemType = "artist"
        if video.id <> invalid
            item.id = video.id
        end if

        if video.creator <> invalid
            item.creator = video.creator
        else if video.artist <> invalid
            item.creator = video.artist
        else if video.title <> invalid and itemType = "artist"
            item.creator = video.title
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

    if subscribed
        item.type = "Free"
    else
        item.type = "Free"
    end if
end sub

sub BuildLegacyHomeRows(videoGridContent as object)
    rows = []

    for each categoryName in m.videosArray

        categoryData = m.videosArray[categoryName]

        if categoryData = invalid then
            continue for
        end if

        videos = invalid
        rowType = "track"

        if Type(categoryData) = "roAssociativeArray"

            if categoryData.items <> invalid and Type(categoryData.items) = "roArray"
                videos = categoryData.items
            end if

            if categoryData.type <> invalid
                rowType = categoryData.type
            end if

        else if Type(categoryData) = "roArray"

            videos = categoryData

        end if

        if videos <> invalid and Type(videos) = "roArray" and videos.Count() > 0

            rows.Push({
                title: categoryName
                type: rowType
                videos: videos
                era: categoryData.era
                genre: categoryData.genre
                mood: categoryData.mood
            })

        end if

    end for

    ' ---------------------------------
    ' Rotate rows
    ' ---------------------------------
    if rows.Count() > 1

        dt = CreateObject("roDateTime")
        offset = Int(dt.AsSeconds() / 60) mod rows.Count()

        rotatedRows = []

        for i = 0 to rows.Count() - 1

            idx = (i + offset) mod rows.Count()
            rotatedRows.Push(rows[idx])

        end for

        rows = rotatedRows

    end if

    subscribed = false
    if m.scene <> invalid and m.scene.isSubscribed <> invalid
        subscribed = m.scene.isSubscribed
    end if

    rowItemSizes = []
    rowItemSpacings = []
    rowHeights = []

    ' ---------------------------------
    ' Build rows
    ' ---------------------------------
    for each rowData in rows

        if rowData = invalid or rowData.videos = invalid then
            continue for
        end if

        rowNode = CreateObject("roSGNode", "ContentNode")

        if rowData.title <> invalid
            rowNode.title = rowData.title
        else
            rowNode.title = ""
        end if

        uniqueVideos = []
        seenKeys = {}

        ' ---------------------------------
        ' Remove duplicates
        ' ---------------------------------
        for each video in rowData.videos

            if video = invalid or Type(video) <> "roAssociativeArray"
                continue for
            end if

            uniqueKey = ""

            if rowData.type = "playlist"

                if video.id <> invalid
                    uniqueKey = video.id
                end if

            else

                if video.streamUrl <> invalid and video.streamUrl <> ""
                    uniqueKey = video.streamUrl
                else if video.id <> invalid
                    uniqueKey = video.id
                end if

            end if

            if uniqueKey = ""
                continue for
            end if

            if not seenKeys.DoesExist(uniqueKey)

                seenKeys[uniqueKey] = true
                uniqueVideos.Push(video)

            end if

        end for

        videos = uniqueVideos

        if videos.Count() = 0
            continue for
        end if

        ' ---------------------------------
        ' Rotate videos
        ' ---------------------------------
        if videos.Count() > 1

            dt = CreateObject("roDateTime")

            titleLen = 0
            if rowData.title <> invalid
                titleLen = Len(rowData.title)
            end if

            videoOffset = (dt.AsSeconds() + titleLen) mod videos.Count()

            rotatedVideos = []

            for x = 0 to videos.Count() - 1

                idx = (x + videoOffset) mod videos.Count()
                rotatedVideos.Push(videos[idx])

            end for

            videos = rotatedVideos

        end if

        i = 0

        ' ---------------------------------
        ' Create RowItemData
        ' ---------------------------------
        for each video in videos

            if video = invalid then
                continue for
            end if

            item = rowNode.CreateChild("RowItemData")

            item.videoTitle = ""
            item.videoThumbnail = ""
            item.videoUrl = ""
            item.creator = ""
            item.audioDuration = ""
            item.id = ""

            if video.title <> invalid
                item.videoTitle = video.title
            end if

            if video.thumbnail <> invalid
                item.videoThumbnail = video.thumbnail
            else if video.artwork <> invalid
                item.videoThumbnail = video.artwork
            end if

            if video.artistImage <> invalid
                item.artistImage = video.artistImage
            end if

            if video.genre <> invalid
                item.genre = video.genre
            end if

            if video.playCount <> invalid
                item.playCount = video.playCount
            end if

            if video.handle <> invalid
                item.handle = video.handle
            end if

            if video.releaseDate <> invalid
                item.releaseDate = video.releaseDate
            end if

            item.source = "audius"

            if rowData.era <> invalid and item.era = invalid
                item.era = rowData.era
            end if

            if rowData.genre <> invalid and item.genre = invalid
                item.genre = rowData.genre
            end if

            if rowData.type = "playlist"

                item.itemType = "playlist"

                if video.id <> invalid
                    item.id = video.id
                end if

                if video.isAlbum = true
                    item.isAlbum = true
                    item.sectionLayout = "album"
                else if video.trackCount <> invalid and video.trackCount > 3
                    item.isAlbum = true
                    item.sectionLayout = "album"
                end if

                if video.creator <> invalid
                    item.creator = video.creator
                else if video.artist <> invalid
                    item.creator = video.artist
                else if video.title <> invalid
                    item.creator = video.title
                end if

                if video.trackCount <> invalid
                    item.trackCount = video.trackCount
                else
                    item.trackCount = 0
                end if

                if video.tracks <> invalid and Type(video.tracks) = "roArray" and video.tracks.Count() > 0

                    item.tracksJson = FormatJson(video.tracks)
                    track = video.tracks[0]

                    if track <> invalid

                        if track.streamUrl <> invalid
                            item.videoUrl = track.streamUrl
                            item.streamUrl = track.streamUrl
                        end if

                        if track.duration <> invalid
                            item.audioDuration = track.duration.ToStr()
                        end if

                        if item.artistImage = invalid and track.artistImage <> invalid
                            item.artistImage = track.artistImage
                        end if

                    end if

                end if

            else

                item.itemType = "track"

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

            if subscribed
                item.type = "Free"
            else
                item.type = "Free"
            end if

            i = i + 1

        end for

        if rowNode.GetChildCount() > 0
            videoGridContent.AppendChild(rowNode)
            AppendRowLayoutArrays("square", rowItemSizes, rowItemSpacings, rowHeights)
        end if

    end for

    if videoGridContent.GetChildCount() > 0
        m.videosList.content = videoGridContent
        ApplyVideosListRowLayouts(rowItemSizes, rowItemSpacings, rowHeights)
    end if

end sub

' sub BuildRows()

'     videoGridContent = CreateObject("roSGNode", "ContentNode")

'     RefreshContinueWatchingUI()

'     ' ---------------------------------
'     ' Collect rows
'     ' ---------------------------------
'     rows = []

'     for each categoryName in m.videosArray

'         categoryData = m.videosArray[categoryName]
'         if categoryData <> invalid and categoryData.items <> invalid
'             count = categoryData.items.Count()
'         end if


'         if categoryData <> invalid

'             videos = invalid

'             if categoryData.items <> invalid
'                 videos = categoryData.items
'             else if Type(categoryData) = "roArray"
'                 videos = categoryData
'             end if

'             if videos <> invalid

'                 rows.Push({
'                     title: categoryName
'                     type: categoryData.type
'                     videos: videos
'                 })

'             end if

'         end if

'     end for

'     ' ---------------------------------
'     ' Rotate row order
'     ' ---------------------------------
'     if rows.Count() > 1

'         dt = CreateObject("roDateTime")
'         offset = Int(dt.AsSeconds() / 60) mod rows.Count()

'         rotatedRows = []

'         for i = 0 to rows.Count() - 1

'             idx = (i + offset) mod rows.Count()
'             rotatedRows.Push(rows[idx])

'         end for

'         rows = rotatedRows

'     end if

'     ' ---------------------------------
'     ' Build ContentNodes
'     ' ---------------------------------
'     for each rowData in rows

'         rowNode = CreateObject("roSGNode", "ContentNode")
'         rowNode.title = rowData.title

'         ' ---------------------------------
'         ' Remove duplicates
'         ' ---------------------------------
'         uniqueVideos = []
'         seenKeys = {}


'         for each video in rowData.videos


'             uniqueKey = ""

'             if rowData.type = "playlist"


'                 if video.id <> invalid
'                     uniqueKey = video.id
'                 end if

'             else

'                 if video.streamUrl <> invalid
'                     uniqueKey = video.streamUrl
'                 else if video.id <> invalid
'                     uniqueKey = video.id
'                 end if

'             end if

'             if uniqueKey <> ""

'                 if not seenKeys.DoesExist(uniqueKey)

'                     seenKeys[uniqueKey] = true
'                     uniqueVideos.Push(video)

'                 end if

'             end if

'         end for

'         videos = uniqueVideos

'         ' ---------------------------------
'         ' Rotate items inside row
'         ' ---------------------------------
'         if videos.Count() > 1

'             dt = CreateObject("roDateTime")

'             videoOffset = (dt.AsSeconds() + Len(rowData.title)) mod videos.Count()

'             rotatedVideos = []

'             for x = 0 to videos.Count() - 1

'                 idx = (x + videoOffset) mod videos.Count()
'                 rotatedVideos.Push(videos[idx])

'             end for

'             videos = rotatedVideos

'         end if

'         i = 0

'         for each video in videos

'             item = rowNode.CreateChild("RowItemData")

'             item.videoTitle = video.title
'             item.videoThumbnail = video.thumbnail

'             if rowData.type = "playlist"

'                 item.itemType = "playlist"
'                 item.id = video.id
'                 item.creator = video.creator
'                 item.trackCount = video.trackCount

'                 if video.tracks <> invalid and video.tracks.Count() > 0

'                     item.videoUrl = video.tracks[0].streamUrl
'                     item.audioDuration = video.tracks[0].duration

'                 else

'                     item.videoUrl = ""
'                     item.audioDuration = 0

'                 end if

'             else

'                 item.itemType = "track"
'                 item.id = video.id
'                 item.creator = video.artist
'                 item.videoUrl = video.streamUrl
'                 item.audioDuration = video.duration

'             end if

'             if m.scene.isSubscribed
'                 item.type = "Free"
'             else
'                 item.type = "Free"
'                 ' if i >= 5 then item.type = "Paid"
'             end if

'             i = i + 1

'         end for

'         videoGridContent.AppendChild(rowNode)

'     end for

'     m.videosList.content = videoGridContent
'     m.busyspinner.visible = false
'     m.videosList.setFocus(true)

' end sub

sub showSubPopup()
    if m.top.isTrialExpired

        m.top.setFocus(false)
        m.AppLockPopup.focusBitmapUri = "pkg:/images/subExpPopup.png"

        m.AppLockPopup.visible = true
        m.AppLockPopup.setFocus(true)
        m.scene.video.control = "pause"

        m.top.isTrialExpired = false

    end if

end sub

sub onbtnCat1Select()
    resetButtonsUri()
    m.btnCat1.focusfootprintbitmapuri = "pkg:/images/btnCat1S.png"

    SetVideoListContent(0)

end sub

sub onbtnCat2Select()
    resetButtonsUri()
    m.btnCat2.focusfootprintbitmapuri = "pkg:/images/btnCat2S.png"

    SetVideoListContent(1)


end sub
sub onbtnCat3Select()
    resetButtonsUri()
    m.btnCat3.focusfootprintbitmapuri = "pkg:/images/btnCat3S.png"

    SetVideoListContent(2)

end sub

sub onbtnCat4Select()
    resetButtonsUri()
    m.btnCat4.focusfootprintbitmapuri = "pkg:/images/btnCat4S.png"

    SetVideoListContent(3)

end sub

sub onbtnCat5Select()
    resetButtonsUri()
    m.btnCat5.focusfootprintbitmapuri = "pkg:/images/btnCat5S.png"

    SetVideoListContent(4)

end sub

sub onbtnCat6Select()
    resetButtonsUri()
    m.btnCat6.focusfootprintbitmapuri = "pkg:/images/btnCat6S.png"

    SetVideoListContent(5)

end sub

sub onbtnCat7Select()
    resetButtonsUri()
    m.btnCat7.focusfootprintbitmapuri = "pkg:/images/btnCat7S.png"

    SetVideoListContent(6)

end sub

sub createDots(count as integer)
    m.dots = []

    for i = 0 to count - 1
        dot = CreateObject("roSGNode", "Poster")
        dot.width = 16
        dot.height = 16
        dot.uri = "pkg:/images/DotUF.png"
        m.dotContainer.appendChild(dot)
        m.dots.push(dot)
    end for

    highlightDot(0)
end sub


sub highlightDot(index as integer)
    for i = 0 to m.dots.count() - 1
        if i = index
            m.dots[i].uri = "pkg:/images/DotF.png"
        else
            m.dots[i].uri = "pkg:/images/DotUF.png"
        end if
    end for
end sub


sub onVisibleChange()
    if m.top.visible
        m.scene.screenName = "Home"

        navBarInit("Home")

        m.scene.currentCategory = m.currentCategory
        RefreshContinueWatchingUI()
        updateHeroNowPlaying()

        restoreHomeListFocus()
        'revertButtons()
        if m.AppLockPopup.visible
            m.top.setFocus(false)
            m.AppLockPopup.setFocus(true)
        end if
    else
        m.global.videoContent = m.videosList.content

    end if

end sub

sub saveHomeListFocus(index as object)
    if index = invalid then return
    m.savedListFocus = index
end sub

sub restoreHomeListFocus()
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

sub onVideoState()
    if m.scene.video.state = "finished"
        if m.currentVideoNode <> invalid
            RemoveContinueWatching(m.currentVideoNode.videoUrl)
        end if
    else if m.scene.video.state = "paused"
        watchNode = m.currentVideoNode
        if watchNode = invalid
            watchNode = m.global.nowPlayingTrack
        end if
        if watchNode <> invalid
            SaveContinueWatching(watchNode, m.scene.video.position, m.scene.video.duration)
        end if
    end if

    updateHeroPlayPauseIcon()
end sub

sub onNowPlayingTrackChange()
    updateHeroNowPlaying()
end sub

function GetTrackPlaybackUrl(track as object) as string
    if track = invalid then return ""

    if track.videoUrl <> invalid and track.videoUrl <> ""
        return track.videoUrl
    end if

    if track.streamUrl <> invalid and track.streamUrl <> ""
        return track.streamUrl
    end if

    return ""
end function

sub updateHeroNowPlaying()
    if m.nowPlayingGroup = invalid then return

    track = m.global.nowPlayingTrack
    playbackUrl = GetTrackPlaybackUrl(track)
    if track = invalid or playbackUrl = ""
        m.nowPlayingGroup.visible = false
        return
    end if

    m.nowPlayingGroup.visible = true

    if track.videoTitle <> invalid
        m.npTitle.text = track.videoTitle
    else
        m.npTitle.text = ""
    end if

    artist = ""
    if track.creator <> invalid and track.creator <> ""
        artist = track.creator
    else if track.subtitle <> invalid and track.subtitle <> ""
        artist = track.subtitle
    end if
    m.npArtist.text = artist

    thumbUri = "pkg:/images/GI.png"
    heroUri = GetHeroImageUri(track)
    if heroUri <> ""
        thumbUri = heroUri
    end if
    m.npThumb.uri = thumbUri

    updateHeroPlayPauseIcon()
end sub

sub updateAddToFavInstruction(item = invalid as object)
    if m.addToFavInstruction = invalid then return

    heroItem = item
    if heroItem = invalid
        heroItem = m.videoIndex
    end if

    if heroItem = invalid
        m.addToFavInstruction.visible = true
        return
    end if

    favUrl = GetTrackPlaybackUrl(heroItem)
    if favUrl <> "" and IsFavorite(favUrl)
        m.addToFavInstruction.visible = false
    else
        m.addToFavInstruction.visible = true
    end if
end sub

function IsFavorite(videoUrl as string) as boolean
    if videoUrl = invalid or videoUrl = "" then return false

    section = CreateObject("roRegistrySection", "FaveReg")
    if not section.Exists("entries") then return false

    storedJson = section.Read("entries")
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

sub updateHeroPlayPauseIcon()
    if m.scene = invalid or m.scene.video = invalid then return
    if m.scene.video.state="playing"
m.top.findNode("heroPlayPause").uri="pkg:/images/btnPause.png"
    else
m.top.findNode("heroPlayPause").uri="pkg:/images/btnPlay.png"
    end if

 
end sub

sub onHeroPlayPauseSelect()
    m.btnHeroPlayPause.buttonSelected = false

    if m.scene = invalid or m.scene.video = invalid then return

    if m.scene.video.state = "playing"
        m.scene.video.control = "pause"
    else
        if m.global.duration >= m.global.videoDurationLimit and m.scene.isSubscribed = false
            showAppLockPopup()
            return
        end if

        if m.scene.video.content = invalid
            resumeHeroPlayback()
        else if m.scene.video.state = "paused"
            m.scene.video.control = "resume"
        else
            m.scene.video.control = "play"
        end if
    end if

    updateHeroPlayPauseIcon()
end sub

sub resumeHeroPlayback()
    track = m.global.nowPlayingTrack
    playbackUrl = GetTrackPlaybackUrl(track)
    if playbackUrl = "" then return

    videoContent = CreateObject("roSGNode", "ContentNode")
    videoContent.url = playbackUrl
    videoContent.title = track.videoTitle
    videoContent.streamFormat = "mp3"

    m.scene.video.visible = true
    m.scene.video.content = videoContent
    m.scene.video.control = "play"
end sub

sub ShowAddToFavoritesHintDialog()
    regSection = "AppPrefs"
    regKey = "hideFavoritesHint"

    reg = CreateObject("roRegistrySection", regSection)
    regValue = reg.Read(regKey)

    if regValue = "true"
        return
    end if

    dialog = CreateObject("roSGNode", "StandardMessageDialog")
    dialog.title = "Add to Favorites"
    dialog.message = ["Press * on the remote to add videos to your favorites."]
    dialog.buttons = ["OK", "Don't Show Again"]
    dialog.observeField("buttonSelected", "OnFavoritesHintDialogClosed")

    m.scene.dialog = dialog
end sub

sub OnFavoritesHintDialogClosed()
    idx = m.scene.dialog.buttonSelected

    if idx = 1 ' "Don't Show Again"
        reg = CreateObject("roRegistrySection", "AppPrefs")
        reg.Write("hideFavoritesHint", "true")
        reg.Flush()
    end if

    ' Dismiss dialog
    m.scene.dialog = invalid
end sub


sub onvideoFocus(evt)
    m.isPrevHero = false

    index = evt.getData()
    saveHomeListFocus(index)
    row = index[0]
    col = index[1]
    if row > 0


    end if
    m.col = col
    if row>4
        m.videosList.vertFocusAnimationStyle="fixedfocuswrap"
    else
    m.videosList.vertFocusAnimationStyle="fixedfocus"

    end if

      if m.col>15
        m.videosList.rowFocusAnimationStyle="fixedfocuswrap"
    else
    m.videosList.rowFocusAnimationStyle="fixedfocus"

    end if


    m.videoIndex = m.videosList.content.getChild(row).getChild(col)
    m.columnCount = m.videosList.content.getChild(0).GetChildCount() - 1
    if m.videoIndex.videoThumbnail <> "pkg:/images/VAPH.png"
        updateHeroFromItem(m.videoIndex)
    else
        updateAddToFavInstruction()
    end if

    ' m.ChangeImageTimer.control="stop"


end sub

sub onwatchvideoFocus(evt)
    m.isPrevHero = false

    index = evt.getData()
    row = index[0]
    col = index[1]

    m.col = col

    ' if col<3
    '     m.videosList.rowFocusAnimationStyle="floatingFocus"
    ' else
    '     m.videosList.rowFocusAnimationStyle="fixedFocus"

    ' end if
    m.videoIndex = m.videosList.content.getChild(row).getChild(col)
    m.columnCount = m.videosList.content.getChild(0).GetChildCount() - 1
    if m.videoIndex.videoThumbnail <> "pkg:/images/VAPH.png"
        updateHeroFromItem(m.videoIndex)
    else
        updateAddToFavInstruction()
    end if
    ' m.ChangeImageTimer.control="stop"


end sub

sub AddToRecents(videoInfo as object)
    if videoInfo = invalid or videoInfo.videoTitle = invalid or videoInfo.videoThumbnail = "pkg:/images/VAPH.png"
        print "Invalid video info object."
        return
    end if

    sec = CreateObject("roRegistrySection", "RecentRegCalmApp")
    key = "Recents"


    ' Load existing recents
    recents = []
    if sec.Exists(key)
        stored = sec.Read(key)
        if stored <> ""
            recents = ParseJson(stored)
        end if
    end if

    ' Deduplicate by id
    dedup = []
    for each item in recents
        if item.videoTitle <> videoInfo.videoTitle
            dedup.Push(item)
        end if
    end for

    ' Prepend the latest video (no Unshift in BRS)
    newItem = {
        videoTitle: videoInfo.videoTitle,
        videoUrl: videoInfo.videoUrl,
        videoThumbnail: videoInfo.videoThumbnail
    }

    finalRecents = []
    finalRecents.Push(newItem)
    for each item in dedup
        finalRecents.Push(item)
    end for

    ' Trim to max N (no slicing in BRS)
    maxCount = 20
    if finalRecents.Count() > maxCount
        trimmed = []
        i = 0
        for each item in finalRecents
            if i >= maxCount then exit for
            trimmed.Push(item)
            i = i + 1
        end for
        finalRecents = trimmed
    end if

    ' Save
    sec.Write(key, FormatJson(finalRecents))
    sec.Flush()

    print "Added to Recents: " + videoInfo.videoTitle
end sub

sub onvideoSelect(evt)
    m.isVideoResume = false
    m.isPrevHero = false

    index = evt.getData()
    saveHomeListFocus(index)
    parentNode = CreateObject("roSGNode", "ContentNode")
    selectedRow = m.videosList.content.getChild(index[0])

    if selectedRow <> invalid
        for each item in selectedRow.getChildren(-1, 0)
            parentNode.AppendChild(item.Clone(true))
        end for
    end if

    m.videoIndex = m.videosList.content.getChild(index[0]).getChild(index[1])
    m.currentVideoNode = m.videoIndex

    if ShouldOpenPlaylistDetail(m.videoIndex)
        m.scene.callFunc("ShowPlaylistDetailScreen", {
            playlistInfo: BuildPlaylistInfo(m.videoIndex)
        })
        return
    end if

    if m.videoIndex.sectionId = "continueWatching" or m.videoIndex.sectionLayout = "continue"
        m.isVideoResume = true
        AddToRecents(m.videoIndex)
        if m.global.duration < m.global.videoDurationLimit or m.scene.isSubscribed
            resumePos = 0
            if m.videoIndex.resumePosition <> invalid
                resumePos = m.videoIndex.resumePosition
            end if
            m.scene.callFunc("ShowMusicScreen", {
                selectedTrack: m.videoIndex
                relatedContent: parentNode
                resumePosition: resumePos
                isVideoResume: true
                saveContinueWatching: true
            })
        else
            showAppLockPopup()
        end if
        return
    end if

    AddToRecents(m.videoIndex)

    if m.global.duration < m.global.videoDurationLimit or m.scene.isSubscribed
        if m.videoIndex.type = "Free" or m.scene.isSubscribed
            m.scene.callFunc("ShowMusicScreen", {
                selectedTrack: m.videoIndex
                relatedContent: parentNode
            })
        else
            showAppLockPopup()
        end if
    else
        ShowApplockPopup()
    end if
end sub

sub onWatchVideoSelect(evt)
    m.isVideoResume = true

    index = evt.getData()
    m.colIndex = index[1]
    m.videoIndex = m.watchList.content.getChild(index[0]).getChild(index[1])
    m.currentVideoNode = m.videoIndex
    parentNode = CreateObject("roSGNode", "ContentNode")
    selectedRow = m.watchList.content.getChild(index[0])

    if selectedRow <> invalid
        for each item in selectedRow.getChildren(-1, 0)
            parentNode.AppendChild(item.Clone(true))
        end for
    end if

    AddToRecents(m.videoIndex)
    if m.global.duration < m.global.videoDurationLimit or m.scene.isSubscribed
        resumePos = 0
        if m.videoIndex.resumePosition <> invalid
            resumePos = m.videoIndex.resumePosition
        end if
        m.scene.callFunc("ShowMusicScreen", {
            selectedTrack: m.videoIndex
            relatedContent: parentNode
            resumePosition: resumePos
            isVideoResume: true
            saveContinueWatching: true
        })
    else
        showAppLockPopup()
    end if
end sub

function isAtZeroZero(value as dynamic, arr as object) as boolean
    if arr.Count() > 0 and arr[0].Count() > 0
        return arr[0][0] = value
    end if
    return false
end function



sub onHeroFocus(evt)

    index = evt.getData()
    row = index

    m.videoIndex = m.videosGrid.content.getChild(row)

    ' m.ChangeImageTimer.control="stop"


end sub
sub changeImage()
    if m.col = m.columnCount
        m.col = 0

    else
        m.col = m.col + 1

    end if

    ' m.imagesList.jumpToRowItem=[m.row,m.col]
    m.heroList.jumpToRowItem = [0, m.col]

end sub

sub onHeroSelect(evt)


    index = evt.getData()
    m.videoIndex = m.videosGrid.content.getChild(index)
    m.videoContent = CreateObject("rosgNode", "ContentNode")
    m.videoContent.url = m.videoIndex.videoUrl
    m.videoContent.title = m.videoIndex.videoTitle
    AddToRecents(m.videoIndex)

    m.videoContent.streamFormat = "hls"
    if (m.global.duration >= m.global.videoDurationLimit or m.videoIndex.type = "Paid") and m.scene.isSubscribed = false
        showAppLockPopup()


    else
        if instr(0, m.videoIndex.videoUrl, ".mp3")
            m.videoContent.streamFormat = "mp3"
            m.global.nowPlayingTrack = m.videoIndex
            m.scene.video.content = m.videoContent
            m.scene.video.visible = true
            m.scene.video.control = "play"
            updateHeroNowPlaying()
            m.scene.video.setFocus(true)
            ?"In mp3 url"m.videoContent

        else

            m.fixTask = CreateObject("roSGNode", "FixM3U8Task")
            m.fixTask.url = m.videoIndex.videoUrl ' your original .m3u8 URL
            m.fixTask.ObserveField("fixedUrl", "onM3U8Fixed")
            m.fixTask.control = "run"
        end if

    end if





end sub

sub ShowApplockPopup()

    m.scene.video.control = "stop"
    m.scene.video.visible = false
    m.AppLockPopup.focusBitmapUri = "pkg:/images/subExpPopup.png"

    m.top.setFocus(false)
    m.AppLockPopup.visible = true
    m.AppLockPopup.setFocus(true)

end sub

sub onSubSuccess()
    if m.top.isSubSuccess
        m.scene.isSubscribed = true
        m.exitPopup.visible = false
        m.btnClaim.setFocus(false)
        m.scene.appExit = true



    end if

end sub

sub onM3U8Fixed()
    fixedUrl = m.fixTask.fixedUrl
    if fixedUrl <> invalid
        m.videoContent.url = fixedUrl
        ' m.scene.video.content = m.videoContent
        m.scene.video.content = m.videoContent
        m.scene.video.visible = true
        m.scene.video.control = "play"
        'm.videoDurationTimer.control = "start"
        m.scene.video.setFocus(true)

    end if
end sub

' sub SetContent()
'     m.VideosArray = m.VideoArrayGetter.content
'     m.global.videoArray=m.videosArray
'     ?"VideoArray"m.VideoArrayGetter.content
'     keyArray=m.VideoArrayGetter.content.keys()
'     ?"Key Array"keyArray

'     heroData=m.videosArray[keyArray[0]]
'     heroArray = SubArr(heroData, 0, 5)
'     viewAll={"videoThumbnailURL":"pkg:/images/VAPH.png","VideoURL":"","VideoTitle":""}
'     heroArray.push(viewAll)



'     videoGridContentvideos = CreateObject("rosgNode", "ContentNode")


'     videoGridContentHero = CreateObject("rosgNode", "ContentNode")
'     childNode = CreateObject("rosgNode", "ContentNode")

'     i=0
'     for each video in heroArray
'         childContent = childNode.createChild("RowItemData")
'         childContent.videoTitle = video.VideoTitle
'         childContent.videoUrl = video.VideoURL
'         childContent.videoThumbnail = video.VideoThumbnailURL
'         if i<5
'                 childContent.type="Free"
'             else
'                 childContent.type="Paid"

'             end if
'             i+=1


'     end for
'     videoGridContentHero.appendChild(childNode)

'     m.videosList.content = videoGridContentHero
'     m.videosList.setFocus(true)



' end sub

' sub SetContent()

'     m.videosArray = m.VideoArrayGetter.content
'     ?"m.scene.video.array type "type(m.videosArray)
'     m.global.videoArray = m.videosArray

'     videoGridContent = CreateObject("roSGNode", "ContentNode")

'     ' Loop through all main categories (BetterSleep, Calm, etc.)
'     rows = []
'     for each mainCategory in m.videosArray

'         categoryData = m.videosArray[mainCategory]

'         for each subCategory in categoryData

'             rows.Push({
'                 title: subCategory
'                 videos: categoryData[subCategory]
'             })

'         end for

'     end for

'     dt = CreateObject("roDateTime")
'     offset = dt.AsSeconds() mod rows.Count()

'     rotatedRows = []

'     for i = 0 to rows.Count() - 1
'         index = (i + offset) mod rows.Count()
'         rotatedRows.Push(rows[index])
'     end for

'     rows = rotatedRows
'     for each rowData in rows
'         ? rowData.title
'     end for
'     for each mainCategory in m.videosArray

'         categoryData = m.videosArray[mainCategory]

'         ' Loop through all subcategories
'         for each subCategory in categoryData

'             rowArray = categoryData[subCategory]

'             if Type(rowArray) <> "roArray"
'                 goto ContinueLoop
'             end if

'             ' Create row
'             rowNode = CreateObject("roSGNode", "ContentNode")
'             rowNode.title = subCategory

'             i = 0

'             ' Add videos to row
'             for each video in rowArray

'                 item = rowNode.CreateChild("RowItemData")

'                 item.videoTitle = video.title
'                 item.videoUrl = video.mp3_url
'                 item.videoThumbnail = video.thumbnail

'                 if m.scene.isSubscribed
'                     item.type = "Free"
'                 else
'                     ' if i < 5
'                     item.type = "Free"
'                     ' else
'                     '     item.type = "Paid"
'                     ' end if
'                 end if

'                 i = i + 1

'             end for

'             videoGridContent.AppendChild(rowNode)

'             ContinueLoop:
'         end for

'     end for

'     m.videosList.content = videoGridContent
'     m.videosList.setFocus(true)

' end sub

sub RefreshContinueWatchingUI()
    if m.videosList = invalid then return

    rootContent = m.videosList.content
    videos = GetContinueWatchingVideos()
    SortVideosByLastWatched(videos)

    continueRowIndex = FindContinueWatchingRowIndex(rootContent)

    if videos.Count() = 0
        if continueRowIndex >= 0 and rootContent <> invalid
            rootContent.RemoveChildIndex(continueRowIndex)
            RebuildVideosListRowLayouts(rootContent)
            m.videosList.content = invalid
            m.videosList.content = rootContent
        end if
        m.videosList.translation = [161, 610]
        return
    end if

    subscribed = m.scene <> invalid and m.scene.isSubscribed = true
    continueRow = BuildContinueWatchingRowFromVideos(videos, subscribed)
    if continueRow = invalid then return

    if rootContent = invalid
        return
    end if

    if continueRowIndex >= 0
        rootContent.RemoveChildIndex(continueRowIndex)
        rootContent.InsertChild(continueRow, continueRowIndex)
    else
        insertIndex = GetContinueWatchingRowInsertIndex(rootContent)
        rootContent.InsertChild(continueRow, insertIndex)
    end if

    RebuildVideosListRowLayouts(rootContent)
    m.videosList.content = invalid
    m.videosList.content = rootContent
    m.videosList.translation = [161, 610]
end sub

sub SortVideosByLastWatched(videos as object)

    count = videos.Count()

    for i = 0 to count - 2
        for j = 0 to count - i - 2

            currentTime = videos[j].lastWatched
            nextTime = videos[j + 1].lastWatched

            ' Descending order (newest first)
            if currentTime < nextTime

                temp = videos[j]
                videos[j] = videos[j + 1]
                videos[j + 1] = temp

            end if
        end for
    end for

end sub
sub SetContent()
    m.videosArray = m.VideoArrayGetter.content
    m.global.videoArray = m.videosArray
    BuildRows()
    StartGenreCatalogLoad()
end sub

sub StartGenreCatalogLoad()
    if m.GenreCatalogGetter <> invalid then return

    m.GenreCatalogGetter = CreateObject("roSGNode", "GetGenreCatalogTask")
    m.GenreCatalogGetter.ObserveField("content", "OnGenreCatalogLoaded")
    m.GenreCatalogGetter.control = "RUN"
end sub

sub OnGenreCatalogLoaded()
    catalog = m.GenreCatalogGetter.content
    if catalog = invalid then return

    for each genreName in catalog
        m.global.videoArray[genreName] = catalog[genreName]
    end for
end sub

function FetchMoodPlaylistTrack(moodName as string) as object
    if moodName = invalid or moodName = "" then return invalid

    transfer = CreateObject("roUrlTransfer")
    transfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    transfer.InitClientCertificates()
    transfer.SetUrl("http://185.194.218.34:3001/api/playlists/mood?mood=" + transfer.Escape(moodName))
    transfer.SetMinimumTransferRate(1, 12)

    port = CreateObject("roMessagePort")
    transfer.SetMessagePort(port)

    if not transfer.AsyncGetToString()
        return invalid
    end if

    timer = CreateObject("roTimespan")
    timer.Mark()

    while true
        msg = wait(250, port)
        if type(msg) = "roUrlEvent"
            if msg.GetResponseCode() <> 200 then return invalid

            json = ParseJson(msg.GetString())
            if json = invalid then return invalid

            items = invalid
            if Type(json) = "roArray"
                items = json
            else if json.results <> invalid
                items = json.results
            else if json.items <> invalid
                items = json.items
            end if

            if items = invalid or items.Count() = 0 then return invalid

            playlist = items[0]
            if playlist = invalid then return invalid

            if playlist.tracks <> invalid and Type(playlist.tracks) = "roArray" and playlist.tracks.Count() > 0
                return playlist.tracks[0]
            end if

            return playlist
        else if timer.TotalMilliseconds() > 15000
            transfer.AsyncCancel()
            return invalid
        end if
    end while

    return invalid
end function

function ShouldOpenPlaylistDetail(item as object) as boolean
    if item = invalid then return false
    if item.sectionId = "moodPlaylists" then return true
    if item.itemType = "playlist" then return true
    if item.sectionLayout = "album" then return true
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

sub RemoveContinueWatching(videoId as string)
    sec = CreateObject("roRegistrySection", "ContinueWatching")
    sec.Delete(videoId)
    sec.Flush()
    RefreshContinueWatchingUI()
end sub

function GetContinueWatchingVideos() as object

    sec = CreateObject("roRegistrySection", "ContinueWatching")

    result = []

    for each key in sec.GetKeyList()

        jsonText = sec.Read(key)

        if jsonText <> invalid and jsonText <> ""

            item = ParseJson(jsonText)

            if item <> invalid
                result.Push(item)
            end if

        end if

    end for

    return result

end function



sub SaveContinueWatching(videoNode as object, position as float, duration as float)
    sec = CreateObject("roRegistrySection", "ContinueWatching")
    dt = CreateObject("roDateTime")
    dt.Mark()

    timestamp = dt.AsSeconds()
    ? timestamp
    data = { videoId: videoNode.videoUrl
        videoTitle: videoNode.videoTitle
        videoUrl: videoNode.videoUrl
        videoThumbnail: videoNode.videoThumbnail
        type: videoNode.type
        resumePosition: position
        duration: duration
        audioDuration: videoNode.audioDuration
        creator: videoNode.creator
    lastWatched: timestamp }
    sec.Write(data.videoId, FormatJson(data))
    sec.Flush()
    RefreshContinueWatchingUI()
end sub

sub setSpecificContent(rowTitle as string)

    m.videosArray = m.VideoArrayGetter.content
    m.global.videoArray = m.videosArray

    ' Validate category exists
    if not m.videosArray.DoesExist(rowTitle) then
        ?"Category not found:" rowTitle
        return
    end if

    heroData = m.videosArray[rowTitle]

    heroArray = SubArr(heroData, 0, heroData.Count() - 1)
    ' heroArray = ShuffleArray(heroArray)

    childNode = CreateObject("roSGNode", "ContentNode")

    i = 0
    for each video in heroArray
        childContent = CreateObject("roSGNode", "RowItemData")
        childContent.videoTitle = video.VideoTitle
        childContent.videoUrl = video.VideoURL
        childContent.videoThumbnail = video.VideoThumbnailURL
        if m.scene.isSubscribed
            childContent.type = "Free"
        else
            ' if i < 5
            childContent.type = "Free"
            ' else
            '     childContent.type = "Paid"
            ' end if
        end if

        childNode.appendChild(childContent)
        i++
    end for

    m.videosGrid.content = childNode
    m.videosGrid.setFocus(true)

end sub

sub SetVideoListContent(idx)
    m.currentRow = idx
    ?"current Row"m.currentRow
    if m.videosGroup.translation[0] = 0 and m.videosGroup.translation[1] <> -460
        ?"in setVideo if"idx
        m.VideosArray = m.VideoArrayGetter.content
        m.global.videoArray = m.videosArray
        keyArray = m.VideoArrayGetter.content.keys()
        heroData = m.videosArray[keyArray[idx]]
        ?"Count" heroData.Count()
        heroArray = SubArr(heroData, 0, 4)
        viewAll = { "videoThumbnailURL": "pkg:/images/VAPH.png", "VideoURL": "", "VideoTitle": "" }
        heroArray.push(viewAll)
        videoGridContentHero = CreateObject("rosgNode", "ContentNode")
        childNode = CreateObject("rosgNode", "ContentNode")


        for each video in heroArray
            childContent = childNode.createChild("RowItemData")
            childContent.videoTitle = video.VideoTitle
            childContent.videoUrl = video.VideoURL
            childContent.videoThumbnail = video.VideoThumbnailURL


        end for
        videoGridContentHero.appendChild(childNode)

        m.videosList.content = videoGridContentHero
        m.videosList.setFocus(true)
        m.videosList.jumpToRowItem = [0, 0]


    else
        ?"in setVideo else"idx

        setSpecificContent(idx)

    end if



end sub

function SubArr(arr as object, startIndex as integer, endIndex) as object
    subArray = []

    if endIndex = invalid ' If endIndex is not provided
        endIndex = arr.count() ' Default to the length of the array
    end if

    for i = startIndex to endIndex - 1
        subArray.push(arr[i])
    end for

    return subArray
end function

sub revertButtons()
    m.blurOL.visible = false



    m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoF.png"
    m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoF.png"
    m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaUF.png"
    m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaF.png"
    m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavUF.png"
    m.btnFavN.focusBitmapUri = "pkg:/images/btnfavF.png"
    m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubUF.png"
    m.btnSubN.focusBitmapUri = "pkg:/images/btnSubF.png"
    m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSUF.png"
    m.btnSettingN.focusBitmapUri = "pkg:/images/btnBSF.png"

end sub



function OnKeyEvent(key as string, press as boolean) as boolean
    result = false
    if press


        if key = "left" and (m.videosList.hasFocus() or m.btnCat1.hasFocus() or m.videosGrid.hasFocus())



            m.videosList.setFocus(false)
            m.heroList.setFocus(false)
            m.blurOL.visible = true


            m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoEF.png"
            m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaEUF.png"
            m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaEF.png"
            m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavEUF.png"
            m.btnFavN.focusBitmapUri = "pkg:/images/btnfavEF.png"
            m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubEUF.png"
            m.btnSubN.focusBitmapUri = "pkg:/images/btnSubEF.png"
            m.btnSettingN.focusBitmapUri = "pkg:/images/btnBSEF.png"

            m.btnHomeN.focusfootprintbitmapUri = "pkg:/images/btnHoS.png"

            ' navBarFocusSet()
            m.btnHomeN.setFocus(true)
            return true
        else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus() or m.btnRSN.hasFocus() or m.btnFFN.hasFocus() or m.btnARN.hasFocus() or m.btnMEN.hasFocus() or m.btnBWN.hasFocus())
            ' navBarFocus()
            m.top.setFocus(false)
            'revertButtons()


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
        ' else if key = "down" and m.btnSettingN.hasFocus()
        '     m.btnSettingN.setFocus(false)
        '     m.btnRSN.setFocus(true)
        '     return true
        else if key = "down" and m.btnRSN.hasFocus()
            m.btnRSN.setFocus(false)
            m.btnFFN.setFocus(true)
            return true
        else if key = "down" and m.btnFFN.hasFocus()
            m.btnFFN.setFocus(false)
            m.btnARN.setFocus(true)
            return true
        else if key = "down" and m.btnARN.hasFocus()
            m.btnARN.setFocus(false)
            m.btnMEN.setFocus(true)
            return true
        else if key = "down" and m.btnMEN.hasFocus()
            m.btnMEN.setFocus(false)
            m.btnBWN.setFocus(true)
            return true
        else if key = "down" and m.btnSearchN.hasFocus()
            m.btnSearchN.setFocus(false)
            m.btnHomeN.setFocus(true)
            return true

        else if key = "up" and m.btnBWN.hasFocus()
            m.btnBWN.setFocus(false)
            m.btnMEN.setFocus(true)
            return true
        else if key = "up" and m.btnMEN.hasFocus()
            m.btnMEN.setFocus(false)
            m.btnARN.setFocus(true)
            return true
        else if key = "up" and m.btnARN.hasFocus()
            m.btnARN.setFocus(false)
            m.btnFFN.setFocus(true)
            return true
        else if key = "up" and m.btnFFN.hasFocus()
            m.btnFFN.setFocus(false)
            m.btnRSN.setFocus(true)
            return true
        else if key = "up" and m.btnRSN.hasFocus()
            m.btnRSN.setFocus(false)
            m.btnSettingN.setFocus(true)
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
        else if key = "back" and m.AppLockPopup.hasFocus()
            m.AppLockPopup.visible = false
            m.AppLockPopup.setFocus(false)
            if m.videosGrid.visible
                m.videosGrid.setFocus(true)
            else
                m.videosList.setFocus(true)
            end if
            return true
        else if key = "options" and m.videosList.hasFocus()
            AddToFaves(m.videoIndex)
            return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=1
            '     m.videosList.setFocus(false)
            '     m.btnCat2.setFocus(true)

            '     return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=2
            '     m.videosList.setFocus(false)
            '     m.btnCat3.setFocus(true)

            '     return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=3
            '     m.videosList.setFocus(false)
            '     m.btnCat4.setFocus(true)

            '     return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=4
            '     m.videosList.setFocus(false)
            '     m.btnCat5.setFocus(true)

            '     return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=5
            '     m.videosList.setFocus(false)
            '     m.btnCat6.setFocus(true)

            '     return true
            '       else if key="up" and m.videosList.hasFocus() and m.currentRow=6
            '     m.videosList.setFocus(false)
            '     m.btnCat7.setFocus(true)

            '     return true
            '     else if key="up" and m.videosGrid.hasFocus() and m.currentRow=0
            '     m.videosGrid.setFocus(false)
            '     m.btnCat1.setFocus(true)

            '     return true
            '     else if key="up" and m.videosGrid.hasFocus() and m.currentRow=1
            '     m.videosGrid.setFocus(false)
            '     m.btnCat2.setFocus(true)

            '     return true
            '     else if key="up" and m.videosGrid.hasFocus() and m.currentRow=2
            '     m.videosGrid.setFocus(false)
            '     m.btnCat3.setFocus(true)

            '     return true
            '     else if key="up" and m.videosGrid.hasFocus() and m.currentRow=3
            '     m.videosGrid.setFocus(false)
            '     m.btnCat4.setFocus(true)

            '     return true
            '     else if key="up" and m.videosGrid.hasFocus() and m.currentRow=4
            '     m.videosGrid.setFocus(false)
            '     m.btnCat5.setFocus(true)

            '     return true
            '         else if key="up" and m.videosGrid.hasFocus() and m.currentRow=5
            '     m.videosGrid.setFocus(false)
            '     m.btnCat6.setFocus(true)

            '     return true
            '      else if key="up" and m.videosGrid.hasFocus() and m.currentRow=6
            '     m.videosGrid.setFocus(false)
            '     m.btnCat7.setFocus(true)

            '     return true
        else if key = "right" and m.btnCat1.hasFocus()
            m.btnCat1.setFocus(false)
            m.btnCat2.setFocus(true)

            return true
        else if key = "right" and m.btnCat2.hasFocus()
            m.btnCat2.setFocus(false)
            m.btnCat3.setFocus(true)

            return true
        else if key = "right" and m.btnCat3.hasFocus()
            m.btnCat3.setFocus(false)
            m.btnCat4.setFocus(true)

            return true
        else if key = "right" and m.btnCat4.hasFocus()
            m.btnCat4.setFocus(false)
            m.btnCat5.setFocus(true)

            return true
        else if key = "right" and m.btnCat5.hasFocus()
            m.btnCat5.setFocus(false)
            m.btnCat6.setFocus(true)

            return true
        else if key = "right" and m.btnCat6.hasFocus()
            m.btnCat6.setFocus(false)
            m.btnCat7.setFocus(true)

            return true
        else if key = "left" and m.btnCat2.hasFocus()
            m.btnCat2.setFocus(false)
            m.btnCat1.setFocus(true)

            return true

        else if key = "left" and m.btnCat3.hasFocus()
            m.btnCat3.setFocus(false)
            m.btnCat2.setFocus(true)

            return true
        else if key = "left" and m.btnCat4.hasFocus()
            m.btnCat4.setFocus(false)
            m.btnCat3.setFocus(true)

            return true
        else if key = "left" and m.btnCat5.hasFocus()
            m.btnCat5.setFocus(false)
            m.btnCat4.setFocus(true)

            return true
        else if key = "left" and m.btnCat6.hasFocus()
            m.btnCat6.setFocus(false)
            m.btnCat5.setFocus(true)

            return true
        else if key = "left" and m.btnCat7.hasFocus()
            m.btnCat7.setFocus(false)
            m.btnCat6.setFocus(true)

            return true
        else if key = "right" and m.btnExit.hasFocus()
            m.btnExit.setFocus(false)
            m.btnClaim.setFocus(true)

            return true
        else if key = "left" and m.btnClaim.hasFocus()
            m.btnClaim.setFocus(false)
            m.btnExit.setFocus(true)

            return true
        else if key = "up" and m.videosList.hasFocus() and m.nowPlayingGroup <> invalid and m.nowPlayingGroup.visible
            rowIndex = m.videosList.rowItemFocused
            if rowIndex <> invalid and rowIndex[0] = 0
                m.btnHeroPlayPause.setFocus(true)
                return true
            end if
        else if key = "down" and m.btnHeroPlayPause.hasFocus()
            m.btnHeroPlayPause.setFocus(false)
            m.videosList.setFocus(true)
            return true
        else if key = "down" and (m.btnCat1.hasFocus() or m.btnCat2.hasFocus() or m.btnCat3.hasFocus() or m.btnCat4.hasFocus() or m.btnCat5.hasFocus() or m.btnCat6.hasFocus()or m.btnCat7.hasFocus()) and m.videosList.visible
            m.btnCat1.setFocus(false)
            m.btnCat2.setFocus(false)
            m.btnCat3.setFocus(false)
            m.btnCat4.setFocus(false)
            m.btnCat5.setFocus(false)
            m.btnCat6.setFocus(false)
            m.btnCat7.setFocus(false)

            m.videosList.setFocus(true)
            return true

        else if key = "down" and (m.btnCat1.hasFocus() or m.btnCat2.hasFocus() or m.btnCat3.hasFocus() or m.btnCat4.hasFocus() or m.btnCat5.hasFocus() or m.btnCat6.hasFocus() or m.btnCat7.hasFocus()) and m.videosGrid.visible
            m.btnCat1.setFocus(false)
            m.btnCat2.setFocus(false)
            m.btnCat3.setFocus(false)
            m.btnCat4.setFocus(false)
            m.btnCat5.setFocus(false)
            m.btnCat6.setFocus(false)
            m.btnCat7.setFocus(false)
            m.videosGrid.setFocus(true)
            return true

            '   else if key="down" and m.heroList.hasFocus()
            '     m.heroList.setFocus(false)
            '     m.videosList.setFocus(true)
            '     m.dotGroup.visible=false
            '     m.heroupAnim.control = "start"
            ' m.videosupAnim.control = "start"
            '     return true


            ' result = true
        else if key = "back" and m.exitPopup.visible = false and m.scene.isSubscribed = false and (m.scene.currentCategory = "All" or m.scene.currentCategory = "")
            'create the dialog
            m.exitPopup.visible = true
            m.btnClaim.setFocus(true)
            return true
        else if key = "back" and m.scene.isSubscribed and (m.scene.currentCategory = "All" or m.scene.currentCategory = "")
            dialog = createObject("roSGNode", "StandardMessageDialog")
            '.message is an array of messages
            dialog.title = "Are You Sure?"
            dialog.message = ["Do you really want to exit?"]
            dialog.buttons = ["Yes", "No"]
            'register a callback function for when a user clicks a button
            dialog.observeFieldScoped("buttonSelected", "onDialogButtonClicked")

            'assigning the dialog to m.scene.dialog will "show" the dialog
            m.scene.dialog = dialog
            return true
        else if key = "back" and m.exitPopup.visible
            m.exitPopup.visible = false
            m.top.setFocus(false)
            m.videosList.setFocus(true)

            return true


        end if


    end if
end function

sub setFocusOnVideoList()

    '  SetVideoListContent(m.currentRow)
    m.videosList.setFocus(true)

end sub


function onDialogButtonClicked(event)
    buttonIndex = event.getData()
    'did the user click "Yes"
    if buttonIndex = 0 then
        'set appExit which will exit main loop in main.brs
        m.scene.appExit = true
    else
        'close the dialog
        m.scene.dialog.close = true
        return true
    end if
end function

sub AddToFaves(itemContent as object)
    sec = CreateObject("roRegistrySection", "FaveReg")

    ' Create a JSON-safe object
    jsonItem = {
        videoTitle: itemContent.videoTitle,
        videoUrl: itemContent.videoUrl,
        videoThumbnail: itemContent.videoThumbnail
        creator: itemContent.creator
        audioDuration: itemContent.audioDuration


    }

    ' Read existing entries
    entries = []
    if sec.Exists("entries")
        storedJson = sec.Read("entries")
        if storedJson <> ""
            entries = ParseJson(storedJson)
        end if
    end if

    ' Remove duplicates
    filteredEntries = []
    for each entry in entries
        if entry.videoUrl <> jsonItem.videoUrl
            filteredEntries.Push(entry)
        end if
    end for

    ' Add new item
    filteredEntries.Push(jsonItem)

    ' Limit to 20 entries
    if filteredEntries.Count() > 20
        filteredEntries = filteredEntries.slice(filteredEntries.Count() - 20)
    end if

    ' Save to registry
    sec.Write("entries", FormatJson(filteredEntries))
    sec.Flush()

    ' Show confirmation dialog
    ShowFavoritesConfirmationDialog()
    updateAddToFavInstruction()
end sub

sub ShowFavoritesConfirmationDialog()
    dialog = CreateObject("roSGNode", "StandardMessageDialog")
    dialog.title = "Success"
    dialog.message = ["Video added to favorites."]
    dialog.buttons = ["OK"]
    dialog.observeField("buttonSelected", "OnDismissConfirmationDialog")

    m.scene.dialog = dialog
end sub

sub OnDismissConfirmationDialog()
    m.scene.dialog.close = true
end sub
