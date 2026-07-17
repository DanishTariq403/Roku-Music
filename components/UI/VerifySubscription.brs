sub VerifySubscription()

    m.order_title = "Music Premium Monthly"
    m.order_identifier = "premium_monthly"
    m.order_price = "5.99"


    m.global.AddField("channelStorecheck", "node", false)
    m.global.channelStorecheck = CreateObject("roSGNode", "ChannelStore")
    m.global.channelStorecheck.command = "getAllPurchases"
    m.global.channelStorecheck.ObserveField("purchases", "onGetPurchasesForChecking")

end sub
sub onGetPurchasesForChecking(event as object)

    ?"onGetPurchasesForChecking"
    m.global.channelStorecheck.UnobserveField("purchases")
    purchases = event.GetData()
    flag = 0
    if purchases.GetChildCount() > 0
        ?" in VS 1"
        allPurchases = purchases.GetChildren(-1, 0)
        datetime = CreateObject("roDateTime")
        utimeNow = datetime.AsSeconds()


        for each purchase in allPurchases


            if purchase.code = m.order_identifier or purchase.code = "premium_yearly" or purchase.code="premium_monthly_discount"


                datetime.FromISO8601String(purchase.expirationDate)
                utimeExpire = datetime.AsSeconds()
                m.expireTime = utimeExpire.ToStr()

                if utimeExpire > utimeNow

                    m.top.isSubscribed = true
                     m.VideoArrayGetter = CreateObject("roSGNode", "GetJsonTask")
        m.VideoArrayGetter.ObserveField("content", "SetContent")
        m.VideoArrayGetter.control = "RUN"


                    return
                else if purchase.inDunning = "true"
                    request = {}
                    request.command = "DoRecovery"
                    m.store = CreateObject("roSGNode", "ChannelStore")
                    m.store.observeField("requestStatus", "onRequestStatus")
                    m.store.request = request




                    return


                else

                    m.top.isSubscribed = false
 m.VideoArrayGetter = CreateObject("roSGNode", "GetJsonTask")
        m.VideoArrayGetter.ObserveField("content", "SetContent")
        m.VideoArrayGetter.control = "RUN"
                    return




                end if
            else
                m.top.isSubscribed=false
                



            end if
        end for
    else

        m.top.isSubscribed = false


    end if




 m.VideoArrayGetter = CreateObject("roSGNode", "GetJsonTask")
        m.VideoArrayGetter.ObserveField("content", "SetContent")
        m.VideoArrayGetter.control = "RUN"



end sub

sub SetContent()

    m.videosArray = m.VideoArrayGetter.content
    m.global.videoArray = m.videosArray
    m.top.currentCategory="All"
    ShowHomeScreen()
end sub

function onRequestStatus()
    print "onRequestStatus"
    requestStatus = m.store.requestStatus
    if requestStatus = invalid
        m.top.isSubscribed = false
    else if requestStatus.status <> 1
        m.top.isSubscribed = false
    else
        VerifySubscription()
    end if
end function