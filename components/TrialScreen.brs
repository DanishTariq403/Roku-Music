sub init()
    m.btnback=m.top.findNode("btnBack")
    m.btnSub=m.top.findNode("btnSubscribe")
    m.btnTrial=m.top.findNode("btnTrial")
    m.top.observeField("visible","onVisibleChange")

end sub

sub onVisibleChange()

    if m.top.visible
        m.btnSub.setfocus(true)

    end if
end sub

function OnkeyEvent(key as string, press as boolean) as boolean
    result = false

    if press
        if key="down" and m.btnback.hasFocus()
            m.btnback.setfocus(false)
            m.btnSub.setfocus(true)
            result=true
        else if key="right" and m.btnSub.hasFocus()
            m.btnSub.setfocus(false)
            m.btnTrial.setfocus(true)
            result=true
        else if key="left" and m.btnTrial.hasFocus()
            m.btnTrial.setfocus(false)
            m.btnSub.setfocus(true)
            result=true
        ' else if key="up" and m.btnSub.hasFocus()
        '     m.btnSub.setfocus(false)
        '     m.btnback.setfocus(true)
        '     result=true

        end if


    end if
  return result
    end function