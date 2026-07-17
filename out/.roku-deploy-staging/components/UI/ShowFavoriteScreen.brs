sub ShowFavoriteScreen()
 m.FavoriteScreen = CreateObject("roSGNode","FavoriteScreen")
m.FavoriteScreen.observeField("btnBackSelected","ResetScreen")
    ShowScreen(m.FavoriteScreen)
end sub