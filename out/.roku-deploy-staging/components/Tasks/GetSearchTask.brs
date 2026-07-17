sub init()
    m.top.functionName = "LoadHomeData"
end sub

sub LoadHomeData()
    result = []

    keyword = m.top.searchKeyword
    if keyword = invalid then keyword = ""

    transfer = CreateObject("roUrlTransfer")
    transfer.SetUrl("http://185.194.218.34:3001/api/search?q=" + transfer.Escape(keyword))

    response = transfer.GetToString()
    if response <> invalid and response <> ""
        json = ParseJson(response)
        if json <> invalid and json.results <> invalid
            result = json.results
        end if
    end if

    m.top.content = result
end sub
