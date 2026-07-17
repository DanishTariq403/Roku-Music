sub init()
    m.top.functionName = "LoadGenreCatalog"
    m.apiBase = "http://185.194.218.34:3001"
    m.maxGenres = 6
end sub

sub LoadGenreCatalog()
    genresJson = FetchApi(m.apiBase + "/api/genres")
    if genresJson = invalid then return

    genreList = ExtractItems(genresJson)
    if genreList.Count() = 0 then return

    maxGenres = m.maxGenres
    if genreList.Count() < maxGenres
        maxGenres = genreList.Count()
    end if

    catalog = {}
    transfer = CreateObject("roUrlTransfer")

    for i = 0 to maxGenres - 1
        genreEntry = genreList[i]
        if genreEntry = invalid or genreEntry.name = invalid then continue for

        genreName = genreEntry.name
        url = m.apiBase + "/api/genres/search?genre=" + transfer.Escape(genreName)
        json = FetchApi(url)
        items = ExtractItems(json)
        items = LimitArray(items, 50)

        if items.Count() > 0
            catalog[genreName] = { type: "track", items: items, source: "audius", genre: genreName }
            ? genreName; " (catalog) -> "; items.Count()
        end if
    end for

    m.top.content = catalog
end sub

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
