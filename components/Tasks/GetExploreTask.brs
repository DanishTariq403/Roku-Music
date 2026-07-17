sub init()
    m.top.functionName = "LoadExploreData"
    m.apiBase = "http://185.194.218.34:3001"
    m.rowItemLimit = 30
end sub

sub LoadExploreData()
    sections = {}
    sectionOrder = []

    LoadPopularPlaylistsSection(sections, sectionOrder)
    LoadMoodPlaylistsSection(sections, sectionOrder)
    LoadBrowseByEraSection(sections, sectionOrder)
    LoadQuickPicksSection(sections, sectionOrder)
    LoadTrendingNowSection(sections, sectionOrder)
    LoadRecommendedSection(sections, sectionOrder)
    LoadNewReleasesSection(sections, sectionOrder)

    content = {
        sectionOrder: sectionOrder
        sections: sections
    }

    layoutArrays = BuildExploreRowLayoutArrays(sectionOrder, sections)
    content.rowItemSize = layoutArrays.rowItemSize
    content.rowItemSpacing = layoutArrays.rowItemSpacing
    content.rowHeights = layoutArrays.rowHeights

    m.top.content = content

    ? "Explore sections loaded: "; sectionOrder.Count()
end sub

sub LoadPopularPlaylistsSection(sections as object, sectionOrder as object)
    json = FetchApi(BuildApiUrl("/api/playlists/popular", m.rowItemLimit))
    items = NormalizePlaylistItems(ExtractItems(json))
    items = LimitArray(items, m.rowItemLimit)
    if items.Count() = 0 then return

    AnnotateSubtitles(items, "artist")

    AddSection(sections, sectionOrder, "popularPlaylists", {
        title: "Popular Playlists"
        layout: "ranked"
        itemType: "playlist"
        items: items
    })
end sub

sub LoadBrowseByEraSection(sections as object, sectionOrder as object)
    items = [
        { title: "80s", era: "80s", subtitle: "English Music" }
        { title: "90s", era: "90s", subtitle: "English Music" }
        { title: "2000s", era: "2000s", subtitle: "English Music" }
        { title: "2010s", era: "2010s", subtitle: "English Music" }
        { title: "Latest", era: "latest", subtitle: "English Music" }
    ]

    AddSection(sections, sectionOrder, "browseByEra", {
        title: "Browse by Era"
        layout: "era"
        itemType: "era"
        items: items
    })
end sub

sub LoadQuickPicksSection(sections as object, sectionOrder as object)
    json = FetchApi(BuildApiUrl("/api/playlists/popular", m.rowItemLimit) + "&offset=" + m.rowItemLimit.ToStr())
    items = NormalizePlaylistItems(ExtractItems(json))
    if items.Count() = 0
        json = FetchApi(BuildApiUrl("/api/playlists/popular", m.rowItemLimit))
        items = NormalizePlaylistItems(ExtractItems(json))
    end if
    items = LimitArray(items, m.rowItemLimit)
    if items.Count() = 0 then return

    AnnotateSubtitles(items, "artist")

    AddSection(sections, sectionOrder, "quickPicks", {
        title: "Quick Picks"
        layout: "square"
        itemType: "playlist"
        items: items
    })
end sub

sub LoadMoodPlaylistsSection(sections as object, sectionOrder as object)
    moodsJson = FetchApi(m.apiBase + "/api/moods")
    moodList = ExtractItems(moodsJson)
    if moodList.Count() = 0 then return

    preferredMoods = ["Peaceful", "Energizing", "Romantic", "Melancholy", "Upbeat", "Cool"]
    moodItems = []

    for each moodName in preferredMoods
        moodItems.Push({
            title: moodName
            moodName: moodName
            moodColor: GetMoodColor(moodName)
            emoji: FindMoodEmoji(moodList, moodName)
        })
    end for

    if moodItems.Count() = 0 then return

    AddSection(sections, sectionOrder, "moodPlaylists", {
        title: "Mood Playlists"
        layout: "mood"
        itemType: "playlist"
        items: moodItems
    })
end sub

sub LoadTrendingNowSection(sections as object, sectionOrder as object)
    json = FetchApi(BuildApiUrl("/api/trending", m.rowItemLimit))
    items = ExtractItems(json)
    items = LimitArray(items, m.rowItemLimit)
    if items.Count() = 0 then return

    AnnotateRanks(items, 1)
    AnnotateSubtitles(items, "artist")

    AddSection(sections, sectionOrder, "trendingNow", {
        title: "Trending Now"
        layout: "ranked"
        itemType: "track"
        items: items
    })
end sub

sub LoadRecommendedSection(sections as object, sectionOrder as object)
    items = invalid

    json = FetchApi(BuildApiUrl("/api/recommended", m.rowItemLimit))
    if json <> invalid
        items = NormalizePlaylistItems(ExtractItems(json))
    end if

    if items = invalid or items.Count() = 0
        json = FetchApi(BuildApiUrl("/api/playlists/most-relevant", m.rowItemLimit))
        items = NormalizePlaylistItems(ExtractItems(json))
    end if

    if items = invalid or items.Count() = 0
        json = FetchApi(BuildApiUrl("/api/playlists/trending", m.rowItemLimit))
        items = NormalizePlaylistItems(ExtractItems(json))
    end if

    items = LimitArray(items, m.rowItemLimit)
    if items.Count() = 0 then return

    AnnotateSubtitles(items, "artist")

    AddSection(sections, sectionOrder, "recommended", {
        title: "Recommended For You"
        layout: "badge"
        itemType: "playlist"
        items: items
    })
end sub

sub LoadNewReleasesSection(sections as object, sectionOrder as object)
    json = FetchApi(BuildApiUrl("/api/playlists/new-releases", m.rowItemLimit))
    items = NormalizePlaylistItems(ExtractItems(json))
    items = LimitArray(items, m.rowItemLimit)
    if items.Count() = 0 then return

    AnnotateSubtitles(items, "artist")

    AddSection(sections, sectionOrder, "newReleases", {
        title: "New Releases"
        layout: "badge"
        itemType: "playlist"
        items: items
    })
end sub

sub AddSection(sections as object, sectionOrder as object, sectionId as string, sectionData as object)
    if sectionData <> invalid and sectionData.items <> invalid and ShouldShuffleSectionItems(sectionId)
        sectionData.items = ShuffleArray(sectionData.items)
    end if

    sections[sectionId] = sectionData
    sectionOrder.Push(sectionId)
end sub

sub AnnotateRanks(items as object, startRank as integer)
    rank = startRank
    for each item in items
        if item <> invalid
            item.rank = rank
            rank = rank + 1
        end if
    end for
end sub

sub AnnotateSubtitles(items as object, fieldName as string)
    for each item in items
        if item = invalid then continue for
        if fieldName = "artist" and item.artist <> invalid
            item.subtitle = item.artist
        else if item.creator <> invalid
            item.subtitle = item.creator
        else if item.title <> invalid
            item.subtitle = item.title
        end if
    end for
end sub

function FindMoodEmoji(moodList as object, moodName as string) as string
    for each mood in moodList
        if mood <> invalid and mood.name = moodName and mood.emoji <> invalid
            return mood.emoji
        end if
    end for
    return ""
end function

function BuildApiUrl(path as string, limit as integer) as string
    url = m.apiBase + path
    if limit <= 0 then return url

    sep = "?"
    if Instr(1, path, "?") > 0
        sep = "&"
    end if

    return url + sep + "limit=" + limit.ToStr()
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

function LimitArray(arr as object, maxCount as integer) as object
    if arr = invalid or Type(arr) <> "roArray" then return []
    if arr.Count() <= maxCount then return arr

    limited = []
    for i = 0 to maxCount - 1
        limited.Push(arr[i])
    end for
    return limited
end function

function NormalizePlaylistItems(items as object) as object
    if items = invalid or Type(items) <> "roArray" then return []

    normalized = []
    for each item in items
        if item = invalid then continue for

        entry = item
        if item.thumbnail = invalid and item.artwork <> invalid
            entry.thumbnail = item.artwork
        end if
        if item.creator = invalid and item.artist <> invalid
            entry.creator = item.artist
        end if
        if item.subtitle = invalid and item.artist <> invalid
            entry.subtitle = item.artist
        end if

        normalized.Push(entry)
    end for

    return normalized
end function
