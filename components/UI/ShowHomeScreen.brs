sub ShowHomeScreen()
    m.global.analytics.callFunc("logEvent", "home_screen_opened", {
            "screen_name": "OnboardingScreen"
        })
 m.HomeScreen = CreateObject("roSGNode","HomeScreen")
 m.HomeScreen.observeField("btnDiscountSelect","onbtnDiscountSelect")

    ShowScreen(m.HomeScreen)
end sub

sub onBtnDiscountSelect()
    ' PaywallDisabledForTesting - TEMPORARY (2026-10-22): the exit popup's Claim
    ' (discount) button goes straight to StartSubscription(), not through
    ' ShowSubscriptionScreen(), so it is stopped here too. (The popup itself is
    ' only raised for non-subscribers, which nobody is while the switch is on.)
    if PaywallDisabledForTesting() then return
      if m.HomeScreen.btnDiscountSelect
    m.top.isSubYearly=false
    m.top.isSubDiscount=true
    StartSubscription()
    end if

end sub