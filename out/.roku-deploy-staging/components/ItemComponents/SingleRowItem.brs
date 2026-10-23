sub init()
    m.scene = m.top.getScene()
    m.itemBg = m.top.findNode("itemBg")
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
    m.progressBg = m.top.findNode("progressBg")
    m.progressFill = m.top.findNode("progressFill")
    m.fallbackThumbUri = "pkg:/images/GI.png"
    m.currentLayout = "square"
    m.layoutCfg = invalid

    m.bg.observeField("loadStatus", "onLoadStatus")

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
    m.layoutCfg = GetItemLayoutForSection(layout, sectionId)
    applyUnfocusedState()
    applyLayout()
    bindContent()
    showFocus()
    queueFocusSync()
end sub

sub applyLayout()
    cfg = m.layoutCfg
    if cfg = invalid then return

    if m.itemBg <> invalid
        if cfg.itemBgVisible = true
            m.itemBg.visible = true
            m.itemBg.translation = cfg.itemBgTranslation
            m.itemBg.width = cfg.itemBgSize[0]
            m.itemBg.height = cfg.itemBgSize[1]
            itemBgUri = getConfigUri(cfg, "itemBgUri", "ItemBg")
            if itemBgUri <> invalid and itemBgUri <> ""
                m.itemBg.uri = itemBgUri
            end if
        else
            m.itemBg.visible = false
        end if
    end if

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
        m.moodEmoji.translation = cfg.emojiTranslation
        m.moodEmoji.width = cfg.emojiWidth
        m.moodEmoji.height = cfg.emojiHeight
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

    m.overlay.translation = cfg.overlayTranslation
    m.overlay.width = cfg.overlaySize[0]
    m.overlay.height = cfg.overlaySize[1]
    if cfg.overlayUri <> invalid and cfg.overlayUri <> ""
        m.overlay.uri = cfg.overlayUri
        if cfg.overlayVisible = true
            m.overlay.visible = true
        end if
    else
        m.overlay.uri = ""
        m.overlay.visible = false
    end if

    m.title.translation = cfg.titleTranslation
    m.title.width = cfg.titleWidth
    m.title.height = cfg.titleHeight
    if cfg.titleHorizAlign <> invalid
        m.title.horizAlign = cfg.titleHorizAlign
    end if
    if m.titleFont <> invalid and cfg.titleFontSize <> invalid
        m.titleFont.size = cfg.titleFontSize
    end if

    m.subtitle.translation = cfg.subtitleTranslation
    m.subtitle.width = cfg.subtitleWidth
    m.subtitle.height = cfg.subtitleHeight
    if m.subtitleFont <> invalid and cfg.subtitleFontSize <> invalid
        m.subtitleFont.size = cfg.subtitleFontSize
    end if
    if cfg.subtitleVisible = true
        m.subtitle.visible = true
    else
        m.subtitle.visible = false
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
        if m.rankFont <> invalid and cfg.rankFontSize <> invalid
            m.rankFont.size = cfg.rankFontSize
        end if
    end if

    if m.progressBg <> invalid and m.progressFill <> invalid
        if cfg.progressShow = true
            m.progressBg.translation = cfg.progressTranslation
            m.progressBg.width = cfg.progressWidth
            m.progressBg.height = cfg.progressHeight
            m.progressFill.translation = cfg.progressTranslation
            m.progressFill.height = cfg.progressHeight
            m.progressBg.visible = true
            m.progressFill.visible = true
        else
            m.progressBg.visible = false
            m.progressFill.visible = false
        end if
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

    if m.currentLayout = "mood"
        bindMoodContent(content)
    else
        applyThumbnail(content.videoThumbnail)
    end if

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

    bindBadgeAndRank(content)
    bindProgress(content)

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

    if m.currentLayout = "ranked" and sectionId = "trendingNow"
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

sub bindProgress(content as object)
    if m.layoutCfg = invalid or m.layoutCfg.progressShow <> true then return
    if m.progressFill = invalid then return

    duration = content.duration
    if (duration = invalid or duration = 0) and content.audioDuration <> invalid
        duration = content.audioDuration.ToFloat()
    end if

    resumePosition = content.resumePosition
    if resumePosition = invalid then resumePosition = 0

    if duration <> invalid and duration > 0
        SetProgress((resumePosition / duration) * 100)
    else
        SetProgress(0)
    end if
end sub

sub SetProgress(percent as float)
    if m.progressFill = invalid or m.layoutCfg = invalid then return

    maxWidth = m.layoutCfg.progressWidth
    if maxWidth = invalid or maxWidth <= 0 then maxWidth = 238

    if percent < 0 then percent = 0
    if percent > 100 then percent = 100

    m.progressFill.width = int(maxWidth * percent / 100)
end sub

sub applyThumbnail(thumb as string)
    if m.bg = invalid then return

    if thumb = invalid or thumb = ""
        m.bg.uri = m.fallbackThumbUri
        return
    end if

    m.bg.uri = thumb
end sub

sub onLoadStatus()
    if m.bg = invalid then return
    if m.bg.loadStatus = "failed" and m.bg.uri <> m.fallbackThumbUri
        m.bg.uri = m.fallbackThumbUri
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
    else
        m.title.color = "#d1d1d1"
    end if
    m.subtitle.color = "#AAAAAA"
end sub

sub showFocus()
    if m.itemContent = invalid then return

    hasFocus = isItemFocused()

    if hasFocus
        m.focus.visible = true
        m.focus.uri = getConfigUri(m.layoutCfg, "focusUri", "Focus")
        if m.currentLayout <> "mood"
            m.title.color = "#FFFFFF"
        end if
        m.subtitle.color = "#FFFFFF"
    else
        applyUnfocusedState()
    end if
end sub
