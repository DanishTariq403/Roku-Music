sub init()
  m.top.functionName = "fixPlaylist"
end sub

sub fixPlaylist()
  id = m.top.url

  xfer = CreateObject("roURLTransfer")
  xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
  url="http://185.194.218.34:3001/api/play/"+id
  
  xfer.SetURL(url)
  rsp = xfer.GetToString()

  if rsp = invalid or rsp = "" then
    print "Failed to fetch playlist"
     m.global.analytics.callFunc("logEvent", "video_loading_failed", {
        "screen_name": "OnboardingScreen"})
    return
  end if
  json=ParseJson(rsp)
  streamUrl=json.streamUrl

 
  
  m.top.fixedUrl =streamUrl
end sub

function GetBaseUrl(url as String) as String
    for i = len(url) to 1 step -1
        if mid(url, i, 1) = "/" then
            return left(url, i)
        end if
    end for
    return url
end function

function EncodeUri(str as String) as String
  return str.replace(" ", "%20").replace(",", "%2C")
end function

function WriteFixedM3U8(content as String) as String
    filePath = "tmp:/fixed.m3u8"

    result = WriteAsciiFile(filePath, content)
    if result then
        return filePath
    else
        print "ERROR: Failed to write file"
        return ""
    end if
end function
