sub init()
    m.global.RAT = true
    m.currentSearchQuery = ""
    m.searchRequestId = 0
    m.pendingFocusResults = false
    m.VideoArrayGetter = invalid

    m.scene = m.top.getScene()
    m.scene.screenName = "Search"

    m.blurOL = m.top.findNode("blurOL")
    m.searchBar = m.top.findNode("searchBar")
    m.searchQueryLabel = m.top.findNode("searchQueryLabel")
    m.searchHintLabel = m.top.findNode("searchHintLabel")
    m.browseGroup = m.top.findNode("browseGroup")
    m.resultsGroup = m.top.findNode("resultsGroup")
    m.resultsLabel = m.top.findNode("resultsLabel")
    m.keywordsGrid = m.top.findNode("keywordsGrid")
    m.genresGrid = m.top.findNode("genresGrid")
    m.videosList = m.top.findNode("videosList")
    m.inputGroup = m.top.findNode("inputGroup")
    m.inputKeyboard = m.top.findNode("inputKeyboard")
    m.btnSubmit = m.top.findNode("btnSubmit")

    navBarInit("Search")

    BuildKeywordsGrid()
    BuildGenresGrid()

    m.searchBar.observeField("buttonSelected", "onSearchBarSelect")
    m.inputKeyboard.observeField("text", "onKeyboardText")
    m.btnSubmit.observeField("buttonSelected", "onBtnSubmitSelect")
    m.keywordsGrid.observeField("itemSelected", "onKeywordSelect")
    m.genresGrid.observeField("itemSelected", "onGenreSelect")
    m.videosList.observeField("itemSelected", "onVideoSelect")
    m.videosList.observeField("itemFocused", "onVideoFocus")

    m.resultsFocusTimer = m.top.findNode("resultsFocusTimer")
    m.resultsFocusTimer.observeField("fire", "onResultsFocusTimer")

    m.global.microphoeSearchKeyboard.hideTextBox = true
    m.global.microphoeSearchKeyboard.textEditBox.observeField("text", "onKeyboardTextChanged")
    m.global.microphoeSearchKeyboard.textEditBox.observeField("isDictating", "onKeyboardTextChanged")

    m.syncingKeyboardText = false
    m.top.observeField("visible", "onVisibleChange")
end sub

sub BuildKeywordsGrid()
    keywords = [
        "Karaoke"
        "Taylor Swift"
        "Bad Bunny"
        "Lofi"
        "BTS"
        "Drake"
        "Kendrick Lamar"
        "Eminem"
        "Billie Eilish"
        "Sabrina Carpenter"
        "Drake"
        "Dua Lipa"
        "NFAK"

    ]

    content = CreateObject("roSGNode", "ContentNode")
    for each keyword in keywords
        item = content.CreateChild("RowItemData")
        item.itemType = "keyword"
        item.videoTitle = keyword
    end for

    m.keywordsGrid.content = content
end sub

sub BuildGenresGrid()
    genres = GetGenreDefinitions()
    content = CreateObject("roSGNode", "ContentNode")

    for each genre in genres
        item = content.CreateChild("RowItemData")
        item.itemType = "genre"
        item.videoTitle = genre.title
        item.videoThumbnail = genre.imageUri
        item.genre = genre.searchTerm
    end for

    m.genresGrid.content = content
end sub

function GetGenreDefinitions() as object
    return [
        { title: "Pop", imageUri: "pkg:/images/genres/genre-Pop.png", searchTerm: "pop" }
        { title: "Rock", imageUri: "pkg:/images/genres/genre-Rock.png", searchTerm: "rock" }
        { title: "Hip-Hop & Rap", imageUri: "pkg:/images/genres/HipHop.png", searchTerm: "hip hop" }
        { title: "Electronic", imageUri: "pkg:/images/genres/Electronic.png", searchTerm: "electronic" }
        { title: "R&B & Soul", imageUri: "pkg:/images/genres/genre-R&B & Soul.png", searchTerm: "r&b soul" }
        { title: "Jazz", imageUri: "pkg:/images/genres/Jazz.png", searchTerm: "jazz" }
        { title: "Blues", imageUri: "pkg:/images/genres/Blues.png", searchTerm: "blues" }
        { title: "Country", imageUri: "pkg:/images/genres/Country.png", searchTerm: "country" }
        { title: "Classical", imageUri: "pkg:/images/genres/Classical.png", searchTerm: "classical" }
        { title: "Folk", imageUri: "pkg:/images/genres/Folk.png", searchTerm: "folk" }
        { title: "Metal", imageUri: "pkg:/images/genres/Metal.png", searchTerm: "metal" }
        { title: "World Music", imageUri: "pkg:/images/genres/WorldMusic.png", searchTerm: "world music" }
    ]
end function

sub onVisibleChange()
    if m.top.visible
        m.scene.screenName = "Search"
        navBarInit("Search")
        ShowBrowseMode()
        UpdateSearchQueryLabel()
        m.searchBar.setFocus(true)
    else
        CloseSearchKeyboard()
        CancelSearchTask()
    end if
end sub

sub onSearchBarSelect()
    m.searchBar.buttonSelected = false
    OpenSearchKeyboard()
end sub

sub OpenSearchKeyboard()
    m.inputGroup.visible = true
    SyncKeyboardText(m.currentSearchQuery)
    m.inputKeyboard.setFocus(true)
end sub

sub CloseSearchKeyboard()
    if m.inputGroup = invalid then return

    m.inputGroup.visible = false

    if m.btnSubmit <> invalid
        m.btnSubmit.setFocus(false)
    end if
    if m.inputKeyboard <> invalid
        m.inputKeyboard.setFocus(false)
    end if

    UpdateSearchQueryLabel()
end sub

sub onKeyboardText()
    if not IsKeyboardOpen() then return
    if m.syncingKeyboardText = true then return

    query = m.inputKeyboard.text
    if query = invalid then query = ""
    UpdateSearchQueryLabelPreview(query)
end sub

sub onKeyboardTextChanged()
    if m.scene.screenName <> "Search" then return
    if m.syncingKeyboardText = true then return

    query = m.global.microphoeSearchKeyboard.textEditBox.text
    if query = invalid then query = ""
    m.pendingFocusResults = true
    ApplySearchQuery(query, true)
end sub

sub ApplySearchQuery(query as string, syncKeyboards as boolean)
    if query = invalid then query = ""

    if syncKeyboards
        SyncKeyboardText(query)
    else
        m.currentSearchQuery = query
        UpdateSearchQueryLabel()
    end if

    if query = ""
        ShowBrowseMode()
    else
        RunSearch(query)
    end if
end sub

sub onBtnSubmitSelect()
    m.btnSubmit.buttonSelected = false

    query = m.inputKeyboard.text
    if query = invalid then query = ""
    m.pendingFocusResults = true
    ApplySearchQuery(query, true)

    CloseSearchKeyboard()
    ScheduleResultsGridFocus()
end sub

function IsKeyboardOpen() as boolean
    return m.inputGroup <> invalid and m.inputGroup.visible = true
end function

function IsNavbarFocused() as boolean
    if m.btnHomeN <> invalid and m.btnHomeN.hasFocus() then return true
    if m.btnFavN <> invalid and m.btnFavN.hasFocus() then return true
    if m.btnSubN <> invalid and m.btnSubN.hasFocus() then return true
    if m.btnSearchN <> invalid and m.btnSearchN.hasFocus() then return true
    if m.btnSettingN <> invalid and m.btnSettingN.hasFocus() then return true
    if m.btnRSN <> invalid and m.btnRSN.hasFocus() then return true
    if m.btnFFN <> invalid and m.btnFFN.hasFocus() then return true
    if m.btnARN <> invalid and m.btnARN.hasFocus() then return true
    if m.btnMEN <> invalid and m.btnMEN.hasFocus() then return true
    if m.btnBWN <> invalid and m.btnBWN.hasFocus() then return true
    return false
end function

sub SyncKeyboardText(query as string)
    if query = invalid then query = ""

    m.syncingKeyboardText = true
    m.currentSearchQuery = query

    if m.inputKeyboard <> invalid and m.inputKeyboard.text <> query
        m.inputKeyboard.text = query
    end if

    if m.global.microphoeSearchKeyboard <> invalid
        voiceBox = m.global.microphoeSearchKeyboard.textEditBox
        if voiceBox <> invalid and voiceBox.text <> query
            voiceBox.text = query
        end if
    end if

    m.syncingKeyboardText = false
    UpdateSearchQueryLabel()
end sub

sub UpdateSearchQueryLabel()
    if m.currentSearchQuery <> invalid and m.currentSearchQuery <> ""
        m.searchQueryLabel.text = m.currentSearchQuery
        m.searchQueryLabel.color = "#FFFFFF"
        m.searchHintLabel.visible = false
    else
        m.searchQueryLabel.text = "Search for songs"
        m.searchQueryLabel.color = "#888888"
        m.searchHintLabel.visible = true
    end if
end sub

sub UpdateSearchQueryLabelPreview(query as string)
    if query = invalid then query = ""

    if query <> ""
        m.searchQueryLabel.text = query
        m.searchQueryLabel.color = "#FFFFFF"
        m.searchHintLabel.visible = false
    else
        m.searchQueryLabel.text = "Search for songs"
        m.searchQueryLabel.color = "#888888"
        m.searchHintLabel.visible = true
    end if
end sub

sub ShowBrowseMode()
    m.browseGroup.visible = true
    m.resultsGroup.visible = false
    m.pendingFocusResults = false
    CancelSearchTask()
end sub

sub ShowResultsMode(query as string)
    m.browseGroup.visible = false
    m.resultsGroup.visible = true
    m.resultsLabel.text = "Results for " + query
end sub

sub CancelSearchTask()
    if m.VideoArrayGetter = invalid then return

    m.VideoArrayGetter.unobserveField("content")
    m.VideoArrayGetter.control = "STOP"
    m.VideoArrayGetter = invalid
end sub

sub StartSearchTask(query as string)
    CancelSearchTask()

    m.searchRequestId = m.searchRequestId + 1
    requestId = m.searchRequestId

    m.VideoArrayGetter = CreateObject("roSGNode", "GetSearchTask")
    m.VideoArrayGetter.searchKeyword = query
    m.VideoArrayGetter.searchRequestId = requestId
    m.VideoArrayGetter.observeField("content", "SetContent")
    m.VideoArrayGetter.control = "RUN"
end sub

sub RunSearch(query as string)
    if query = invalid or query = "" then return

    m.currentSearchQuery = query
    ShowResultsMode(query)
    StartSearchTask(query)
end sub

sub ScheduleResultsGridFocus()
    if m.resultsFocusTimer = invalid then return
    m.resultsFocusTimer.control = "stop"
    m.resultsFocusTimer.control = "start"
end sub

sub onResultsFocusTimer()
    if not m.top.visible then return
    if not m.resultsGroup.visible then return
    if IsKeyboardOpen() then return

    if m.videosList.content = invalid or m.videosList.content.getChildCount() = 0
        m.searchBar.setFocus(true)
        m.pendingFocusResults = false
        return
    end if

    m.videosList.setFocus(true)
    m.pendingFocusResults = false
end sub

sub onKeywordSelect(evt)
    index = evt.getData()
    item = m.keywordsGrid.content.getChild(index)
    if item = invalid or item.videoTitle = invalid then return

    m.currentSearchQuery = item.videoTitle
    SyncKeyboardText(m.currentSearchQuery)
    m.pendingFocusResults = true
    RunSearch(m.currentSearchQuery)
end sub

sub onGenreSelect(evt)
    index = evt.getData()
    item = m.genresGrid.content.getChild(index)
    if item = invalid then return

    searchTerm = item.videoTitle
    if item.genre <> invalid and item.genre <> ""
        searchTerm = item.genre
    end if

    m.currentSearchQuery = searchTerm
    SyncKeyboardText(m.currentSearchQuery)
    m.pendingFocusResults = true
    RunSearch(searchTerm)
end sub

sub SetContent()
    m.videosList.content=invalid
    if m.VideoArrayGetter = invalid then return

    if m.VideoArrayGetter.searchRequestId <> m.searchRequestId then return

    query = m.VideoArrayGetter.searchKeyword
    if query = invalid then query = ""
    if query <> m.currentSearchQuery then return

    shouldRestoreFocus = m.pendingFocusResults or m.videosList.hasFocus()

    videos = m.VideoArrayGetter.content
    if videos = invalid then videos = []

    videoGridContent = CreateObject("roSGNode", "ContentNode")

    for each video in videos
        if video = invalid then continue for

        childContent = videoGridContent.CreateChild("RowItemData")
        childContent.itemType = "track"
        childContent.videoTitle = video.title
        childContent.videoThumbnail = video.thumbnail
        childContent.id = video.id
        childContent.type = "Free"

        if video.artist <> invalid
            childContent.creator = video.artist
        else if video.creator <> invalid
            childContent.creator = video.creator
        end if

        if video.streamUrl <> invalid
            childContent.videoUrl = video.streamUrl
        else if video.videoUrl <> invalid
            childContent.videoUrl = video.videoUrl
        end if

        if video.duration <> invalid
            childContent.audioDuration = video.duration.ToStr()
        end if
    end for

    m.videosList.content = videoGridContent
    m.top.findNode("NVF").visible = videoGridContent.getChildCount() = 0

    if shouldRestoreFocus and not IsKeyboardOpen()
        if videoGridContent.getChildCount() > 0
            ScheduleResultsGridFocus()
        else
            m.searchBar.setFocus(true)
            m.pendingFocusResults = false
        end if
    end if
end sub

sub onVideoFocus(evt)
    index = evt.getData()
    m.videoIndex = m.videosList.content.getChild(index)
end sub

sub onVideoSelect(evt)
    index = evt.getData()
    m.videoIndex = m.videosList.content.getChild(index)
    if m.videoIndex = invalid then return

    if m.global.duration >= m.global.videoDurationLimit and m.top.getScene().isSubscribed = false
        showAppLockPopup()
    else
        m.scene.callFunc("ShowMusicScreen", {
            selectedTrack: m.videoIndex
            relatedContent: m.videosList.content
        })
    end if
end sub

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

sub revertButtons()
    m.blurOL.visible = false

    m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoUF.png"
    m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoF.png"
    m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaF.png"
    m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaF.png"
    m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavUF.png"
    m.btnFavN.focusBitmapUri = "pkg:/images/btnfavF.png"
    m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubUF.png"
    m.btnSubN.focusBitmapUri = "pkg:/images/btnSubF.png"
    m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnSetUF.png"
    m.btnSettingN.focusBitmapUri = "pkg:/images/btnSetF.png"
end sub

function OnKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    if key = "back" and IsKeyboardOpen()
        CloseSearchKeyboard()
        m.searchBar.setFocus(true)
        return true
    else if key = "back" and m.AppLockPopup.hasFocus()
        m.AppLockPopup.visible = false
        m.AppLockPopup.setFocus(false)
        if m.resultsGroup.visible
            m.videosList.setFocus(true)
        else
            m.searchBar.setFocus(true)
        end if
        return true
    else if key = "OK" and m.searchBar.hasFocus()
        OpenSearchKeyboard()
        return true
    else if key = "down" and IsKeyboardOpen() and m.inputKeyboard.visible and not IsNavbarFocused()
        m.inputKeyboard.setFocus(false)
        m.btnSubmit.setFocus(true)
        return true
    else if key = "up" and m.btnSubmit.hasFocus()
        m.btnSubmit.setFocus(false)
        m.inputKeyboard.setFocus(true)
        return true
    else if key = "down" and m.searchBar.hasFocus() and not IsKeyboardOpen() and not m.resultsGroup.visible
        m.searchBar.setFocus(false)
        m.keywordsGrid.setFocus(true)
        return true
    else if key = "up" and m.keywordsGrid.hasFocus()
        m.keywordsGrid.setFocus(false)
        m.searchBar.setFocus(true)
        return true
    else if key = "down" and m.keywordsGrid.hasFocus()
        m.keywordsGrid.setFocus(false)
        m.genresGrid.setFocus(true)
        return true
    else if key = "up" and m.genresGrid.hasFocus()
        m.genresGrid.setFocus(false)
        m.keywordsGrid.setFocus(true)
        return true
    else if key = "down" and m.searchBar.hasFocus() and m.resultsGroup.visible
        m.searchBar.setFocus(false)
        if m.videosList.content <> invalid and m.videosList.content.getChildCount() > 0
            m.videosList.setFocus(true)
        end if
        return true
    else if key = "up" and m.videosList.hasFocus()
        m.videosList.setFocus(false)
        m.searchBar.setFocus(true)
        return true
    else if key = "back" and m.resultsGroup.visible and m.currentSearchQuery <> ""
        ApplySearchQuery("", true)
        m.searchBar.setFocus(true)
        return true
    else if key = "options" and m.videosList.hasFocus()
        AddToFaves(m.videoIndex)
        return true
    else if key = "left" and (m.searchBar.hasFocus() or m.keywordsGrid.hasFocus() or m.genresGrid.hasFocus() or m.videosList.hasFocus())
        m.searchBar.setFocus(false)
        m.keywordsGrid.setFocus(false)
        m.genresGrid.setFocus(false)
        m.videosList.setFocus(false)
        m.blurOL.visible = true

        m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoEF.png"
        m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaS.png"
        m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaEF.png"
        m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavEUF.png"
        m.btnFavN.focusBitmapUri = "pkg:/images/btnfavEF.png"
        m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubEUF.png"
        m.btnSubN.focusBitmapUri = "pkg:/images/btnSubEF.png"
        m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        m.btnSettingN.focusBitmapUri = "pkg:/images/btnBSEF.png"

        m.btnSearchN.setFocus(true)
        return true
    else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus() or m.btnRSN.hasFocus() or m.btnFFN.hasFocus() or m.btnARN.hasFocus() or m.btnMEN.hasFocus() or m.btnBWN.hasFocus())
        m.top.setFocus(false)
        m.searchBar.setFocus(true)
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
    end if

    return false
end function

sub AddToRecents(itemContent as object)
    sec = CreateObject("roRegistrySection", "RecentRegCalmApp")

    jsonItem = {
        videoTitle: itemContent.videoTitle
        videoUrl: itemContent.videoUrl
        videoThumbnail: itemContent.videoThumbnail
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

sub AddToFaves(itemContent as object)
    sec = CreateObject("roRegistrySection", "FaveReg")

    jsonItem = {
        videoTitle: itemContent.videoTitle
        videoUrl: itemContent.videoUrl
        videoThumbnail: itemContent.videoThumbnail
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
