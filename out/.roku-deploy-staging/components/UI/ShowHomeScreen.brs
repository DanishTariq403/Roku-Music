sub ShowHomeScreen()
    m.global.analytics.callFunc("logEvent", "home_screen_opened", {
            "screen_name": "OnboardingScreen"
        })
 m.HomeScreen = CreateObject("roSGNode","HomeScreen")
 m.HomeScreen.observeField("btnDiscountSelect","onbtnDiscountSelect")

    ShowScreen(m.HomeScreen)
end sub

sub onBtnDiscountSelect()
      if m.HomeScreen.btnDiscountSelect
    m.top.isSubYearly=false
    m.top.isSubDiscount=true
    StartSubscription()
    end if

end sub