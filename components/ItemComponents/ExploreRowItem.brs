sub init()
    m.scene = m.top.getScene()
    m.bgMask = m.top.findNode("bgMask")
    m.moodBg = m.top.findNode("moodBg")
    m.moodEmoji = m.top.findNode("moodEmoji")
    m.bg = m.top.findNode("bg")
    m.title = m.top.findNode("title")
    m.titleFont = m.title.font
    m.badgeBg = m.top.findNode("badgeBg")
    m.badge = m.top.findNode("badge")
    m.badgeFont = m.badge.font
    m.rank = m.top.findNode("rank")
    m.rankFont = m.rank.font
    m.subtitle = m.top.findNode("subtitle")
    m.subtitleFont = m.subtitle.font
    m.focus = m.top.findNode("focus")
    m.overlay = m.top.findNode("overlay")
    m.eraTitle = m.top.findNode("eraTitle")
    m.eraTitleFont = m.eraTitle.font
    m.eraSubtitle = m.top.findNode("eraSubtitle")
    m.eraSubtitleFont = m.eraSubtitle.font
    m.currentLayout = "square"
    m.layoutCfg = invalid

    m.focusSyncTimer = m.top.createChild("Timer")
    m.focusSyncTimer.duration = 0.01
    m.focusSyncTimer.repeat = false
    m.focusSyncTimer.observeField("fire", "onFocusSyncTimer")
end sub

sub onItemContent()
    m.itemContent = m.top.itemContent
    if m.itemContent = invalid then return

    layout = m.itemContent.sectionLayout
    if layout = invalid
        layout = "square"
    end if

    m.currentLayout = layout
    sectionId = ""
    if m.itemContent.sectionId <> invalid
        sectionId = m.itemContent.sectionId
    end if
    m.layoutCfg = GetExploreItemLayoutForSection(layout, sectionId)
    applyUnfocusedState()
    applyLayout()
    bindContent()
    showFocus()
    queueFocusSync()
end sub

sub applyLayout()
    cfg = m.layoutCfg
    if cfg = invalid then return

    m.focus.translation = cfg.focusTranslation
    m.focus.width = cfg.focusSize[0]
    m.focus.height = cfg.focusSize[1]
    m.focus.uri = getConfigUri(cfg, "focusUri", "Focus")

    m.bgMask.translation = cfg.bgMaskTranslation
    m.bgMask.maskSize = cfg.maskSize
    m.bgMask.maskUri = getConfigUri(cfg, "maskUri", "Mask")

    m.bg.translation = cfg.bgTranslation
    m.bg.width = cfg.bgSize[0]
    m.bg.height = cfg.bgSize[1]
    m.bg.visible = true

    m.moodBg.visible = false
    m.moodEmoji.visible = false
    if cfg.moodUseColor = true
        m.moodBg.translation = cfg.moodBgTranslation
        m.moodBg.width = cfg.moodBgSize[0]
        m.moodBg.height = cfg.moodBgSize[1]
        if cfg.emojiTranslation <> invalid
            m.moodEmoji.translation = cfg.emojiTranslation
        end if
        if cfg.emojiWidth <> invalid
            m.moodEmoji.width = cfg.emojiWidth
        end if
        if cfg.emojiHeight <> invalid
            m.moodEmoji.height = cfg.emojiHeight
        end if
        if cfg.emojiSize <> invalid
            m.moodEmoji.emojiSize = cfg.emojiSize
        end if
        if cfg.emojiHorizAlign <> invalid
            m.moodEmoji.horizAlign = cfg.emojiHorizAlign
        end if
        if cfg.emojiVertAlign <> invalid
            m.moodEmoji.vertAlign = cfg.emojiVertAlign
        end if
        if cfg.moodTitleColor <> invalid
            m.title.color = cfg.moodTitleColor
        end if
    end if

    m.overlay.translation = [0, 0]
    m.overlay.width = 0
    m.overlay.height = 0
    if cfg.overlayTranslation <> invalid
        m.overlay.translation = cfg.overlayTranslation
    end if
    if cfg.overlaySize <> invalid
        m.overlay.width = cfg.overlaySize[0]
        m.overlay.height = cfg.overlaySize[1]
    end if
    if cfg.overlayUri <> invalid and cfg.overlayUri <> ""
        m.overlay.uri = cfg.overlayUri
        if cfg.overlayVisible = true
            m.overlay.visible = true
        end if
    else
        m.overlay.uri = ""
        m.overlay.visible = false
    end if

    if m.currentLayout <> "era"
        if cfg.titleTranslation <> invalid
            m.title.translation = cfg.titleTranslation
        end if
        if cfg.titleWidth <> invalid
            m.title.width = cfg.titleWidth
        end if
        if cfg.titleHeight <> invalid
            m.title.height = cfg.titleHeight
        end if
        if cfg.titleHorizAlign <> invalid
            m.title.horizAlign = cfg.titleHorizAlign
        end if
        if m.titleFont <> invalid and cfg.titleFontSize <> invalid
            m.titleFont.size = cfg.titleFontSize
        end if

        if cfg.subtitleTranslation <> invalid
            m.subtitle.translation = cfg.subtitleTranslation
        end if
        if cfg.subtitleWidth <> invalid
            m.subtitle.width = cfg.subtitleWidth
        end if
        if cfg.subtitleHeight <> invalid
            m.subtitle.height = cfg.subtitleHeight
        end if
        if m.subtitleFont <> invalid and cfg.subtitleFontSize <> invalid
            m.subtitleFont.size = cfg.subtitleFontSize
        end if
        if cfg.subtitleVisible = true
            m.subtitle.visible = true
        else
            m.subtitle.visible = false
        end if
    end if

    if m.currentLayout = "era"
        applyEraLabelLayout(cfg)
    else
        if m.eraTitle <> invalid then m.eraTitle.visible = false
        if m.eraSubtitle <> invalid then m.eraSubtitle.visible = false
        m.title.visible = true
    end if

    m.badgeBg.visible = false
    m.badge.visible = false
    if cfg.badgeShow = true
        m.badgeBg.translation = cfg.badgeBgTranslation
        m.badgeBg.width = cfg.badgeBgWidth
        m.badgeBg.height = cfg.badgeBgHeight
        if cfg.badgeBgColor <> invalid
            m.badgeBg.color = cfg.badgeBgColor
        end if
        m.badge.translation = cfg.badgeTranslation
        m.badge.width = cfg.badgeWidth
        m.badge.height = cfg.badgeHeight
        if cfg.badgeHorizAlign <> invalid
            m.badge.horizAlign = cfg.badgeHorizAlign
        end if
        if cfg.badgeFontSize <> invalid
            badgeFont = m.badgeFont
            if badgeFont = invalid and m.badge <> invalid
                badgeFont = m.badge.font
            end if
            if badgeFont <> invalid
                badgeFont.size = cfg.badgeFontSize
            end if
        end if
    end if

    m.rank.visible = false
    if cfg.rankShow = true
        m.rank.translation = cfg.rankTranslation
        m.rank.width = cfg.rankWidth
        m.rank.height = cfg.rankHeight
        if cfg.rankHorizAlign <> invalid
            m.rank.horizAlign = cfg.rankHorizAlign
        end if
        if cfg.rankColor <> invalid
            m.rank.color = cfg.rankColor
        end if
        if cfg.rankFontSize <> invalid
            rankFont = m.rankFont
            if rankFont = invalid and m.rank <> invalid
                rankFont = m.rank.font
            end if
            if rankFont <> invalid
                rankFont.size = cfg.rankFontSize
            end if
        end if
    end if
end sub

sub applyEraLabelLayout(cfg as object)
    m.title.visible = false
    m.subtitle.visible = false
    m.eraTitle.visible = true
    m.eraSubtitle.visible = true

    if cfg.eraTitleTranslation <> invalid
        m.eraTitle.translation = cfg.eraTitleTranslation
    end if
    if cfg.eraTitleWidth <> invalid
        m.eraTitle.width = cfg.eraTitleWidth
    end if
    if cfg.eraTitleHeight <> invalid
        m.eraTitle.height = cfg.eraTitleHeight
    end if
    if cfg.eraTitleHorizAlign <> invalid
        m.eraTitle.horizAlign = cfg.eraTitleHorizAlign
    end if
    if m.eraTitleFont <> invalid and cfg.eraTitleFontSize <> invalid
        m.eraTitleFont.size = cfg.eraTitleFontSize
    end if
    if cfg.eraTitleColor <> invalid
        m.eraTitle.color = cfg.eraTitleColor
    end if

    if cfg.eraSubtitleTranslation <> invalid
        m.eraSubtitle.translation = cfg.eraSubtitleTranslation
    end if
    if cfg.eraSubtitleWidth <> invalid
        m.eraSubtitle.width = cfg.eraSubtitleWidth
    end if
    if cfg.eraSubtitleHeight <> invalid
        m.eraSubtitle.height = cfg.eraSubtitleHeight
    end if
    if m.eraSubtitleFont <> invalid and cfg.eraSubtitleFontSize <> invalid
        m.eraSubtitleFont.size = cfg.eraSubtitleFontSize
    end if
end sub

function getConfigUri(cfg as object, cfgKey as string, sceneSuffix as string) as string
    if m.scene <> invalid
        fieldName = m.currentLayout + sceneSuffix
        if m.scene.HasField(fieldName)
            uri = m.scene[fieldName]
            if uri <> invalid and uri <> ""
                return uri
            end if
        end if
    end if

    if cfg <> invalid and cfg[cfgKey] <> invalid
        return cfg[cfgKey]
    end if

    return ""
end function

sub bindContent()
    content = m.itemContent
    if content = invalid then return

    thumb = content.videoThumbnail
    if m.currentLayout = "mood"
        bindMoodContent(content)
    else if m.currentLayout = "era"
        bindEraContent(content)
    else if thumb <> invalid and thumb <> ""
        m.bg.uri = thumb.Replace("http:", "https:")
        m.bg.observeField("loadStatus", "onLoadStatus")
    else
        m.bg.uri = "pkg:/images/GI.png"
    end if

    if m.currentLayout <> "era" and m.currentLayout <> "mood"
        m.title.text = ""
        if content.videoTitle <> invalid
            m.title.text = content.videoTitle
        end if

        m.subtitle.text = ""
        if m.layoutCfg <> invalid and m.layoutCfg.subtitleVisible = true
            if content.subtitle <> invalid and content.subtitle <> ""
                m.subtitle.text = content.subtitle
            else if content.creator <> invalid and content.creator <> ""
                m.subtitle.text = content.creator
            else if content.genre <> invalid and content.genre <> ""
                m.subtitle.text = content.genre
            end if
        end if
    end if

    bindBadgeAndRank(content)

    if content.overlayUri <> invalid and content.overlayUri <> ""
        m.overlay.uri = content.overlayUri
        m.overlay.visible = true
    else if m.layoutCfg <> invalid and m.layoutCfg.overlayUri <> invalid and m.layoutCfg.overlayUri <> ""
        m.overlay.uri = m.layoutCfg.overlayUri
        if m.layoutCfg.overlayVisible = true
            m.overlay.visible = true
        end if
    end if
end sub

sub bindMoodContent(content as object)
    m.bg.visible = false
    m.bg.uri = ""

    moodColor = invalid
    if content.moodColor <> invalid and content.moodColor <> ""
        moodColor = content.moodColor
    else if content.moodName <> invalid and content.moodName <> ""
        moodColor = GetMoodColor(content.moodName)
    else if content.videoTitle <> invalid
        moodColor = GetMoodColor(content.videoTitle)
    end if

    if moodColor = invalid
        moodColor = "0x333355FF"
    end if

    m.moodBg.color = moodColor
    m.moodBg.visible = true

    m.moodEmoji.visible = false
    emojiText = invalid
    if content.emoji <> invalid and content.emoji <> ""
        emojiText = content.emoji
    else if content.moodName <> invalid and content.moodName <> ""
        emojiText = GetMoodEmoji(content.moodName)
    else if content.videoTitle <> invalid
        emojiText = GetMoodEmoji(content.videoTitle)
    end if

    if emojiText <> invalid and emojiText <> ""
        m.moodEmoji.text = emojiText
        m.moodEmoji.visible = true
    end if

    if content.moodName <> invalid and content.moodName <> ""
        m.title.text = content.moodName
    else if content.videoTitle <> invalid
        m.title.text = content.videoTitle
    end if
end sub

sub bindEraContent(content as object)
    m.bg.visible = false
    m.bg.uri = ""
    m.moodEmoji.visible = false
    m.overlay.visible = false

    eraColor = "0x1E1E1EFF"
    if m.layoutCfg <> invalid and m.layoutCfg.eraBgColor <> invalid
        eraColor = m.layoutCfg.eraBgColor
    end if

    m.moodBg.color = eraColor
    m.moodBg.visible = true

    m.eraTitle.text = ""
    if content.videoTitle <> invalid
        m.eraTitle.text = content.videoTitle
    end if

    m.eraSubtitle.text = ""
    if content.subtitle <> invalid and content.subtitle <> ""
        m.eraSubtitle.text = content.subtitle
    else
        m.eraSubtitle.text = "English Music"
    end if

    if m.layoutCfg <> invalid
        if m.eraTitleFont <> invalid and m.layoutCfg.eraTitleFontSize <> invalid
            m.eraTitleFont.size = m.layoutCfg.eraTitleFontSize
        end if
        if m.eraSubtitleFont <> invalid and m.layoutCfg.eraSubtitleFontSize <> invalid
            m.eraSubtitleFont.size = m.layoutCfg.eraSubtitleFontSize
        end if
        if m.layoutCfg.eraTitleColor <> invalid
            m.eraTitle.color = m.layoutCfg.eraTitleColor
        else
            m.eraTitle.color = "#FFFFFF"
        end if
    end if
    m.eraSubtitle.color = "#888888"
end sub

sub bindBadgeAndRank(content as object)
    m.badgeBg.visible = false
    m.badge.visible = false
    m.rank.visible = false

    cfg = m.layoutCfg
    if cfg = invalid then return

    if cfg.rankShow = true
        if content.rank <> invalid and content.rank > 0
            m.rank.text = content.rank.ToStr()
            m.rank.visible = true
        end if
        return
    end if

    if cfg.badgeShow <> true then return

    sectionId = content.sectionId
    badgeText = invalid

    if m.currentLayout = "ranked"
        if content.rank <> invalid and content.rank > 0
            badgeText = content.rank.ToStr()
        end if
    else if m.currentLayout = "badge" and sectionId = "newReleases"
        badgeText = "NEW"
    else if m.currentLayout = "badge" and sectionId = "recommended"
        badgeText = GetRecommendedBadgeText(content)
    end if

    if badgeText = invalid or badgeText = "" then return

    m.badge.text = badgeText
    m.badgeBg.visible = true
    m.badge.visible = true
end sub

function GetRecommendedBadgeText(content as object) as string
    phrases = [
        "For you"
        "Hot pick"
        "Try this"
        "You'd like"
        "Fresh find"
        "Top match"
        "Just for you"
        "Must hear"
    ]

    seed = 0
    if content.id <> invalid and content.id <> ""
        seed = Len(content.id)
    else if content.videoTitle <> invalid
        seed = Len(content.videoTitle)
    end if

    idx = seed mod phrases.Count()
    return phrases[idx]
end function

sub onLoadStatus()
    if m.bg.loadStatus = "failed"
        m.bg.uri = "pkg:/images/GI.png"
    end if
end sub

sub onFocusSyncTimer()
    showFocus()
end sub

sub queueFocusSync()
    if m.focusSyncTimer = invalid then return
    m.focusSyncTimer.control = "stop"
    m.focusSyncTimer.control = "start"
end sub

function isItemFocused() as boolean
    ' RowList sets rowHasFocus + focusPercent; gridHasFocus is not reliable here.
    return m.top.rowHasFocus = true and m.top.focusPercent > 0.6
end function

sub applyUnfocusedState()
    if m.focus <> invalid
        m.focus.visible = false
    end if
    setUnfocusedLabelColors()
end sub

sub setUnfocusedLabelColors()
    if m.currentLayout = "mood"
        if m.layoutCfg <> invalid and m.layoutCfg.moodTitleColor <> invalid
            m.title.color = m.layoutCfg.moodTitleColor
        else
            m.title.color = "#FFFFFF"
        end if
        m.subtitle.color = "#AAAAAA"
    else if m.currentLayout = "era"
        if m.eraTitle <> invalid
            m.eraTitle.color = "#FFFFFF"
        end if
        if m.eraSubtitle <> invalid
            m.eraSubtitle.color = "#888888"
        end if
    else
        m.title.color = "#d1d1d1"
        m.subtitle.color = "#AAAAAA"
    end if
end sub

sub showFocus()
    if m.itemContent = invalid then return

    hasFocus = isItemFocused()

    if hasFocus
        m.focus.visible = true
        m.focus.uri = getConfigUri(m.layoutCfg, "focusUri", "Focus")
        if m.currentLayout <> "mood" and m.currentLayout <> "era"
            m.title.color = "#FFFFFF"
        end if
        if m.currentLayout <> "era"
            m.subtitle.color = "#FFFFFF"
        end if
    else
        applyUnfocusedState()
    end if
end sub
