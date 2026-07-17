sub init()
    m.top.functionName = "LoadEraTracks"
    m.apiBase = "http://185.194.218.34:3001"
end sub

sub LoadEraTracks()
    era = m.top.era
    if era = invalid or era = ""
        m.top.content = []
        return
    end if

    transfer = CreateObject("roUrlTransfer")
    transfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    transfer.InitClientCertificates()
    transfer.SetUrl(m.apiBase + "/api/eras/" + transfer.Escape(era) + "/tracks?limit=50")
    transfer.SetMinimumTransferRate(1, 12)

    port = CreateObject("roMessagePort")
    transfer.SetMessagePort(port)

    result = []
    if transfer.AsyncGetToString()
        timer = CreateObject("roTimespan")
        timer.Mark()
        while true
            msg = wait(250, port)
            if type(msg) = "roUrlEvent"
                if msg.GetResponseCode() = 200
                    response = msg.GetString()
                    if response <> invalid and response <> ""
                        json = ParseJson(response)
                        if json <> invalid and Type(json) = "roArray"
                            result = json
                        end if
                    end if
                end if
                exit while
            else if timer.TotalMilliseconds() > 15000
                transfer.AsyncCancel()
                exit while
            end if
        end while
    end if

    m.top.content = result
end sub
