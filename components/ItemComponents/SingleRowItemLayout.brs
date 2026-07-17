' ---------------------------------------------------------------------------
' SingleRowItem layout config — edit GetLayoutConfig() below.
'
' Badge (red rect + label) — set badgeShow: true and configure:
'   badgeBgTranslation, badgeBgWidth, badgeBgHeight, badgeBgColor
'   badgeTranslation, badgeWidth, badgeHeight, badgeFontSize, badgeHorizAlign
'   Shown only for: trendingNow (ranked), recommended (badge), newReleases (badge)
'   Recommended vs newReleases badge positions: edit ApplySectionBadgeOverrides()
'
' Rank label (Top Charts) — set rankShow: true and configure:
'   rankTranslation, rankWidth, rankHeight, rankFontSize, rankColor, rankHorizAlign
'
' Mood colors — edit GetMoodColor() at bottom of this file.
' ---------------------------------------------------------------------------

function GetLayoutConfig(layout as string) as object
    if layout = "square"
        return {
            rowSize: [278, 278]
            rowSpacing: [16, 50]
            rowHeight: 300
            focusUri: "pkg:/images/squareFocus.png"
            maskUri: "pkg:/images/squareMask.png"
            focusTranslation: [0, 0]
            focusSize: [278, 278]
            bgMaskTranslation: [8, 8]
            maskSize: [262, 262]
            bgTranslation: [0, 0]
            bgSize: [262, 262]
            overlayUri: "pkg:/images/meta.png"
            overlayTranslation: [0, 226]
            overlaySize: [278, 52]
            overlayVisible: true
            titleTranslation: [20, 219]
            titleWidth: 254
            titleHeight: 30
            titleFontSize: 18
            titleHorizAlign: "left"
            subtitleTranslation: [20, 245]
            subtitleWidth: 254
            subtitleHeight: 24
            subtitleFontSize: 14
            subtitleVisible: true
            badgeShow: false
            rankShow: false
        }
    else if layout = "ranked"
        return {
            rowSize: [326, 212]
            rowSpacing: [16, 0]
            rowHeight: 320
            focusUri: "pkg:/images/rankedFocus.png"
            maskUri: "pkg:/images/rankedMask.png"
            focusTranslation: [0, 0]
            focusSize: [326, 212]
            bgMaskTranslation: [8, 8]
            maskSize: [310, 132]
            bgTranslation: [0, 0]
            bgSize: [310, 132]
            overlayUri: "pkg:/images/chartItemBG.png"
            overlayTranslation: [8, 140]
            overlaySize: [310, 64]
            overlayVisible: true
            titleTranslation: [20, 145]
            titleWidth: 234
            titleHeight: 40
            titleFontSize: 18
            titleHorizAlign: "left"
            subtitleTranslation: [20, 178]
            subtitleWidth: 234
            subtitleHeight: 40
            subtitleFontSize: 16
            subtitleVisible: true
            badgeShow: true
            rankShow: false
            badgeBgTranslation: [233, 124]
            badgeBgWidth: 74
            badgeBgHeight: 70
            badgeBgColor: "#D40F20"
            badgeTranslation: [233, 124]
            badgeWidth: 74
            badgeHeight: 70
            badgeFontSize: 54
            badgeHorizAlign: "center"
        }
    else if layout = "badge"
        return {
            rowSize: [278, 262]
            rowSpacing: [16, 0]
            rowHeight: 320
            focusUri: "pkg:/images/badgeFocus.png"
            maskUri: "pkg:/images/badgeMask.png"
            focusTranslation: [0, 0]
            focusSize: [278, 262]
            bgMaskTranslation: [8, 8]
            maskSize: [262, 184]
            bgTranslation: [0, 0]
            bgSize: [262, 184]
            overlayUri: "pkg:/images/chartBGitem.png"
            overlayTranslation: [8, 200]
            overlaySize: [262, 46]
            overlayVisible: true
            titleTranslation: [8, 196]
            titleWidth: 238
            titleHeight: 30
            titleFontSize: 18
            titleHorizAlign: "left"
            subtitleTranslation: [8, 224]
            subtitleWidth: 238
            subtitleHeight: 30
            subtitleFontSize: 16
            subtitleVisible: true
            badgeShow: true
            rankShow: false
            badgeBgTranslation: [16, 16]
            badgeBgWidth: 100
            badgeBgHeight: 28
            badgeBgColor: "#D40F20"
            badgeTranslation: [16, 16]
            badgeWidth: 100
            badgeHeight: 28
            badgeFontSize: 12
            badgeHorizAlign: "center"
        }
    else if layout = "continue"
        return {
            rowSize: [278, 262]
            rowSpacing: [16, 0]
            rowHeight: 320
            focusUri: "pkg:/images/badgeFocus.png"
            maskUri: "pkg:/images/badgeMask.png"
            focusTranslation: [0, 0]
            focusSize: [278, 262]
            bgMaskTranslation: [8, 8]
            maskSize: [262, 184]
            bgTranslation: [0, 0]
            bgSize: [262, 184]
            overlayUri: "pkg:/images/GOL.png"
            overlayTranslation: [8, 184]
            overlaySize: [262, 46]
            overlayVisible: true
            titleTranslation: [8, 196]
            titleWidth: 238
            titleHeight: 30
            titleFontSize: 18
            titleHorizAlign: "left"
            subtitleTranslation: [8, 219]
            subtitleWidth: 238
            subtitleHeight: 30
            subtitleFontSize: 16
            subtitleVisible: true
            badgeShow: false
            rankShow: false
            progressShow: true
            progressTranslation: [8, 252]
            progressWidth: 238
            progressHeight: 4
        }
    else if layout = "recent"
        return {
            rowSize: [262, 262]
            rowSpacing: [16, 50]
            rowHeight: 300
            focusUri: "pkg:/images/recentFocus.png"
            maskUri: "pkg:/images/recentMask.png"
            focusTranslation: [0, 0]
            focusSize: [262, 262]
            bgMaskTranslation: [8, 8]
            maskSize: [246, 140]
            bgTranslation: [0, 0]
            bgSize: [246, 140]
            overlayUri: ""
            overlayTranslation: [8, 8]
            overlaySize: [246, 140]
            overlayVisible: false
            titleTranslation: [8, 156]
            titleWidth: 246
            titleHeight: 30
            titleFontSize: 20
            titleHorizAlign: "left"
            subtitleTranslation: [8, 184]
            subtitleWidth: 246
            subtitleHeight: 24
            subtitleFontSize: 16
            subtitleVisible: true
            badgeShow: false
            rankShow: false
        }
    else if layout = "mood"
        return {
            rowSize: [278, 160]
            rowSpacing: [16, 50]
            rowHeight: 300
            focusUri: "pkg:/images/squareFocus.png"
            maskUri: "pkg:/images/squareMask.png"
            focusTranslation: [0, 0]
            focusSize: [278, 160]
            bgMaskTranslation: [0, 0]
            maskSize: [278, 160]
            bgTranslation: [0, 0]
            bgSize: [278, 160]
            overlayUri: ""
            overlayTranslation: [0, 0]
            overlaySize: [278, 160]
            overlayVisible: false
            moodUseColor: true
            moodBgTranslation: [0, 0]
            moodBgSize: [278, 160]
            emojiTranslation: [119, 48]
            emojiWidth: 40
            emojiHeight: 40
            emojiSize: 32
            emojiHorizAlign: "center"
            emojiVertAlign: "center"
            titleTranslation: [0, 96]
            titleWidth: 278
            titleHeight: 30
            titleFontSize: 20
            titleHorizAlign: "center"
            moodTitleColor: "#FFFFFF"
            subtitleTranslation: [0, 90]
            subtitleWidth: 278
            subtitleHeight: 24
            subtitleFontSize: 16
            subtitleVisible: false
            badgeShow: false
            rankShow: false
        }
    else if layout = "artist"
        return {
            rowSize: [326, 261]
            rowSpacing: [0, 0]
            rowHeight: 300
            focusUri: "pkg:/images/artistFocus.png"
            maskUri: "pkg:/images/artistMask.png"
            focusTranslation: [63, 8]
            focusSize: [200, 200]
            bgMaskTranslation: [63, 8]
            maskSize: [200, 200]
            bgTranslation: [0, 0]
            bgSize: [200, 200]
            overlayUri: ""
            overlayTranslation: [63, 8]
            overlaySize: [200, 200]
            overlayVisible: false
            titleTranslation: [0, 218]
            titleWidth: 326
            titleHeight: 30
            titleFontSize: 18
            titleHorizAlign: "center"
            subtitleTranslation: [0, 248]
            subtitleWidth: 326
            subtitleHeight: 24
            subtitleFontSize: 16
            subtitleVisible: false
            badgeShow: false
            rankShow: false
        }
    else if layout = "album"
        return {
            rowSize: [278, 278]
            rowSpacing: [16, 50]
            rowHeight: 300
            focusUri: "pkg:/images/albumFocus.png"
            maskUri: "pkg:/images/albumMask.png"
            focusTranslation: [0, 0]
            focusSize: [278, 278]
            bgMaskTranslation: [8, 8]
            maskSize: [262, 262]
            bgTranslation: [0, 0]
            bgSize: [262, 194]
            overlayUri: "pkg:/images/chartItemBG.png"
            overlayTranslation: [8, 202]
            overlaySize: [262, 66]
            overlayVisible: true
            titleTranslation: [8, 216]
            titleWidth: 254
            titleHeight: 30
            titleFontSize: 20
            titleHorizAlign: "left"
            subtitleTranslation: [8, 245]
            subtitleWidth: 254
            subtitleHeight: 30
            subtitleFontSize: 16
            subtitleVisible: true
            badgeShow: false
            rankShow: false
        }
    else if layout = "chart"
        return {
            rowSize: [326, 88]
            rowSpacing: [16, 50]
            rowHeight: 200
            focusUri: "pkg:/images/chartFocus.png"
            maskUri: "pkg:/images/rankedMask.png"
            focusTranslation: [0, 0]
            focusSize: [326, 88]
            itemBgUri: "pkg:/images/chartItemBg.png"
            itemBgTranslation: [0, 0]
            itemBgSize: [326, 88]
            itemBgVisible: true
            bgMaskTranslation: [48, 0]
            maskSize: [88, 80]
            bgTranslation: [0, 0]
            bgSize: [88, 80]
            overlayUri: "pkg:/images"
            overlayTranslation: [0, 0]
            overlaySize: [88, 88]
            overlayVisible: true
            titleTranslation: [148, 18]
            titleWidth: 158
            titleHeight: 30
            titleFontSize: 20
            titleHorizAlign: "left"
            subtitleTranslation: [148, 45]
            subtitleWidth: 158
            subtitleHeight: 30
            subtitleFontSize: 16
            subtitleVisible: true
            badgeShow: false
            rankShow: true
            rankTranslation: [8, 8]
            rankWidth: 48
            rankHeight: 80
            rankFontSize: 32
            rankColor: "#FFFFFF"
            rankHorizAlign: "left"
        }
    end if

    return GetLayoutConfig("square")
end function

function GetRowLayoutForSection(layout as string) as object
    cfg = GetLayoutConfig(layout)
    return {
        size: cfg.rowSize
        spacing: cfg.rowSpacing
        height: cfg.rowHeight
    }
end function

function GetItemLayoutForSection(layout as string, sectionId as string) as object
    cfg = GetLayoutConfig(layout)
    if cfg = invalid then return cfg

    if layout = "badge" and sectionId <> invalid and sectionId <> ""
        cfg = ApplySectionBadgeOverrides(cfg, sectionId)
    end if

    return cfg
end function

function ApplySectionBadgeOverrides(cfg as object, sectionId as string) as object
    if cfg = invalid then return cfg
    if cfg.badgeShow <> true then return cfg

    if sectionId = "recommended"
        cfg.badgeBgTranslation = [8, 8]
        cfg.badgeTranslation = [8, 8]
        cfg.badgeBgWidth = 154
        cfg.badgeBgHeight = 25
        cfg.badgeWidth = 154
        cfg.badgeHeight = 25
        cfg.badgeFontSize = 11
        cfg.badgeHorizAlign = "center"
    else if sectionId = "newReleases"
        cfg.badgeBgTranslation = [200, 20]
        cfg.badgeTranslation = [200, 20]
        cfg.badgeBgWidth = 54
        cfg.badgeBgHeight = 29
        cfg.badgeWidth = 54
        cfg.badgeHeight = 29
        cfg.badgeFontSize = 12
        cfg.badgeHorizAlign = "center"
    end if

    return cfg
end function

sub AppendRowLayoutArrays(layout as string, rowItemSizes as object, rowItemSpacings as object, rowHeights as object)
    layoutInfo = GetRowLayoutForSection(layout)
    rowItemSizes.Push(layoutInfo.size)
    rowItemSpacings.Push(layoutInfo.spacing)
    rowHeights.Push(layoutInfo.height)
end sub

function BuildHomeRowLayoutArrays(sectionOrder as object, sections as object) as object
    rowItemSizes = []
    rowItemSpacings = []
    rowHeights = []

    for each sectionId in sectionOrder
        if sectionId = invalid or sectionId = "hero" then continue for

        section = sections[sectionId]
        if section = invalid or section.items = invalid or section.items.Count() = 0
            continue for
        end if

        AppendRowLayoutArrays(section.layout, rowItemSizes, rowItemSpacings, rowHeights)
    end for

    return {
        rowItemSize: rowItemSizes
        rowItemSpacing: rowItemSpacings
        rowHeights: rowHeights
    }
end function

function GetMoodColor(moodName as string) as string
    colors = {
        "Peaceful": "#FFD60A"
        "Energizing": "#0A84FF"
        "Romantic": "#FF6B35"
        "Melancholy": "#BF5AF2"
        "Upbeat": "#1C2E4A"
        "Cool": "#FF2D55"
        "Happy": "0xFFD700FF"
        "Chill": "0x1E6FD9FF"
        "Workout": "0xFF6B00FF"
        "Focus": "0x6B3FA0FF"
        "Sleep": "0x1A2B4AFF"
    }

    if moodName <> invalid and colors.DoesExist(moodName)
        return colors[moodName]
    end if

    return "0x333355FF"
end function

function GetMoodEmoji(moodName as string) as string
    emojis = {
        "Peaceful": "😌"
        "Energizing": "⚡"
        "Romantic": "💕"
        "Melancholy": "🌧"
        "Upbeat": "🎉"
        "Cool": "😎"
        "Happy": "😊"
        "Chill": "🎧"
        "Workout": "💪"
        "Focus": "🎯"
        "Sleep": "😴"
    }

    if moodName <> invalid and emojis.DoesExist(moodName)
        return emojis[moodName]
    end if

    return "🎵"
end function

function ShuffleArray(arr as object) as object
    if arr = invalid or Type(arr) <> "roArray" then return []
    count = arr.Count()
    if count <= 1 then return arr

    shuffled = []
    for i = 0 to count - 1
        shuffled.Push(arr[i])
    end for

    for i = count - 1 to 1 step -1
        j = Rnd(i + 1)
        temp = shuffled[i]
        shuffled[i] = shuffled[j]
        shuffled[j] = temp
    end for

    return shuffled
end function

function ShouldShuffleSectionItems(sectionId as string) as boolean
    if sectionId = invalid or sectionId = "" then return false
    if sectionId = "hero" then return false
    if sectionId = "trendingNow" then return false
    if sectionId = "topCharts" then return false
    return true
end function
