sub init()

    m.global.RAT = false

    m.scene = m.top.getScene()
    m.scene.screenName="Sub"
    m.blurOL = m.top.findNode("blurOL")

    m.navbar = m.top.findNode("navBar")

    navBarInit("Sub")
    m.BG = m.top.findNode("BG")


    m.btnMonthly = m.top.findNode("btnMonthly")
    m.btnYearly = m.top.findNode("btnYearly")
    m.btnCancel = m.top.findNode("btnCancel")
    m.btnCancel.observeField("buttonSelected","onBtnExitSelect")
    m.top.observeField("visible", "onVisibleChange")

 m.global.microphoeSearchKeyboard.hideTextBox = true
    m.global.microphoeSearchKeyboard.textEditBox.observeField("text", "onSub")
    m.global.microphoeSearchKeyboard.textEditBox.observeField("isDictating", "onSub")



end sub

sub onBtnExitSelect()
    m.scene.callFunc("CloseCurrentScreen")
end sub

sub onSub()
    if m.scene.screenName="Sub"
m.btnYearly.setFocus(true)
    end if
end sub

sub onVisibleChange()
    if m.top.visible
        m.scene.screenName="Sub"

        navBarInit("Sub")
        m.btnMonthly.setFocus(true)
        ' revertButtons()
        m.global.RAT = false
    else
        m.global.RAT = true


    end if


end sub

sub revertButtons()
    m.blurOL.visible = false

   

    m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoUF.png"
    m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoF.png"
    m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaUF.png"
    m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaF.png"
    m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavUF.png"
    m.btnFavN.focusBitmapUri = "pkg:/images/btnfavF.png"
    m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubF.png"
    m.btnSubN.focusBitmapUri = "pkg:/images/btnSubF.png"
    m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnSetUF.png"
    m.btnSettingN.focusBitmapUri = "pkg:/images/btnSetF.png"

end sub

function onKeyEvent(key as string, press as boolean) as boolean
    result = false

    if press
        if key = "left" and m.btnMonthly.hasFocus()
            m.btnMonthly.setFocus(false)
            m.btnYearly.setFocus(true)
            result = true
        else if key = "right" and m.btnYearly.hasFocus()
            m.btnYearly.setFocus(false)
            m.btnMonthly.setFocus(true)
            result = true
else if key = "up" and ( m.btnYearly.hasFocus() or m.btnMonthly.hasFocus())
            m.top.setFocus(false)
            m.btnCancel.setFocus(true)
            result = true
else if key = "down" and  m.btnCancel.hasFocus()
            m.top.setFocus(false)
            m.btnYearly.setFocus(true)
            result = true

        ' else if key = "left" and (m.btnMonthly.hasFocus() or m.btnYearly.hasFocus())
        '     m.btnSubN.focusFootprintBitmapUri = "pkg:/images/btnSubUF.png"
        '     m.btnMonthly.setFocus(false)
        '     m.btnYearly.setFocus(false)
        '     m.blurOL.visible = true

        '     ' m.NBG.width = 658
        '     m.NBG.uri = "pkg:/images/NBE.png"
        '     m.btnHomeN.focusfootprintbitmapuri = "pkg:/images/btnHoEUF.png"
        '     m.btnHomeN.focusBitmapUri = "pkg:/images/btnHoEF.png"
        '     m.btnSearchN.focusfootprintbitmapuri = "pkg:/images/btnSeaEUF.png"
        '     m.btnSearchN.focusBitmapUri = "pkg:/images/btnSeaEF.png"
        '     m.btnFavN.focusfootprintbitmapuri = "pkg:/images/btnfavEUF.png"
        '     m.btnFavN.focusBitmapUri = "pkg:/images/btnfavEF.png"
        '     m.btnSubN.focusfootprintbitmapuri = "pkg:/images/btnSubS.png"
        '     m.btnSubN.focusBitmapUri = "pkg:/images/btnSubEF.png"
        '     m.btnSettingN.focusfootprintbitmapuri = "pkg:/images/btnBSEUF.png"
        '     m.btnSettingN.focusBitmapUri = "pkg:/images/btnBSEF.png"

        '     m.btnSubN.setFocus(true)
        '     return true
        else if key = "right" and (m.btnHomeN.hasFocus() or m.btnFavN.hasFocus() or m.btnSubN.hasFocus() or m.btnSearchN.hasFocus() or m.btnSettingN.hasFocus() or m.btnRSN.hasFocus() or m.btnFFN.hasFocus() or m.btnARN.hasFocus() or m.btnMEN.hasFocus() or m.btnBWN.hasFocus())
            m.btnSubN.focusFootprintBitmapUri = "pkg:/images/btnSubS.png"
            m.top.setFocus(false)
            ' revertButtons()
            m.btnMonthly.setFocus(true)
            return true

        else if key = "down" and m.btnHomeN.hasFocus()
            m.btnHomeN.setFocus(false)
            m.btnSubN.setFocus(true)
            return true
        else if key = "down" and m.btnSubN.hasFocus()
            m.btnSubN.setFocus(false)
            m.btnFavN.setFocus(true)
            return true

        else if key = "down" and m.btnFavN.hasFocus()
            m.btnFavN.setFocus(false)
            m.btnSettingN.setFocus(true)
            return true
        else if key = "down" and m.btnSearchN.hasFocus()
            m.btnSearchN.setFocus(false)
            m.btnHomeN.setFocus(true)
            return true
   else if key = "down" and m.btnSettingN.hasFocus()
            m.btnSettingN.setFocus(false)
            m.btnRSN.setFocus(true)
            return true
             else if key = "down" and m.btnRSN.hasFocus()
            m.btnRSN.setFocus(false)
            m.btnFFN.setFocus(true)
            return true
             else if key = "down" and m.btnFFN.hasFocus()
            m.btnFFN.setFocus(false)
            m.btnARN.setFocus(true)
            return true
             else if key = "down" and m.btnARN.hasFocus()
            m.btnARN.setFocus(false)
            m.btnMEN.setFocus(true)
            return true
             else if key = "down" and m.btnMEN.hasFocus()
            m.btnMEN.setFocus(false)
            m.btnBWN.setFocus(true)
            return true
        else if key = "down" and m.btnSearchN.hasFocus()
            m.btnSearchN.setFocus(false)
            m.btnHomeN.setFocus(true)
            return true

             else if key = "up" and m.btnBWN.hasFocus()
            m.btnBWN.setFocus(false)
            m.btnMEN.setFocus(true)
            return true
            else if key = "up" and m.btnMEN.hasFocus()
            m.btnMEN.setFocus(false)
            m.btnARN.setFocus(true)
            return true
            else if key = "up" and m.btnARN.hasFocus()
            m.btnARN.setFocus(false)
            m.btnFFN.setFocus(true)
            return true
            else if key = "up" and m.btnFFN.hasFocus()
            m.btnFFN.setFocus(false)
            m.btnRSN.setFocus(true)
            return true
            else if key = "up" and m.btnRSN.hasFocus()
            m.btnRSN.setFocus(false)
            m.btnSettingN.setFocus(true)
            return true

        else if key = "up" and m.btnHomeN.hasFocus()
            m.btnHomeN.setFocus(false)
            m.btnSearchN.setFocus(true)
            return true


        else if key = "up" and m.btnSubN.hasFocus()
            m.btnSubN.setFocus(false)
            m.btnHomeN.setFocus(true)
            return true
        else if key = "up" and m.btnFavN.hasFocus()
            m.btnFavN.setFocus(false)
            m.btnSubN.setFocus(true)
            return true
        else if key = "up" and m.btnSettingN.hasFocus()
            m.btnSettingN.setFocus(false)
            m.btnFavN.setFocus(true)
            return true


        end if

        return result

    end if

end function