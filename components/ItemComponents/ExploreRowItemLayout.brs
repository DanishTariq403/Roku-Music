function GetExploreLayoutConfig(layout as string) as object
    if layout = "era"
        return {
            rowSize: [346, 196]
            rowSpacing: [16, 0]
            rowHeight: 228
            focusUri: "pkg:/images/eraFocus.png"
            maskUri: "pkg:/images/squareMask.png"
            focusTranslation: [0, 0]
            focusSize: [346, 196]
            bgMaskTranslation: [0, 0]
            maskSize: [330, 180]
            bgTranslation: [0, 0]
            bgSize: [330, 180]
            overlayUri: ""
            overlayTranslation: [0, 0]
            overlaySize: [330, 180]
            overlayVisible: false
            eraUseColor: true
            eraBgColor: "0x1E1E1EFF"
            moodUseColor: true
            moodBgTranslation: [8, 8]
            moodBgSize: [330, 180]
            emojiTranslation: [0, 0]
            emojiWidth: 0
            emojiHeight: 0
            eraTitleTranslation: [24, 36]
            eraTitleWidth: 280
            eraTitleHeight: 80
            eraTitleFontSize: 56
            eraTitleHorizAlign: "center"
            eraTitleColor: "#FFFFFF"
            eraSubtitleTranslation: [106, 117]
            eraSubtitleWidth: 280
            eraSubtitleHeight: 32
            eraSubtitleFontSize: 18
            subtitleVisible: true
            badgeShow: false
            rankShow: false
        }
    end if

    return TightenExploreRowLayout(GetLayoutConfig(layout))
end function

function TightenExploreRowLayout(cfg as object) as object
    if cfg = invalid then return cfg

    rowLabelSpace = 32
    if cfg.rowSize <> invalid and cfg.rowSize.Count() >= 2
        cfg.rowHeight = cfg.rowSize[1] + rowLabelSpace
    end if

    if cfg.rowSpacing <> invalid and cfg.rowSpacing.Count() >= 2
        cfg.rowSpacing = [cfg.rowSpacing[0], 0]
    end if

    return cfg
end function

' Badge positions for recommended/newReleases: edit ApplySectionBadgeOverrides()
' in SingleRowItemLayout.brs (shared with Home SingleRowItem).
function GetExploreItemLayoutForSection(layout as string, sectionId as string) as object
    cfg = GetExploreLayoutConfig(layout)
    if cfg = invalid then return cfg

    if layout = "badge" and sectionId <> invalid and sectionId <> ""
        cfg = ApplySectionBadgeOverrides(cfg, sectionId)
    end if

    return cfg
end function

function GetExploreRowLayoutForSection(layout as string) as object
    cfg = GetExploreLayoutConfig(layout)
    return {
        size: cfg.rowSize
        spacing: cfg.rowSpacing
        height: cfg.rowHeight
    }
end function

sub AppendExploreRowLayoutArrays(layout as string, rowItemSizes as object, rowItemSpacings as object, rowHeights as object)
    layoutInfo = GetExploreRowLayoutForSection(layout)
    rowItemSizes.Push(layoutInfo.size)
    rowItemSpacings.Push(layoutInfo.spacing)
    rowHeights.Push(layoutInfo.height)
end sub

function BuildExploreRowLayoutArrays(sectionOrder as object, sections as object) as object
    rowItemSizes = []
    rowItemSpacings = []
    rowHeights = []

    for each sectionId in sectionOrder
        if sectionId = invalid then continue for

        section = sections[sectionId]
        if section = invalid or section.items = invalid or section.items.Count() = 0
            continue for
        end if

        layout = section.layout
        if layout = invalid then layout = "square"

        AppendExploreRowLayoutArrays(layout, rowItemSizes, rowItemSpacings, rowHeights)
    end for

    return {
        rowItemSize: rowItemSizes
        rowItemSpacing: rowItemSpacings
        rowHeights: rowHeights
    }
end function
