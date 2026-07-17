sub ShowTrialScreen()
    m.TrialScreen = CreateObject("roSGNode","TrialScreen")
    m.TrialScreen.observeField("btnTrialSelect","ShowHomeFromTrial")
    m.TrialScreen.observeField("btnSubscribeSelect","ShowSubscriptionFromTrial")
    ShowScreen(m.TrialScreen)

end sub

sub ShowHomeFromTrial()
      reg = CreateObject("roRegistrySection", m.global.appName)
    reg.Write("optionSelected","true")
    VerifySubscription()
     ShowHomeScreen()

end  sub

sub ShowSubscriptionFromTrial()
  
   startCountDown()
     ShowSubscriptionScreen()

end  sub