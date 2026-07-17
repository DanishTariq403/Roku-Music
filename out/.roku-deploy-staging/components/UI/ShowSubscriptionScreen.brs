sub ShowSubscriptionScreen()
    m.global.analytics.callFunc("logEvent", "subscription_screen_opened", {
            "screen_name": "OnboardingScreen"
        })
m.SubscriptionScreen = CreateObject("roSGNode","SUbscriptionScreen")
m.SubscriptionScreen.ObserveField("btnMonthlySelect","onbtnMonthlySelect")
m.SubscriptionScreen.ObserveField("btnYearlySelect","onbtnYearlySelect")
ShowScreen(m.SubscriptionScreen)
 
end sub

sub onbtnMonthlySelect()
    m.global.analytics.callFunc("logEvent", "monthly_product_selected", {
            "screen_name": "OnboardingScreen"
        })
    m.top.isSubYearly=false
    StartSubscription()

end sub

sub onbtnYearlySelect()
    m.global.analytics.callFunc("logEvent", "yearly_product_selected", {
            "screen_name": "OnboardingScreen"
        })
    m.top.isSubYearly=true
    StartSubscription()

end sub

function StartSubscription()
    ' function CheckSubscription(title as string, identifier as string, price as string)
'   if isSubscriptionExpire()<>false

    ' m.order_title = "Test_Product_1_Discounted"
    ' m.order_identifier = "Test_Product_1_Discounted"
    ' m.order_price = "1.99"
 if m.top.isSubDiscount
    m.order_title = "Music Premium Monthly Discount"
   m.order_identifier = "premium_monthly_discount"
    m.order_price = "2.99"
    
     
 
else if m.top.isSubYearly=false
   m.order_title = "Music Premium Monthly"
   m.order_identifier = "premium_monthly"
    m.order_price = "5.99"
    
    else
   m.order_title = "Music Premium Yearly"
   m.order_identifier = "premium_yearly"
    m.order_price = "49.99"
   
    


    end if

   m.global.AddField("channelStore", "node", false)
    m.global.channelStore = CreateObject("roSGNode", "ChannelStore")

    m.global.channelStore.observeField("requestPartnerOrderStatus", "requestPartnerOrderStatusChanged")
    m.global.channelStore.observeField("confirmPartnerOrderStatus", "confirmPartnerOrderStatusChanged")

   

    ValidateSubscription()

'   end if

end function

sub ValidateSubscription()

    m.orderInfo = createObject("roSGNode", "contentNode")
    m.orderInfo.priceDisplay = m.order_price
    m.orderInfo.price = m.order_price
    m.orderInfo.addField("code", "string", false)
    m.orderInfo.code = m.order_identifier

    m.global.channelStore.requestPartnerOrder = m.orderInfo
    m.global.channelStore.command = "requestPartnerOrder"

end sub


sub requestPartnerOrderStatusChanged()

   

    m.global.channelStore.command = "getUserData"
    m.global.channelStore.observefield("userData", "onGetUserData")

end sub


sub onGetUserData()

    if m.global.channelStore.userData <> invalid

        m.global.channelStore.command = "getPurchases"
        m.global.channelStore.ObserveField("purchases", "onGetPurchases")

    end if
end sub

sub onGetPurchases(event as object)

    m.global.channelStore.UnobserveField("purchases")
    purchases = event.GetData()

    ?"purchases "purchases.GetChildCount()


    if purchases.GetChildCount() > 0
        
        allPurchases = purchases.GetChildren(-1, 0)

        datetime = CreateObject("roDateTime")
        utimeNow = datetime.AsSeconds()

      
        for each purchase in allPurchases
            ?"purchase>  " purchase

            if purchase.code = m.order_identifier 'or purchase.code = "TikTok_Subscription"


                datetime.FromISO8601String(purchase.expirationDate)
                utimeExpire = datetime.AsSeconds()

                m.expireTime = utimeExpire.ToStr()

                ?"time now: " utimeNow.ToStr() " expire time: " utimeExpire.ToStr()
                ?"time now: " utimeNow " expire time: " utimeExpire
                
                if utimeExpire > utimeNow
                    ?"not expire ====================>> "
                    m.top.isSubscribed=true
                    ResetScreen()
                    dialogCheckProducts = CreateObject("roSGNode", "StandardMessageDialog")
                    dialogCheckProducts.title = "Subscribed Sucessfully. Please Conitnue Using this App"
                    m.top.dialog = dialogCheckProducts ' set dialog to MainScene


                  
                   
                    return
                else
                    ?"expire ========================>> "
                    
                    if purchase.freeTrialQuantity > 0
                        m.isProductWithExpiredTrial = true
                    end if
                end if

            end if

            ' retrieve expiration time in seconds from the string

        end for
    end if

    ?"purchases " purchases
    dialogCheckProducts = CreateObject("roSGNode", "StandardMessageDialog")
    dialogCheckProducts.title = "Please Wait while we fetch details"
    m.top.dialog = dialogCheckProducts ' set dialog to MainScene

    ' retrieve a catalog by calling channelStore command
    m.global.channelStore.command = "getCatalog"
    ' set an observer to be able to handle actions once loaded
    m.global.channelStore.ObserveField("catalog", "OnGetCatalog")

end sub



sub OnGetCatalog(event as object)

    ?"OnGetCatalog ========================>> "

    m.global.channelStore.UnobserveField("catalog")
    catalog = event.GetData() ' extract loaded catalog
    ' check if dialog hasn't been closed before by a user
    if m.top.dialog <> invalid
        m.top.dialog.close = true ' close previous dialog
    else
        return
    end if

    dialog = CreateObject("roSGNode", "Dialog")

    ?"catalog.GetChildCount() " catalog.GetChildCount()
    ' catalog items are appended as children, so we need to check if there are some
    if catalog.GetChildCount() > 0

        subscriptions = []
        m.activeCatalogItems = []
        for each product in catalog.GetChildren(-1, 0)

            ?"product => " product
            m.productType = ""
            if product.code = m.order_identifier

                if product.productType = "MonthlySub"
                    m.productType = "MonthlySub"
                else if m.productType="YearlySub"
                    m.productType = "YearlySub"
                end if
                subscriptions.Push(product.name + " " + product.cost)
                m.activeCatalogItems.Push({
                    code: product.code,
                    name: product.name
                })
            end if

        end for

        DoSubscriptionOrder()
      
    ' else
    '     ' no available subscription to get some
    '     dialog.title = "Error"
    '     dialog.message = "There are not any available products for now..."

    '     m.top.dialog = dialog ' Set dialog to MainScene
    end if



end sub

sub DoSubscriptionOrder()
    buttonSelectedIndex = m.top.dialog.buttonSelected
    catalogItem = m.activeCatalogItems[buttonSelectedIndex]

    order = CreateObject("roSGNode", "ContentNode")
    product = order.CreateChild("ContentNode")
    
    product.AddFields({ code: m.order_identifier, name: m.order_title, qty: 1 })

    ? "order " order
    m.global.channelStore.order = order

    m.global.channelStore.command = "doOrder"
    m.global.channelStore.ObserveField("orderStatus", "OnOrderStatus")


end sub

sub onDoneSelected()
    if m.dialog.buttonSelected = 0
        m.dialog.close = true
       
    end if
end sub


sub OnOrderStatus(event as object)
    orderStatus = event.GetData()

    
    if orderStatus <> invalid and orderStatus.status = 1
     
    m.global.analytics.callFunc("logEvent", "subscription_successful", {
            "screen_name": "OnboardingScreen"
        })
     
        onGetUserData()


    else
        ' otherwise show error dialog
        m.global.analytics.callFunc("logEvent", "subscription_canceled_or_failed", {
            "screen_name": "OnboardingScreen"
        })
    end if

    m.global.channelStore.UnobserveField("orderStatus")
end sub

function setUserData(expireTime as string)

    sec = CreateObject("roRegistrySection",m.global.appName + "UserSubscriptionData")
    sec.Write(m.global.appName +"subscription_expire_time", expireTime)
    sec.Flush()

end function