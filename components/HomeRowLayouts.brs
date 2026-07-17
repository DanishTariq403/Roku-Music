' ---------------------------------------------------------------------------
' HOME ROW LAYOUT CONFIG
' Edit GetLayoutConfig() below — one block per row type.
' RowList uses: rowSize, rowSpacing, rowHeight
' SingleRowItem uses: everything else (bg, mask, title, subtitle, badge, overlay, focus)
' ---------------------------------------------------------------------------

function GetLayoutConfig(layout as string) as object
    if layout = "square"
        return {
            rowSize: [262, 262]
            rowSpacing: [27, 50]
            rowHeight: 400
            focusUri: "pkg:/images/squareFocus.png"
            maskUri: "pkg:/images/squareMask.png"
            focusTranslation: [0, 0]
            focusSize: [262, 262]
            bgMaskTranslation: [0, 0]
            maskSize: [262, 262]
            bgTranslation: [0, 0]
            bgSize: [262, 262]
            overlayUri: ""
            overlayTranslation: [0, 0]
            overlaySize: [262, 262]
            overlayVisible: false
            titleTranslation: [0, 226]
            titleWidth: 262
            titleHeight: 30
            titleFontSize: 20
            titleHorizAlign: "left"
            subtitleTranslation: [0, 254]
            subtitleWidth: 262
            subtitleHeight: 24
            subtitleFontSize: 16
            subtitleVisible: false
            badgeTranslation: [8, 8]
            badgeWidth: 90
            badgeHeight: 28
            badgeFontSize: 14
        }
    else if layout = "ranked"
        return {
            rowSize: [326, 212]
            rowSpacing: [24, 50]
            rowHeight: 400
            focusUri: "pkg:/images/rankedFocus.png"
            maskUri: "pkg:/images/rankedMask.png"
            focusTranslation: [0, 0]
            focusSize: [326, 212]
            bgMaskTranslation: [8, 8]
            maskSize: [310, 132]
            bgTranslation: [0, 0]
            bgSize: [310, 132]
            overlayUri: ""
            overlayTranslation: [8, 8]
            overlaySize: [310, 132]
            overlayVisible: false
            titleTranslation: [8, 148]
            titleWidth: 294
            titleHeight: 30
            titleFontSize: 20
            titleHorizAlign: "left"
            subtitleTranslation: [8, 176]
            subtitleWidth: 294
            subtitleHeight: 24
            subtitleFontSize: 16
            subtitleVisible: true
            badgeTranslation: [8, 8]
            badgeWidth: 90
            badgeHeight: 28
            badgeFontSize: 14
        }
    else if layout = "badge"
        return {
            rowSize: [278, 262]
            rowSpacing: [16, 50]
            rowHeight: 400
            focusUri: "pkg:/images/badgeFocus.png"
            maskUri: "pkg:/images/badgeMask.png"
            focusTranslation: [0, 0]
            focusSize: [278, 262]
            bgMaskTranslation: [8, 8]
            maskSize: [262, 184]
            bgTranslation: [0, 0]
            bgSize: [262, 184]
            overlayUri: ""
            overlayTranslation: [8, 8]
            overlaySize: [262, 184]
            overlayVisible: false
            titleTranslation: [20, 212]
            titleWidth: 254
            titleHeight: 30
            titleFontSize: 18
            titleHorizAlign: "left"
            subtitleTranslation: [20, 235]
            subtitleWidth: 254
            subtitleHeight: 30
            subtitleFontSize: 16
            subtitleVisible: true
            badgeTranslation: [8, 8]
            badgeWidth: 90
            badgeHeight: 28
            badgeFontSize: 14
        }
    else if layout = "recent"
        return {
            rowSize: [262, 262]
            rowSpacing: [16, 50]
            rowHeight: 400
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
            badgeTranslation: [8, 8]
            badgeWidth: 90
            badgeHeight: 28
            badgeFontSize: 14
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
            titleTranslation: [0, 60]
            titleWidth: 278
            titleHeight: 30
            titleFontSize: 20
            titleHorizAlign: "center"
            subtitleTranslation: [0, 90]
            subtitleWidth: 278
            subtitleHeight: 24
            subtitleFontSize: 16
            subtitleVisible: false
            badgeTranslation: [8, 8]
            badgeWidth: 90
            badgeHeight: 28
            badgeFontSize: 14
        }
    else if layout = "artist"
        return {
            rowSize: [326, 261]
            rowSpacing: [0, 50]
            rowHeight: 400
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
            titleFontSize: 20
            titleHorizAlign: "center"
            subtitleTranslation: [0, 248]
            subtitleWidth: 326
            subtitleHeight: 24
            subtitleFontSize: 16
            subtitleVisible: false
            badgeTranslation: [8, 8]
            badgeWidth: 90
            badgeHeight: 28
            badgeFontSize: 14
        }
    else if layout = "album"
        return {
            rowSize: [278, 278]
            rowSpacing: [16, 50]
            rowHeight: 400
            focusUri: "pkg:/images/albumFocus.png"
            maskUri: "pkg:/images/albumMask.png"
            focusTranslation: [0, 0]
            focusSize: [278, 278]
            bgMaskTranslation: [8, 8]
            maskSize: [262, 262]
            bgTranslation: [0, 0]
            bgSize: [262, 262]
            overlayUri: ""
            overlayTranslation: [8, 8]
            overlaySize: [262, 262]
            overlayVisible: false
            titleTranslation: [8, 200]
            titleWidth: 246
            titleHeight: 30
            titleFontSize: 20
            titleHorizAlign: "left"
            subtitleTranslation: [8, 228]
            subtitleWidth: 246
            subtitleHeight: 24
            subtitleFontSize: 16
            subtitleVisible: true
            badgeTranslation: [8, 8]
            badgeWidth: 90
            badgeHeight: 28
            badgeFontSize: 14
        }
    else if layout = "chart"
        return {
            rowSize: [326, 88]
            rowSpacing: [16, 50]
            rowHeight: 200
            focusUri: "pkg:/images/rankedFocus.png"
            maskUri: "pkg:/images/rankedMask.png"
            focusTranslation: [0, 0]
            focusSize: [326, 88]
            bgMaskTranslation: [0, 0]
            maskSize: [88, 88]
            bgTranslation: [0, 0]
            bgSize: [88, 88]
            overlayUri: ""
            overlayTranslation: [0, 0]
            overlaySize: [88, 88]
            overlayVisible: false
            titleTranslation: [100, 10]
            titleWidth: 220
            titleHeight: 30
            titleFontSize: 20
            titleHorizAlign: "left"
            subtitleTranslation: [100, 40]
            subtitleWidth: 220
            subtitleHeight: 24
            subtitleFontSize: 16
            subtitleVisible: true
            badgeTranslation: [8, 8]
            badgeWidth: 90
            badgeHeight: 28
            badgeFontSize: 14
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

function GetItemLayoutForSection(layout as string) as object
    return GetLayoutConfig(layout)
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
