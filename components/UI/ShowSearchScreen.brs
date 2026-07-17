sub ShowSearchScreen()
   m.global.analytics.callFunc("logEvent", "search_screen_opened", {
            "screen_name": "OnboardingScreen"
        })
 m.SearchScreen = CreateObject("roSGNode","SearchScreen")

    ShowScreen(m.SearchScreen)
 end sub