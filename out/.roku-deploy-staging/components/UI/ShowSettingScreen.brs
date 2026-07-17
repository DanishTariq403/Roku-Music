sub ShowSettingScreen()
   m.global.analytics.callFunc("logEvent", "settings_screen_opened", {
            "screen_name": "OnboardingScreen"
        })
 m.SettingScreen = CreateObject("roSGNode","SettingScreen")

    ShowScreen(m.SettingScreen)
 end sub