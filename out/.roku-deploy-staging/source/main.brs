sub Main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.SetMessagePort(m.port)
    
    scene = screen.CreateScene("MainScene")

    screen.Show()
     scene.observeField("appExit", m.port)

    Scene.signalBeacon("AppLaunchComplete")
  
    while true
        msg = wait(0, m.port)
    msgType = type(msg)
      if msgType = "roSGScreenEvent" then
      if msg.isScreenClosed() then
        return
      end if
    'respond to the appExit field on MainScene
    else if msgType = "roSGNodeEvent" then
      field = msg.getField()
      'if the scene's appExit field was changed in any way, exit the channel
      if field = "appExit" then
        return
      end if
    end if
      end while

  end sub
  