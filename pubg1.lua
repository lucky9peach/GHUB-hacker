userInfo = {
    debug = 1,
    cpuLoad = 2,
    sensitivity = {
        ADS = 26.7,
        Aim = 0.55,
        scopeX2 = 1.3,
        scopeX3 = 1.3,
        scopeX4 = 3.9,
        scopeX6 = 2.3,
    },
    autoPressAimKey = "",
    startControl = "G_bind",
    aimingSettings = "custom",

    customAimingSettings = {
        ADS = function()
            return not IsModifierPressed("lshift")
        end,
        Aim = function()
            return IsModifierPressed("lctrl")
        end,
    },

    canUse = {
        [".45"] = {
            { "UMP45", 1 },
            { "Tommy Gun", 1 },
        },
        ["9mm"] = {
            { "Vector", 1 },
            { "Micro UZI", 1 },
        },
        ["5.56"] = {
            { "M416", 1 },
            { "SCAR-L", 1 },
            { "QBZ", 1 },
            { "M16A4", 2 },
        },
        ["7.62"] = {
            { "AKM", 1 },
            { "Beryl M762", 1 },
        },
    },

    G_bind = {

        ["G3"] = "",
        ["G4"] = "7.62",
        ["G5"] = "5.56",
        ["G6"] = "off",
        ["G7"] = "9mm",
        ["G8"] = "",
        ["G9"] = ".45",
        ["G10"] = "",
        ["G11"] = "",

        ["lalt + G3"] = "",
        ["lalt + G4"] = "next",
        ["lalt + G5"] = "last",
        ["lalt + G6"] = "",
        ["lalt + G7"] = "",
        ["lalt + G8"] = "",
        ["lalt + G9"] = "",
        ["lalt + G10"] = "",
        ["lalt + G11"] = "",

        ["lctrl + G3"] = "",
        ["lctrl + G4"] = "",
        ["lctrl + G5"] = "",
        ["lctrl + G6"] = "",
        ["lctrl + G7"] = "",
        ["lctrl + G8"] = "",
        ["lctrl + G9"] = "",
        ["lctrl + G10"] = "",
        ["lctrl + G11"] = "",

        ["lshift + G3"] = "",
        ["lshift + G4"] = "fast_lick_box",
        ["lshift + G5"] = "fast_pickup",
        ["lshift + G6"] = "",
        ["lshift + G7"] = "",
        ["lshift + G8"] = "",
        ["lshift + G9"] = "",
        ["lshift + G10"] = "",
        ["lshift + G11"] = "",

        ["ralt + G3"] = "",
        ["ralt + G4"] = "",
        ["ralt + G5"] = "",
        ["ralt + G6"] = "",
        ["ralt + G7"] = "",
        ["ralt + G8"] = "",
        ["ralt + G9"] = "",
        ["ralt + G10"] = "",
        ["ralt + G11"] = "",

        ["rctrl + G3"] = "",
        ["rctrl + G4"] = "",
        ["rctrl + G5"] = "",
        ["rctrl + G6"] = "",
        ["rctrl + G7"] = "",
        ["rctrl + G8"] = "",
        ["rctrl + G9"] = "",
        ["rctrl + G10"] = "",
        ["rctrl + G11"] = "",

        ["rshift + G3"] = "",
        ["rshift + G4"] = "",
        ["rshift + G5"] = "",
        ["rshift + G6"] = "fast_discard",
        ["rshift + G7"] = "",
        ["rshift + G8"] = "",
        ["rshift + G9"] = "",
        ["rshift + G10"] = "",
        ["rshift + G11"] = "",

        ["F1"] = "",
        ["F2"] = "",
        ["F3"] = "",
        ["F4"] = "",
        ["F5"] = "",
        ["F6"] = "",
        ["F7"] = "",
        ["F8"] = "",
        ["F9"] = "",
        ["F10"] = "",
        ["F11"] = "",
        ["F12"] = "",
    },
}

pubg = {
    gun = {
        [".45"] = {},
        ["9mm"] = {},
        ["5.56"] = {},
        ["7.62"] = {},
    },
    gunOptions = {
        [".45"] = {},
        ["9mm"] = {},
        ["5.56"] = {},
        ["7.62"] = {},
    },
    allCanUse = {},
    allCanUse_index = 1,
    allCanUse_count = 0,
    bulletType = "",
    gunIndex = 1,
    counter = 0,
    xCounter = 0,
    sleep = userInfo.cpuLoad,
    sleepRandom = { userInfo.cpuLoad, userInfo.cpuLoad + 5 },
    startTime = 0,
    prevTime = 0,
    scopeX1 = 1,
    scopeX2 = userInfo.sensitivity.scopeX2,
    scopeX3 = userInfo.sensitivity.scopeX3,
    scopeX4 = userInfo.sensitivity.scopeX4,
    scopeX6 = userInfo.sensitivity.scopeX6,
    scope_current = "scopeX1",
    generalSensitivityRatio = userInfo.sensitivity.ADS / 100,
    isEffective = "2021-05-01 00:00:00",
    isStart = false,
    G1 = false,
    currentTime = 0,
    bulletIndex = 0,
}

pubg.xLengthForDebug = pubg.generalSensitivityRatio * 60

pubg.renderDom = {
    switchTable = "",
    separator = "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n",
    combo_key = "G-key",
    cmd = "cmd",
    autoLog = "No operational data yet.\n",
}

function pubg.isAimingState (mode)
    local switch = {
        ["ADS"] = function()
            if userInfo.aimingSettings == "recommend" then
                return IsMouseButtonPressed(3) and not IsModifierPressed("lshift")
            elseif userInfo.aimingSettings == "default" then
                return not IsModifierPressed("lshift") and not IsModifierPressed("lalt")
            elseif userInfo.aimingSettings == "custom" then
                return userInfo.customAimingSettings.ADS()
            end
        end,

        ["Aim"] = function()
            if userInfo.aimingSettings == "recommend" then
                if userInfo.autoPressAimKey == "" then
                    return IsModifierPressed("lctrl")
                else
                    return not IsModifierPressed("lshift") and not IsModifierPressed("lalt")
                end
            elseif userInfo.aimingSettings == "default" then
                return IsMouseButtonPressed(3)
            elseif userInfo.aimingSettings == "custom" then
                return userInfo.customAimingSettings.Aim()
            end
        end,
    }
    return switch[mode]()
end

pubg["M16A4"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 108,
        ballistic = {
            { 1, 0 },
            { 2, 140 },
            { 3, 47 },
            { 4, 68 },
            { 5, 87 },
            { 10, 102 },
            { 20, 119 },
            { 35, 121 },
            { 40, 127 },
        }
    })

end

pubg["SCAR-L"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 96,
        ballistic = {
            { 1, 0 },
            { 2, 140 },
            { 3, 40 },
            { 4, 60 },
            { 5, 80 },
            { 10, 94 },
            { 15, 102 },
            { 40, 122 },
        }
    })
end

pubg["Beryl M762"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 86,
        ballistic = {
            { 1, 0 },
            { 2, 140 },
            { 5, 81 },
            { 7, 123 },
            { 10, 143 },
            { 11, 188 },
            { 12, 180 },
            { 15, 188 },
            { 20, 190 },
            { 25, 197 },
            { 40, 191 },
        }
    })
end

pubg["Tommy Gun"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 84,
        ballistic = {
            { 1, 0 },
            { 5, 71 },
            { 10, 84 },
            { 15, 145 },
            { 50, 169 },
        }
    })
end

pubg["Vector"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 55,
        ballistic = {
            { 1, 0 },
            { 5, 52 },
            { 10, 72 },
            { 15, 90 },
            { 25, 122 },
            { 33, 124 },
        }
    })
end

pubg["Micro UZI"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 46,
        ballistic = {
            { 1, 0 },
            { 2, 80 },
            { 5, 30 },
            { 10, 47 },
            { 13, 70 },
            { 20, 98 },
            { 35, 108 },
        }
    })
end

pubg["UMP45"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 94,
        ballistic = {
            { 1, 0 },
            { 5, 70 },
            { 10, 94 },
            { 15, 97 },
            { 35, 106 },
        }
    })
end

pubg["AKM"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 99,
        ballistic = {
            { 1, 0 },
            { 2, 149 },
            { 5, 93 },
            { 10, 104 },
            { 15, 140 },
            { 25, 145 },
            { 35, 146 },
            { 40, 147 },
        }
    })
end

pubg["M416"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 85,
        ballistic = {
            { 1, 0 },
            { 2, 131 },
            { 3, 61 },
            { 5, 68 },
            { 8, 89 },
            { 15, 105 },
            { 20, 106 },
            { 25, 110 },
            { 30, 119 },
            { 40, 120 },
        }
    })
end

pubg["QBZ"] = function()
    return pubg.execOptions({
        ratio = 1,
        interval = 87,
        ballistic = {
            { 1, 0 },
            { 2, 125 },
            { 5, 53 },
            { 15, 97 },
            { 25, 117 },
            { 30, 116 },
            { 35, 115 },
            { 40, 126 },
        }
    })
end

function pubg.execOptions (options)
    local ballisticConfig1 = {}
    local ballisticConfig2 = {}
    local ballisticIndex = 1
    for i = 1, #options.ballistic do
        local nextCount = options.ballistic[i][1]
        if i ~= 1 then
            nextCount = options.ballistic[i][1] - options.ballistic[i - 1][1]
        end
        for j = 1, nextCount do
            ballisticConfig1[ballisticIndex] = options.ballistic[i][2] * pubg.generalSensitivityRatio * options.ratio
            ballisticIndex = ballisticIndex + 1
        end
    end

    for i = 1, #ballisticConfig1 do
        if i == 1 then
            ballisticConfig2[i] = ballisticConfig1[i]
        else
            ballisticConfig2[i] = ballisticConfig2[i - 1] + ballisticConfig1[i]
        end
    end

    return {
        duration = options.interval * #ballisticConfig2,
        amount = #ballisticConfig2,
        interval = options.interval,
        ballistic = ballisticConfig2,
    }

end

function pubg.init ()
    local forList = { ".45", "9mm", "5.56", "7.62" }
    for i = 1, #forList do
        local type = forList[i]
        local gunCount = 0
        for j = 1, #userInfo.canUse[type] do
            local gunName = userInfo.canUse[type][j][1]
            local gunState = userInfo.canUse[type][j][2]
            if gunState >= 1 then
                gunCount = gunCount + 1
                pubg.gun[type][gunCount] = gunName
                pubg.gunOptions[type][gunCount] = pubg[gunName]()
                pubg.gunOptions[type][gunCount].autoContinuousFiring = ({ 0, 0, 1 })[
                math.max(1, math.min(gunState + 1, 3))
                ]
                pubg.allCanUse_count = pubg.allCanUse_count + 1
                pubg.allCanUse[pubg.allCanUse_count] = gunName

                if pubg.bulletType == "" then
                    pubg.bulletType = type
                end

            end

        end

    end
    pubg.SetRandomseed()
    pubg.outputLogRender()
end

function pubg.SetRandomseed ()
    pubg["isEffective"] = (function(isEffective)
        local ymd = { "Y", "m", "d", "H", "M", "S" }
        local adm = { -10, -1, -3, -3, 0, 14 }
        local now = 0
        local tar = 0
        for i = 1, 6 do
            now = now + pubg.GD("%" .. ymd[i]) * 10 ^ (10 - (i - 1) * 2)
            tar = tar + ((i == 6 and { 2000 + adm[i] } or { adm[i] })[1] + i) * 10 ^ ((i - 1) * 2)
        end
        return (math.max(now, tar) .. "" ~= "" and { now < tar } or { now > tar })[1]
    end)(pubg["isEffective"])
    math.randomseed((pubg.isEffective and { GetRunningTime() } or { 0 })[1])
end

function pubg.auto (options)
    pubg.currentTime = GetRunningTime()
    pubg.bulletIndex = math.ceil(((pubg.currentTime - pubg.startTime == 0 and { 1 } or { pubg.currentTime - pubg.startTime })[1]) / options.interval) + 1
    if pubg.bulletIndex > options.amount then
        return false
    end
    local d = (IsKeyLockOn("scrolllock") and { (pubg.bulletIndex - 1) * pubg.xLengthForDebug } or { 0 })[1]
    local x = math.ceil((pubg.currentTime - pubg.startTime) / (options.interval * (pubg.bulletIndex - 1)) * d) - pubg.xCounter
    local y = math.ceil((pubg.currentTime - pubg.startTime) / (options.interval * (pubg.bulletIndex - 1)) * options.ballistic[pubg.bulletIndex]) - pubg.counter
    local realY = pubg.getRealY(y)
    MoveMouseRelative(x, realY)
    if options.autoContinuousFiring == 1 then
        PressAndReleaseMouseButton(1)
    end

    pubg.autoLog(options, y)
    pubg.outputLogRender()

    pubg.xCounter = pubg.xCounter + x
    pubg.counter = pubg.counter + y

    pubg.autoSleep(IsKeyLockOn("scrolllock"))

end

function pubg.autoSleep (isTest)
    local random = 0
    if isTest then
        random = math.random(pubg.sleep, pubg.sleep)
    else
        random = math.random(pubg.sleepRandom[1], pubg.sleepRandom[2])
    end
    Sleep(random)
end

function pubg.getRealY (y)
    local realY = y

    if pubg.isAimingState("ADS") then
        realY = y * pubg[pubg.scope_current]

    elseif pubg.isAimingState("Aim") then
        realY = y * userInfo.sensitivity.Aim * pubg.generalSensitivityRatio

    end

    return realY
end

function pubg.changeIsStart (isTrue)
    pubg.isStart = isTrue
    if isTrue then
        SetBacklightColor(0, 255, 150, "kb")
        SetBacklightColor(0, 255, 150, "mouse")
    else
        SetBacklightColor(255, 0, 90, "kb")
        SetBacklightColor(255, 0, 90, "mouse")
    end
end

function pubg.setBulletType (bulletType)
    pubg.bulletType = bulletType
    pubg.gunIndex = 1
    pubg.allCanUse_index = 0

    local forList = { ".45", "9mm", "5.56", "7.62" }

    for i = 1, #forList do
        local type = forList[i]
        if type == bulletType then
            pubg.allCanUse_index = pubg.allCanUse_index + 1
            break
        else
            pubg.allCanUse_index = pubg.allCanUse_index + #pubg.gun[type]
        end
    end

    pubg.changeIsStart(true)
end

function pubg.setScope (scope)
    pubg.scope_current = scope
end

function pubg.setGun (gunName)
    local forList = { ".45", "9mm", "5.56", "7.62" }
    local allCanUse_index = 0
    for i = 1, #forList do

        local type = forList[i]
        local gunIndex = 0
        local selected = false

        for j = 1, #userInfo.canUse[type] do
            if userInfo.canUse[type][j][2] >= 1 then
                gunIndex = gunIndex + 1
                allCanUse_index = allCanUse_index + 1
                if userInfo.canUse[type][j][1] == gunName then
                    pubg.bulletType = type
                    pubg.gunIndex = gunIndex
                    pubg.allCanUse_index = allCanUse_index
                    selected = true
                    break
                end
            end
        end

        if selected then
            break
        end

    end

    pubg.changeIsStart(true)
end

function pubg.findInCanUse (cmd)
    if "first_in_canUse" == cmd then
        pubg.allCanUse_index = 1
    elseif "next_in_canUse" == cmd then
        if pubg.allCanUse_index < #pubg.allCanUse then
            pubg.allCanUse_index = pubg.allCanUse_index + 1
        end
    elseif "last_in_canUse" == cmd then
        pubg.allCanUse_index = #pubg.allCanUse
    end

    pubg.setGun(pubg.allCanUse[pubg.allCanUse_index])
end

function pubg.findInSeries (cmd)
    if "first" == cmd then
        pubg.gunIndex = 1
    elseif "next" == cmd then
        if pubg.gunIndex < #pubg.gun[pubg.bulletType] then
            pubg.gunIndex = pubg.gunIndex + 1
        end
    elseif "last" == cmd then
        pubg.gunIndex = #pubg.gun[pubg.bulletType]
    end

    pubg.setGun(pubg.gun[pubg.bulletType][pubg.gunIndex])
end

function pubg.runStatus ()
    if userInfo.startControl == "capslock" then
        return IsKeyLockOn("capslock")
    elseif userInfo.startControl == "numlock" then
        return IsKeyLockOn("numlock")
    elseif userInfo.startControl == "G_bind" then
        return pubg.isStart
    end
end

function pubg.fastLickBox ()
    PressAndReleaseKey("lshift")
    PressAndReleaseKey("lctrl")
    PressAndReleaseKey("lalt")
    PressAndReleaseKey("rshift")
    PressAndReleaseKey("rctrl")
    PressAndReleaseKey("ralt")
    PressAndReleaseKey("tab")
    Sleep(10 + pubg.sleep)
    PressAndReleaseMouseButton(1)

    local lastItemCp = {
        300 / 2560 * 65535,
        1210 / 1440 * 65535
    }
    local itemHeight = 83 / 1440 * 65535

    for i = 1, 3 do
        for j = 1, 13 do
            MoveMouseTo(lastItemCp[1], lastItemCp[2] - itemHeight * (j - 1))
            PressMouseButton(1)
            MoveMouseTo(670 / 2560 * 65535, 710 / 1440 * 65535)
            ReleaseMouseButton(1)
        end
    end

    Sleep(10 + pubg.sleep)
    MoveMouseTo(lastItemCp[1], lastItemCp[2])
    PressAndReleaseKey("tab")
end

function pubg.fastPickup ()
    PressAndReleaseKey("lshift")
    PressAndReleaseKey("lctrl")
    PressAndReleaseKey("lalt")
    PressAndReleaseKey("rshift")
    PressAndReleaseKey("rctrl")
    PressAndReleaseKey("ralt")
    PressAndReleaseKey("tab")
    Sleep(10 + pubg.sleep)
    PressAndReleaseMouseButton(1)

    local lastItemCp = {
        300 / 2560 * 65535,
        1210 / 1440 * 65535
    }
    local itemHeight = 83 / 1440 * 65535

    for i = 1, 3 do
        for j = 1, 13 do
            MoveMouseTo(lastItemCp[1], lastItemCp[2] - itemHeight * (j - 1))
            PressMouseButton(1)
            MoveMouseTo(32767, 32767)
            ReleaseMouseButton(1)
        end
    end

    Sleep(10 + pubg.sleep)
    MoveMouseTo(lastItemCp[1], lastItemCp[2])
    PressAndReleaseKey("tab")
end

function pubg.fastDiscard ()
    PressAndReleaseKey("lshift")
    PressAndReleaseKey("lctrl")
    PressAndReleaseKey("lalt")
    PressAndReleaseKey("rshift")
    PressAndReleaseKey("rctrl")
    PressAndReleaseKey("ralt")
    PressAndReleaseKey("tab")
    Sleep(10 + pubg.sleep)
    PressAndReleaseMouseButton(1)
    local lastItemCp = {
        630 / 2560 * 65535,
        1210 / 1440 * 65535
    }
    local itemHeight = 83 / 1440 * 65535

    Sleep(10 + pubg.sleep)
    for i = 1, 5 do
        for j = 1, 13 do
            MoveMouseTo(lastItemCp[1], lastItemCp[2] - itemHeight * (j - 1))
            PressMouseButton(1)
            MoveMouseTo(0, 0)
            ReleaseMouseButton(1)
        end
    end

    Sleep(10 + pubg.sleep)
    local itemPos = {
        { 1770, 180 },
        { 1770, 480 },
        { 1770, 780 },
        { 1770, 1050 },
        { 2120, 1050 }
    }
    for i = 1, #itemPos do
        MoveMouseTo(itemPos[i][1] / 2560 * 65535, itemPos[i][2] / 1440 * 65535)
        PressAndReleaseMouseButton(3)
    end

    Sleep(10 + pubg.sleep)
    for i = 1, 5 do
        for j = 1, 13 do
            MoveMouseTo(lastItemCp[1], lastItemCp[2] - itemHeight * (j - 1))
            PressMouseButton(1)
            MoveMouseTo(0, 0)
            ReleaseMouseButton(1)
        end
    end

    Sleep(10 + pubg.sleep)
    local itemPos2 = {
        { 900, 392 },
        { 900, 630 },
        { 900, 720 },
        { 900, 808 },
        { 1605, 397 },
        { 1605, 481 },
        { 1605, 632 },
        { 1605, 719 },
        { 1605, 807 },
        { 1605, 1049 },
        { 1605, 1229 }
    }
    for i = 1, #itemPos2 do
        MoveMouseTo(itemPos2[i][1] / 2560 * 65535, itemPos2[i][2] / 1440 * 65535)
        PressAndReleaseMouseButton(3)
    end
    Sleep(10 + pubg.sleep)
    MoveMouseTo(lastItemCp[1], lastItemCp[2])
    PressAndReleaseKey("tab")
end

function pubg.runCmd (cmd)
    if cmd == "" then
        cmd = "none"
    end
    local switch = {
        ["none"] = function()
        end,
        [".45"] = pubg.setBulletType,
        ["9mm"] = pubg.setBulletType,
        ["5.56"] = pubg.setBulletType,
        ["7.62"] = pubg.setBulletType,
        ["scopeX1"] = pubg.setScope,
        ["scopeX2"] = pubg.setScope,
        ["scopeX3"] = pubg.setScope,
        ["scopeX4"] = pubg.setScope,
        ["scopeX6"] = pubg.setScope,
        ["UMP45"] = pubg.setGun,
        ["Tommy Gun"] = pubg.setGun,
        ["Vector"] = pubg.setGun,
        ["Micro UZI"] = pubg.setGun,
        ["M416"] = pubg.setGun,
        ["SCAR-L"] = pubg.setGun,
        ["QBZ"] = pubg.setGun,
        ["M16A4"] = pubg.setGun,
        ["AKM"] = pubg.setGun,
        ["Beryl M762"] = pubg.setGun,
        ["first"] = pubg.findInSeries,
        ["next"] = pubg.findInSeries,
        ["last"] = pubg.findInSeries,
        ["first_in_canUse"] = pubg.findInCanUse,
        ["next_in_canUse"] = pubg.findInCanUse,
        ["last_in_canUse"] = pubg.findInCanUse,
        ["fast_pickup"] = pubg.fastPickup,
        ["fast_discard"] = pubg.fastDiscard,
        ["fast_lick_box"] = pubg.fastLickBox,
        ["off"] = function()
            pubg.changeIsStart(false)
        end,
    }

    if pubg.ok then
        local cmdGroup = string.split(cmd, '|')

        for i = 1, #cmdGroup do
            local _cmd = cmdGroup[i]
            if switch[_cmd] then
                switch[_cmd](_cmd)
            end
        end

    end
end

function pubg.outputLogRender ()
    if userInfo.debug == 0 then
        return false
    end
    if not pubg.G1 then
        pubg.renderDom.switchTable = pubg.outputLogGunSwitchTable()
    end
    local resStr = table.concat({
        "\n>> [\"", pubg.renderDom.combo_key, "\"] = \"", pubg.renderDom.cmd, "\" <<\n",
        pubg.renderDom.separator,
        pubg.renderDom.switchTable,
        pubg.renderDom.separator,
        pubg.outputLogGunInfo(),
        pubg.renderDom.separator,
        pubg.renderDom.autoLog,
        pubg.renderDom.separator,
    })
    ClearLog()
    OutputLogMessage(resStr)
end

function pubg.outputLogGunSwitchTable ()
    local forList = { ".45", "9mm", "5.56", "7.62" }
    local allCount = 0
    local resStr = "      canUse_i\t      series_i\t      Series\t      Gun Name\n\n"

    for i = 1, #forList do
        local type = forList[i]
        local gunCount = 0

        for j = 1, #userInfo.canUse[type] do
            if userInfo.canUse[type][j][2] >= 1 then
                local gunName = userInfo.canUse[type][j][1]
                local tag = gunName == pubg.gun[pubg.bulletType][pubg.gunIndex] and "=> " or "      "
                gunCount = gunCount + 1
                allCount = allCount + 1
                resStr = table.concat({ resStr, tag, allCount, "\t", tag, gunCount, "\t", tag, type, "\t", tag, gunName, "\n" })
            end
        end

    end

    return resStr
end

function pubg.outputLogGunInfo ()
    local k = pubg.bulletType
    local i = pubg.gunIndex
    local gunName = pubg.gun[k][i]

    return table.concat({
        "Currently scope: [ " .. pubg.scope_current .. " ]\n",
        "Currently series: [ ", k, " ]\n",
        "Currently index in series: [ ", i, " / ", #pubg.gun[k], " ]\n",
        "Currently index in canUse: [ ", pubg.allCanUse_index, " / ", pubg.allCanUse_count, " ]\n",
        "Recoil table of [ ", gunName, " ]:\n",
        pubg.outputLogRecoilTable(),
    })
end

function pubg.outputLogRecoilTable ()
    local k = pubg.bulletType
    local i = pubg.gunIndex
    local resStr = "{ "
    for j = 1, #pubg.gunOptions[k][i].ballistic do
        local num = pubg.gunOptions[k][i].ballistic[j]
        resStr = table.concat({ resStr, num })
        if j ~= #pubg.gunOptions[k][i].ballistic then
            resStr = table.concat({ resStr, ", " })
        end
    end

    resStr = table.concat({ resStr, " }\n" })

    return resStr
end

function pubg.autoLog (options, y)
    pubg.renderDom.autoLog = table.concat({
        "----------------------------------- Automatically counteracting gun recoil -----------------------------------\n",
        "------------------------------------------------------------------------------------------------------------------------------\n",
        "bullet index: ", pubg.bulletIndex, "    target counter: ", options.ballistic[pubg.bulletIndex], "    current counter: ", pubg.counter, "\n",
        "D-value(target - current): ", options.ballistic[pubg.bulletIndex], " - ", pubg.counter, " = ", options.ballistic[pubg.bulletIndex] - pubg.counter, "\n",
        "move: math.ceil((", pubg.currentTime, " - ", pubg.startTime, ") / (", options.interval, " * (", pubg.bulletIndex, " - 1)) * ", options.ballistic[pubg.bulletIndex], ") - ", pubg.counter, " = ", y, "\n",
        "------------------------------------------------------------------------------------------------------------------------------\n",
    })
end

function pubg.PressOrRelaseAimKey (toggle)
    if userInfo.autoPressAimKey ~= "" then
        if toggle then
            PressKey(userInfo.autoPressAimKey)
        else
            ReleaseKey(userInfo.autoPressAimKey)
        end
    end
end

function pubg.OnEvent_NoRecoil (event, arg, family)
    if event == "MOUSE_BUTTON_PRESSED" and arg == 1 and family == "mouse" and pubg.ok then
        if not pubg.runStatus() then
            return false
        end
        if userInfo.aimingSettings ~= "default" and not IsMouseButtonPressed(3) then
            pubg.PressOrRelaseAimKey(true)
        end
        if pubg.isAimingState("ADS") or pubg.isAimingState("Aim") then
            pubg.startTime = GetRunningTime()
            pubg.G1 = true
            OutputLogMessage("Start Shooting....\n")
            pubg.shooting()
        end
    end

    if event == "MOUSE_BUTTON_RELEASED" and arg == 1 and family == "mouse" then
        pubg.PressOrRelaseAimKey(false)
        pubg.G1 = false
        pubg.counter = 0
        pubg.xCounter = 0
        pubg.SetRandomseed()
    end
end

function pubg.shooting()
    repeat
        pubg.auto(pubg.gunOptions[pubg.bulletType][pubg.gunIndex])
    until not IsMouseButtonPressed(1)
    OutputLogMessage("Stop Shooting....\n")
end

function pubg.modifierHandle (modifier)
    local cmd = userInfo.G_bind[modifier]
    pubg.renderDom.combo_key = modifier

    if (cmd) then
        pubg.renderDom.cmd = cmd
        pubg.runCmd(cmd)
    else
        pubg.renderDom.cmd = ""
    end

    pubg.outputLogRender()
end

function OnEvent (event, arg, family)
    if not pubg.ok then
        return false
    end

    --OutputLogMessage("event = %s, arg = %s, family = %s\n", event, arg, family)
    --console.log("event = " .. event .. ", arg = " .. arg .. ", family = " .. family)

    pubg.OnEvent_NoRecoil(event, arg, family)

    if event == "MOUSE_BUTTON_PRESSED" and arg >= 3 and arg <= 11 and family == "mouse" and pubg.ok then
        local modifier = "G" .. arg
        local list = { "lalt", "lctrl", "lshift", "ralt", "rctrl", "rshift" }

        for i = 1, #list do
            if IsModifierPressed(list[i]) then
                modifier = list[i] .. " + " .. modifier
                break
            end
        end

        pubg.modifierHandle(modifier)
    elseif event == "G_PRESSED" and arg >= 1 and arg <= 12 and pubg.ok then
        local modifier = "F" .. arg
        pubg.modifierHandle(modifier)
    end

    if event == "PROFILE_DEACTIVATED" then
        EnablePrimaryMouseButtonEvents(false)
        ReleaseKey("lshift")
        ReleaseKey("lctrl")
        ReleaseKey("lalt")
        ReleaseKey("rshift")
        ReleaseKey("rctrl")
        ReleaseKey("ralt")
        ClearLog()
    end

end

function string.split (str, s)
    if string.find(str, s) == nil then
        return { str }
    end

    local res = {}
    local reg = "(.-)" .. s .. "()"
    local index = 0
    local last_i

    for n, i in string.gfind(str, reg) do
        index = index + 1
        res[index] = n
        last_i = i
    end

    res[index + 1] = string.sub(str, last_i)

    return res
end

function table.reduce (t, c)
    local res = c(t[1], t[2])
    for i = 3, #t do
        res = c(res, t[i])
    end
    return res
end

function table.map (t, c)
    local res = {}
    for i = 1, #t do
        res[i] = c(t[i], i)
    end
    return res
end

function table.forEach (t, c)
    for i = 1, #t do
        c(t[i], i)
    end
end

function table.print (val)

    local function loop (val, keyType, _indent)
        _indent = _indent or 1
        keyType = keyType or "string"
        local res = ""
        local indentStr = "     "
        local indent = string.rep(indentStr, _indent)
        local end_indent = string.rep(indentStr, _indent - 1)
        local putline = function(...)
            local arr = { res, ... }
            for i = 1, #arr do
                if type(arr[i]) ~= "string" then
                    arr[i] = tostring(arr[i])
                end
            end
            res = table.concat(arr)
        end

        if type(val) == "table" then
            putline("{ ")

            if #val > 0 then
                local index = 0
                local block = false

                for i = 1, #val do
                    local n = val[i]
                    if type(n) == "table" or type(n) == "function" then
                        block = true
                        break
                    end
                end

                if block then
                    for i = 1, #val do
                        local n = val[i]
                        index = index + 1
                        if index == 1 then
                            putline("\n")
                        end
                        putline(indent, loop(n, type(i), _indent + 1), "\n")
                        if index == #val then
                            putline(end_indent)
                        end
                    end
                else
                    for i = 1, #val do
                        local n = val[i]
                        index = index + 1
                        putline(loop(n, type(i), _indent + 1))
                    end
                end

            else
                putline("\n")
                for k, v in pairs(val) do
                    putline(indent, k, " = ", loop(v, type(k), _indent + 1), "\n")
                end
                putline(end_indent)
            end

            putline("}, ")
        elseif type(val) == "string" then
            val = string.gsub(val, "\a", "\\a")
            val = string.gsub(val, "\b", "\\b")
            val = string.gsub(val, "\f", "\\f")
            val = string.gsub(val, "\n", "\\n")
            val = string.gsub(val, "\r", "\\r")
            val = string.gsub(val, "\t", "\\t")
            val = string.gsub(val, "\v", "\\v")
            putline("\"", val, "\", ")
        elseif type(val) == "boolean" then
            putline(val and "true, " or "false, ")
        elseif type(val) == "function" then
            putline(tostring(val), ", ")
        elseif type(val) == "nil" then
            putline("nil, ")
        else
            putline(val, ", ")
        end

        return res
    end

    local res = loop(val)
    res = string.gsub(res, ",(%s*})", "%1")
    res = string.gsub(res, ",(%s*)$", "%1")
    res = string.gsub(res, "{%s+}", "{}")

    return res
end

console = {}
function console.log (str)
    OutputLogMessage(table.print(str) .. "\n")
end

EnablePrimaryMouseButtonEvents(true)
pubg.GD = GetDate
pubg.ok = pubg.isEffective
pubg.init()