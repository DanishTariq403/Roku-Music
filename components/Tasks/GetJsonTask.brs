sub init()
    m.top.functionName = "LoadHomeData"
    m.apiBase = "http://185.194.218.34:3001"
    m.cachedNewReleases = invalid
    m.rowItemLimit = 30
end sub

' Returns ordered homepage sections matching the UI design:
' Hero, Quick Picks, Trending Now, Recommended, New Releases,
' Mood Playlists, Popular Artists, Featured Albums, Top Charts
' (Recently Played is filled locally in HomeScreen from registry)
sub LoadHomeData()
    sections = {}
    sectionOrder = []

    LoadHeroSection(sections, sectionOrder)
    LoadQuickPicksSection(sections, sectionOrder)
    LoadTrendingNowSection(sections, sectionOrder)
    LoadRecommendedSection(sections, sectionOrder)
    LoadNewReleasesSection(sections, sectionOrder)
    ? "Loading mood playlists..."
    LoadMoodPlaylistsSection(sections, sectionOrder)
    ? "Loading popular artists..."
    LoadPopularArtistsSection(sections, sectionOrder)
    ? "Loading featured albums..."
    LoadFeaturedAlbumsSection(sections, sectionOrder)
    ? "Loading top charts..."
    LoadTopChartsSection(sections, sectionOrder)

    content = {
        sectionOrder: sectionOrder
        sections: sections
    }

    layoutArrays = BuildHomeRowLayoutArrays(sectionOrder, sections)
    content.rowItemSize = layoutArrays.rowItemSize
    content.rowItemSpacing = layoutArrays.rowItemSpacing
    content.rowHeights = layoutArrays.rowHeights

    AttachLegacyCategoryKeys(content, sections)

    m.top.content = content

    ? "Home sections loaded: "; sectionOrder.Count()
end sub

sub LoadHeroSection(sections as object, sectionOrder as object)
    json = FetchApi(m.apiBase + "/api/playlists/trending")
    items = NormalizePlaylistItems(ExtractItems(json))
    items = LimitArray(items, 1)
    if items.Count() = 0 then return

    featured = items[0]
    featured.description = BuildPlaylistDescription(featured)

    AddSection(sections, sectionOrder, "hero", {
        title: "Featured Playlist"
        layout: "hero"
        itemType: "playlist"
        label: "FEATURED PLAYLIST"
        items: [featured]
    })
end sub

sub LoadQuickPicksSection(sections as object, sectionOrder as object)
    json = FetchApi(BuildApiUrl("/api/playlists/popular", m.rowItemLimit))
    items = NormalizePlaylistItems(ExtractItems(json))
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
    m.cachedNewReleases = items
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

sub LoadPopularArtistsSection(sections as object, sectionOrder as object)
    json = FetchApi(BuildApiUrl("/api/playlists/top-artists", m.rowItemLimit))
    items = ExtractItems(json)
    items = LimitArray(items, m.rowItemLimit)
    if items.Count() = 0 then return

    for each item in items
        if item = invalid then continue for
        if item.thumbnail = invalid and item.artistImage <> invalid
            item.thumbnail = item.artistImage
        end if
        if item.creator = invalid and item.title <> invalid
            item.creator = item.title
        end if
        if item.genre = invalid
            item.genre = "Artist"
        end if
    end for

    AddSection(sections, sectionOrder, "popularArtists", {
        title: "Popular Artists"
        layout: "artist"
        itemType: "artist"
        items: items
    })
end sub

sub LoadFeaturedAlbumsSection(sections as object, sectionOrder as object)
    allItems = m.cachedNewReleases
    if allItems = invalid or allItems.Count() = 0
        json = FetchApi(BuildApiUrl("/api/playlists/new-releases", m.rowItemLimit))
        allItems = NormalizePlaylistItems(ExtractItems(json))
    end if

    albums = []
    for each item in allItems
        if item = invalid then continue for
        if item.isAlbum = true
            albums.Push(item)
        else if item.trackCount <> invalid and item.trackCount > 3
            albums.Push(item)
        end if
    end for

    if albums.Count() = 0
        albums = LimitArray(allItems, m.rowItemLimit)
    else
        albums = LimitArray(albums, m.rowItemLimit)
    end if

    if albums.Count() = 0 then return

    for each item in albums
        item.releaseYear = ExtractReleaseYear(item)
        if item.subtitle = invalid and item.artist <> invalid
            item.subtitle = item.artist
        end if
    end for

    AddSection(sections, sectionOrder, "featuredAlbums", {
        title: "Featured Albums"
        layout: "album"
        itemType: "playlist"
        items: albums
    })
end sub

sub LoadTopChartsSection(sections as object, sectionOrder as object)
    json = FetchApi(BuildApiUrl("/api/playlists/top", m.rowItemLimit))
    items = ExtractItems(json)
    items = LimitArray(items, m.rowItemLimit)
    if items.Count() = 0 then return

    AnnotateRanks(items, 1)
    AnnotateRankChanges(items)
    AnnotateSubtitles(items, "artist")

    AddSection(sections, sectionOrder, "topCharts", {
        title: "Top Charts"
        layout: "chart"
        itemType: "track"
        items: items
    })
end sub

sub AttachLegacyCategoryKeys(content as object, sections as object)
    if sections.quickPicks <> invalid
        content["Popular Playlists"] = {
            type: "playlist"
            items: sections.quickPicks.items
            source: "audius"
        }
    end if

    if sections.topCharts <> invalid
        content["Top Playlists"] = {
            type: "track"
            items: sections.topCharts.items
            source: "audius"
        }
    end if

    if sections.recommended <> invalid
        content["Recommended Playlists"] = {
            type: "playlist"
            items: sections.recommended.items
            source: "audius"
        }
    end if

    if sections.popularArtists <> invalid
        content["Top Artists"] = {
            type: "artist"
            items: sections.popularArtists.items
            source: "audius"
        }
    end if
end sub

sub AddSection(sections as object, sectionOrder as object, sectionId as string, sectionData as object)
    if sectionData <> invalid and sectionData.items <> invalid and ShouldShuffleSectionItems(sectionId)
        sectionData.items = ShuffleArray(sectionData.items)
    end if

    sections[sectionId] = sectionData
    sectionOrder.Push(sectionId)
    ? sectionData.title; " -> "; sectionData.items.Count()
end sub

function BuildPlaylistDescription(playlist as object) as string
    if playlist = invalid then return ""

    parts = []
    if playlist.artist <> invalid
        parts.Push(playlist.artist)
    else if playlist.creator <> invalid
        parts.Push(playlist.creator)
    end if

    if playlist.tracks <> invalid and Type(playlist.tracks) = "roArray"
        for each track in playlist.tracks
            if track = invalid then continue for
            if track.artist <> invalid and not ArrayContains(parts, track.artist)
                parts.Push(track.artist)
            end if
            if parts.Count() >= 5 then exit for
        end for
    end if

  return JoinArray(parts, ", ")
end function

function ArrayContains(arr as object, value as string) as boolean
    for each item in arr
        if item = value then return true
    end for
    return false
end function

function JoinArray(arr as object, separator as string) as string
    result = ""
    for i = 0 to arr.Count() - 1
        if i > 0
            result = result + separator
        end if
        result = result + arr[i]
    end for
    return result
end function

sub AnnotateRanks(items as object, startRank as integer)
    rank = startRank
    for each item in items
        if item <> invalid
            item.rank = rank
            rank = rank + 1
        end if
    end for
end sub

sub AnnotateRankChanges(items as object)
    i = 0
    for each item in items
        if item <> invalid
            item.rankChange = (i mod 3) + 1
            i = i + 1
        end if
    end for
end sub

sub AnnotateBadge(items as object, badgeText as string)
    for each item in items
        if item <> invalid
            item.badgeText = badgeText
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

function ExtractReleaseYear(item as object) as string
    if item = invalid then return ""

    if item.releaseDate <> invalid
        dateStr = item.releaseDate.ToStr()
        if Len(dateStr) >= 4
            return Left(dateStr, 4)
        end if
    end if

    dt = CreateObject("roDateTime")
    return dt.GetYear().ToStr()
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
        ? "FetchApi failed to start: "; url
        return invalid
    end if

    timer = CreateObject("roTimespan")
    timer.Mark()
    timeoutMs = 15000

    while true
        msg = wait(250, port)
        if type(msg) = "roUrlEvent"
            code = msg.GetResponseCode()
            if code = 200
                response = msg.GetString()
                if response = invalid or response = "" then return invalid
                return ParseJson(response)
            end if
            ? "FetchApi HTTP "; code; ": "; url
            return invalid
        else if timer.TotalMilliseconds() > timeoutMs
            transfer.AsyncCancel()
            ? "FetchApi timeout: "; url
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
        if (entry.artistImage = invalid or entry.artistImage = "") and item.tracks <> invalid and Type(item.tracks) = "roArray" and item.tracks.Count() > 0
            firstTrack = item.tracks[0]
            if firstTrack <> invalid and firstTrack.artistImage <> invalid and firstTrack.artistImage <> ""
                entry.artistImage = firstTrack.artistImage
            end if
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
