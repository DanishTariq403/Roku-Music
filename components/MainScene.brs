' PaywallDisabledForTesting - TEMPORARY (2026-10-22). User: "temporary remove
' the limit logic ... hide the subscription button and screen as well ... so
' that user has full access to the app content." While this returns true:
'   - init() forces isSubscribed = true before VerifySubscription(). That opens
'     every gate that reads it: the per-day listening counter
'     (videoDurationLimit, still 240 here) and checkCurrentDuration(),
'     isPaywallActive() in MusicScreen and PlaylistDetailScreen, the
'     duration-vs-limit play checks on Home, Explore, Search and Favorites, and
'     Home's exit popup with its Claim-discount offer (shown only to
'     non-subscribers). Nothing is persisted.
'   - VerifySubscription() skips the Channel Store query, so its async answer
'     cannot put isSubscribed back to false. Home boots the same way.
'   - ShowSubscriptionScreen() returns at once (navbar tab, paywall OK, the
'     player's Upgrade button, TrialScreen), and Home's Claim-discount handler
'     does not start a purchase.
'   - m.global.paywallDisabledForTesting tells the component scopes, which
'     cannot call this function, to hide the navbar Subscription tab
'     (Navbar.brs) and the player's Upgrade button (MusicScreen.brs).
' Return false before a store release - that restores the paywall fully.
' grep PaywallDisabledForTesting finds every site of this change.
function PaywallDisabledForTesting() as boolean
    return true
end function

sub init()
    ' PaywallDisabledForTesting - TEMPORARY (2026-10-22): published first, before
    ' any screen exists, for the component scopes that cannot call the function.
    m.global.AddField("paywallDisabledForTesting", "boolean", false)
    m.global.paywallDisabledForTesting = PaywallDisabledForTesting()

      m.global.AddField("videoDurationLimit","integer",false)
              m.global.AddField("microphoeSearchKeyboard", "node", false)
              m.global.AddField("videoContent", "contentNode", false)
              m.global.AddField("watchContent", "contentNode", false)
              m.global.AddField("audio", "node", false)
              m.global.AddField("nowPlayingTrack", "node", false)
              m.top.video=m.top.findNode("VideoPlayer")


              m.global.AddField("audioDurationLimit","integer",false)
               m.global.AddField("appDuration","integer",false)
        m.AppTimer=m.top.findNode("appTimer")
           m.appTimer.observeField("fire","onAppTimerFire")
           m.global.appDuration=0
        m.global.observeField("appDuration","checkAppDuration")
        m.appTimer.control="start"
        m.global.AddField("RAT","boolean",false)
          m.busyspinner = m.top.findNode("spinner")
    m.busyspinner.poster.observeField("loadStatus", "showspinner")
    m.busyspinner.poster.uri = "pkg:/images/busySpinner.png"


    m.global.RAT=true
    m.global.AddField("appName","string",false)
    m.global.appName="CalmBlue"
    m.top.CurrentCategory=""


    m.global.videoDurationLimit=240
    m.global.AddField("duration","integer",false)
    m.global.AddField("videoArray","assocarray",false)
        m.global.videoArray=invalid
 m.global.duration=(getCurrentDuration()).toInt()
    m.global.observeField("duration","checkCurrentDuration")
     m.global.microphoeSearchKeyboard = m.top.findNode("microphoeSearchKeyboard")
 m.global.microphoeSearchKeyboard.textEditBox.voiceEntryType="generic"
 m.global.microphoeSearchKeyboard.textEditBox.voiceEnabled=true
InitScreenStack()
SetupGoogleAnalytics4()
SetupHomeItemFocusFields()
    ' PaywallDisabledForTesting - TEMPORARY (2026-10-22): full access. This app
    ' has no persisted entitlement seed (isSubscribed stays false until the
    ' Channel Store answers), so it is simply set here, before Home exists, and
    ' never persisted - switching the flag off brings back the real
    ' entitlement on the next launch.
    if PaywallDisabledForTesting() then m.top.isSubscribed = true
        reg = CreateObject("roRegistrySection", m.global.appName)

 
VerifySubscription()  
              
        
end sub

sub CloseCurrentScreen()
    CloseScreen(invalid)

end sub

sub ClearRegistryKeys()

    registry = CreateObject("roRegistry")

    for each sectionName in registry.GetSectionList()

        sec = CreateObject("roRegistrySection", sectionName)

        for each key in sec.GetKeyList()
            sec.Delete(key)
        end for

        sec.Flush()

    end for

    ?"All registry keys deleted"

end sub


sub SetupGoogleAnalytics4()
    m.global.AddField("analytics", "node", false)
    m.global.analytics = CreateObject("roSGNode", "GoogleAnalytics")
    m.global.analytics.callFunc("initialize", {

        measurementId: "G-SML9NHR2TL"
        appName: "ngkApp"
        docLocation: "https://www.google.com"
        customArgs: {}
    })
    m.global.analytics.callFunc("start")
end sub

sub checkCurrentDuration()
    ?"m.top.issubscribed"m.top.isSubscribed
    if m.global.duration>=m.global.videoDurationLimit and m.top.isSubscribed=false
        '  ShowSubscriptionScreen()
       GetCurrentScreen().isTrialExpired=true
        m.global.UnobserveField("duration")

        

    end if

end sub

sub ResetScreen()
m.screenStack=[]
ShowHomeScreen()

end sub

function getCurrentDuration()
    today=GetTodayShortDate()
    sec=CreateObject("roregistrySection","SR"+today)
    if sec.Exists("duration")
        currentDuration=sec.Read("duration")
        return currentDuration
    else return "1"

    end if

end function

sub startCountDown()
    ' ?"called 2"
     

    '  m.appTimer.control="start"
    '  m.global.observeField("RAT","restartAppTimer")
   
end sub


sub checkAppDuration()

            if m.global.appDuration=20 and m.top.isSubscribed=false
            

            ' ShowSettingScreen()
            ' m.SettingScreen.isRateUs=true
        end if

   
  



end sub

sub restartAppTimer()
  

end sub


sub onAppTimerFire()
 m.global.appDuration+=1
end sub

' Optional per-row focus/mask URIs for SingleRowItem (same pattern as creatorFocus / videoFocus).
' Update these when custom row assets are added.
sub SetupHomeItemFocusFields()
    m.top.AddField("squareFocus", "string", false)
    m.top.AddField("squareMask", "string", false)
    m.top.squareFocus = "pkg:/images/squareFocus.png"
    m.top.squareMask = "pkg:/images/squareMask.png"

    m.top.AddField("rankedFocus", "string", false)
    m.top.AddField("rankedMask", "string", false)
    m.top.rankedFocus = "pkg:/images/rankedFocus.png"
    m.top.rankedMask = "pkg:/images/rankedMask.png"

    m.top.AddField("badgeFocus", "string", false)
    m.top.AddField("badgeMask", "string", false)
    m.top.badgeFocus = "pkg:/images/badgeFocus.png"
    m.top.badgeMask = "pkg:/images/badgeMask.png"

    m.top.AddField("recentFocus", "string", false)
    m.top.AddField("recentMask", "string", false)
    m.top.recentFocus = "pkg:/images/recentFocus.png"
    m.top.recentMask = "pkg:/images/recentMask.png"

    m.top.AddField("artistFocus", "string", false)
    m.top.AddField("artistMask", "string", false)
    m.top.artistFocus = "pkg:/images/artistFocus.png"
    m.top.artistMask = "pkg:/images/artistMask.png"

    m.top.AddField("albumFocus", "string", false)
    m.top.AddField("albumMask", "string", false)
    m.top.albumFocus = "pkg:/images/albumFocus.png"
    m.top.albumMask = "pkg:/images/albumMask.png"

    ' mood / chart — reuse square until dedicated assets are added
    m.top.AddField("moodFocus", "string", false)
    m.top.AddField("moodMask", "string", false)
    m.top.moodFocus = "pkg:/images/squareFocus.png"
    m.top.moodMask = "pkg:/images/squareMask.png"

    m.top.AddField("chartFocus", "string", false)
    m.top.AddField("chartMask", "string", false)
    m.top.AddField("chartItemBg", "string", false)
    m.top.chartFocus = "pkg:/images/rankedFocus.png"
    m.top.chartMask = "pkg:/images/rankedMask.png"
    m.top.chartItemBg = "pkg:/images/chartItemBg.png"
end sub

function GetTodayShortDate() as String
    dt = CreateObject("roDateTime")
    dt.ToLocalTime()  ' Optional: only if you want local date instead of UTC

    year = dt.GetYear().ToStr()
    month = dt.GetMonth().ToStr()
    day = dt.GetDayOfMonth().ToStr()

    ' Pad month and day to two digits
    if month.Len() = 1 then month = "0" + month
    if day.Len() = 1 then day = "0" + day

    return year  + month +  day
end function

sub setCurrentDuration()
    today=GetTodayShortDate()
    sec=CreateObject("roregistrySection","SR"+today)
    if sec.Exists("duration")
        currentDuration=sec.Read("duration")
        updatedDuration=currentDuration.toInt()+1
        m.global.duration=updatedDuration
        ?"duration"updatedDuration
        sec.Write("duration",updatedDuration.toStr())
    else 
         sec.Write("duration","1")

    end if

end sub

function OnKeyEvent(key as string, press as boolean) as boolean
   result = false
   if press
       ' handle "back" key press
       if key = "back"
           ?"Back Pressed Event in MainScene"
           numberOfScreens = m.screenStack.Count()
           ?"number of screens"numberOfScreens
           ' close top screen if there are two or more screens in the screen stack
           if numberOfScreens > 1
           

               CloseScreen(invalid)
               result = true
           

           end if



       end if
   end if
 
   return result
end function