--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║         MAXX HUB  →  MULTI-SCRIPT EXECUTOR PLATFORM          ║
    ║  Cyraa • Tora • Fartez • NotZnx • Mystrix  |  Stats | Updates ║
    ╚══════════════════════════════════════════════════════════════╝
    Key: Maxx-Hub-Athena
    Discord: https://discord.gg/nqEUcZm4s
    Fixed for: Delta Executor
--]]

print("[MAXX HUB] Script initializing...")

local success, err = pcall(function()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    --// Configuration
    local CONFIG = {
        Key = "Maxx-Hub-Athena",
        DiscordLink = "https://discord.gg/nqEUcZm4s",
        ScriptURL = "https://raw.githubusercontent.com/LynX99-9/komtolmmek2/refs/heads/main/kick%20a%20lucky%20block",
        ScriptURL2 = "https://raw.githubusercontent.com/gumanba/Scripts/main/KickaLuckyBlock",
        ScriptURL3 = "https://raw.githubusercontent.com/fartez127-design/FARTEZHUB/refs/heads/main/FARTEZHUBXKickaLuckyBlock",
        ScriptURL4 = "https://pastefy.app/hRlp73pi/raw",
        ScriptURL5 = "https://raw.githubusercontent.com/ummarxfarooq/mystrix-hub/refs/heads/main/loader",
        Colors = {
            Background = Color3.fromRGB(6, 6, 10),
            Surface = Color3.fromRGB(16, 16, 24),
            SurfaceLight = Color3.fromRGB(26, 26, 38),
            Primary = Color3.fromRGB(255, 185, 0),
            Secondary = Color3.fromRGB(80, 210, 255),
            Cyraa = Color3.fromRGB(160, 90, 255),
            Tora = Color3.fromRGB(255, 85, 85),
            Fartez = Color3.fromRGB(255, 130, 0),
            NotZnx = Color3.fromRGB(0, 230, 180),
            Mystrix = Color3.fromRGB(255, 40, 180),
            Text = Color3.fromRGB(245, 245, 255),
            SubText = Color3.fromRGB(115, 115, 135),
            Error = Color3.fromRGB(255, 60, 80),
            Success = Color3.fromRGB(50, 255, 120),
            Warning = Color3.fromRGB(255, 190, 50)
        }
    }

    --// Utility
    local function Create(className, properties)
        local instance = Instance.new(className)
        for prop, value in pairs(properties or {}) do
            instance[prop] = value
        end
        return instance
    end

    local function Tween(instance, duration, style, direction, props, delayTime)
        local info = TweenInfo.new(duration, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out, 0, false, delayTime or 0)
        local tween = TweenService:Create(instance, info, props)
        tween:Play()
        return tween
    end

    local function Ripple(button, pos)
        local r = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 0.8,
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, pos.X, 0, pos.Y),
            Parent = button,
            ZIndex = button.ZIndex + 10,
            BorderSizePixel = 0
        })
        Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = r})
        local max = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 3
        Tween(r, 0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, {
            Size = UDim2.new(0, max, 0, max),
            BackgroundTransparency = 1
        }).Completed:Connect(function() r:Destroy() end)
    end

    --// Main ScreenGui
    local screenGui = Create("ScreenGui", {
        Name = "MaxxHubSystem",
        Parent = playerGui,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 9999
    })

    local blurOverlay = Create("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 0.45,
        BorderSizePixel = 0,
        Parent = screenGui
    })

    --// ═══════════════════════════════════════════════════════
    --//  KEY SYSTEM FRAME
    --// ═══════════════════════════════════════════════════════
    local keyFrame = Create("Frame", {
        Name = "KeyFrame",
        Size = UDim2.new(0, 520, 0, 640),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = CONFIG.Colors.Background,
        BackgroundTransparency = 0.06,
        BorderSizePixel = 0,
        Parent = screenGui,
        ClipsDescendants = true
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 26), Parent = keyFrame})
    Create("UIAspectRatioConstraint", {AspectRatio = 0.81, AspectType = Enum.AspectType.FitWithinMaxSize, DominantAxis = Enum.DominantAxis.Width, Parent = keyFrame})
    Create("UIStroke", {Color = CONFIG.Colors.Primary, Transparency = 0.6, Thickness = 1.6, Parent = keyFrame})

    local ambient = Create("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Parent = keyFrame, ZIndex = 0})
    local ambGrad = Create("UIGradient", {
        Color = ColorSequence.new({ColorSequenceKeypoint.new(0, CONFIG.Colors.Primary), ColorSequenceKeypoint.new(0.5, CONFIG.Colors.Secondary), ColorSequenceKeypoint.new(1, CONFIG.Colors.Primary)}),
        Transparency = NumberSequence.new(0.94, 0.97), Rotation = 45, Parent = ambient
    })

    --// Particle System — Orbs, Stars & Orbits
    local pContainer = Create("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Parent = keyFrame, ZIndex = 2})

    local function SpawnOrb()
        local s = math.random(2, 6)
        local p = Create("Frame", {
            Size = UDim2.new(0, s, 0, s),
            Position = UDim2.new(math.random(), 0, 1.1, 0),
            BackgroundColor3 = math.random() > 0.5 and CONFIG.Colors.Primary or CONFIG.Colors.Secondary,
            BackgroundTransparency = 0.25, BorderSizePixel = 0, Parent = pContainer, ZIndex = 2
        })
        Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = p})
        Create("ImageLabel", {Size = UDim2.new(4, 0, 4, 0), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Image = "rbxassetid://5880482965", ImageColor3 = p.BackgroundColor3, ImageTransparency = 0.75, Parent = p, ZIndex = 1})
        local dx = math.random(-140, 140)
        local dur = math.random(10, 20)
        Tween(p, dur, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {Position = UDim2.new(p.Position.X.Scale, dx, -0.1, 0)})
        Tween(p, math.random(2, 4), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {BackgroundTransparency = 0.8, Size = UDim2.new(0, s * 0.4, 0, s * 0.4)})
        task.delay(dur + 0.5, function() if p then p:Destroy() end end)
    end

    local function SpawnStar()
        local symbols = {"✦", "★", "✶", "✹"}
        local star = Create("TextLabel", {
            Text = symbols[math.random(1, #symbols)],
            TextColor3 = math.random() > 0.5 and CONFIG.Colors.Primary or (math.random() > 0.5 and CONFIG.Colors.Secondary or CONFIG.Colors.Cyraa),
            TextSize = math.random(10, 20),
            Size = UDim2.new(0, 24, 0, 24),
            Position = UDim2.new(math.random(), 0, math.random(), 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Parent = pContainer,
            ZIndex = 2,
            Font = Enum.Font.GothamBold,
            TextTransparency = 0.3
        })
        local dur = math.random(6, 14)
        Tween(star, dur, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {
            Position = star.Position + UDim2.new(0, math.random(-60, 60), 0, math.random(-80, 80)),
            TextTransparency = 1,
            Rotation = math.random(-90, 90)
        })
        task.delay(dur + 0.2, function() if star then star:Destroy() end end)
    end

    local function SpawnOrbit(radius, duration, color, clockwise)
        local orbit = Create("Frame", {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.42, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Parent = pContainer,
            ZIndex = 2
        })
        local dot = Create("Frame", {
            Size = UDim2.new(0, 5, 0, 5),
            Position = UDim2.new(0, radius, 0, -2),
            BackgroundColor3 = color,
            BackgroundTransparency = 0.15,
            BorderSizePixel = 0,
            Parent = orbit,
            ZIndex = 2
        })
        Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = dot})
        Create("ImageLabel", {Size = UDim2.new(3, 0, 3, 0), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Image = "rbxassetid://5880482965", ImageColor3 = color, ImageTransparency = 0.7, Parent = dot, ZIndex = 1})
        task.spawn(function()
            while orbit.Parent do
                Tween(orbit, duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, {Rotation = orbit.Rotation + (clockwise and 360 or -360)})
                task.wait(duration)
            end
        end)
    end

    task.spawn(function() while keyFrame.Parent do SpawnOrb() task.wait(math.random() * 0.8 + 0.4) end end)
    task.spawn(function() while keyFrame.Parent do SpawnStar() task.wait(math.random() * 1.2 + 0.8) end end)
    SpawnOrbit(150, 9, CONFIG.Colors.Primary, true)
    SpawnOrbit(130, 13, CONFIG.Colors.Secondary, false)
    SpawnOrbit(170, 16, CONFIG.Colors.Cyraa, true)
    SpawnOrbit(110, 11, CONFIG.Colors.Tora, false)

    --// ═══ STATS BLOCK ═══
    local statsBlock = Create("Frame", {
        Size = UDim2.new(1, -50, 0, 46),
        Position = UDim2.new(0.5, 0, 0, 14),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = CONFIG.Colors.Surface,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        Parent = keyFrame,
        ZIndex = 15
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = statsBlock})
    Create("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 14), Parent = statsBlock})

    local function MakeStatCard(icon)
        local card = Create("Frame", {Size = UDim2.new(0, 120, 0, 34), BackgroundColor3 = CONFIG.Colors.SurfaceLight, BackgroundTransparency = 0.35, BorderSizePixel = 0, Parent = statsBlock, ZIndex = 16})
        Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = card})
        Create("TextLabel", {Size = UDim2.new(0, 26, 1, 0), Position = UDim2.new(0, 6, 0, 0), BackgroundTransparency = 1, Text = icon, Font = Enum.Font.GothamBold, TextSize = 15, Parent = card, ZIndex = 17})
        return Create("TextLabel", {Name = "Value", Size = UDim2.new(0, 80, 1, 0), Position = UDim2.new(0, 30, 0, 0), BackgroundTransparency = 1, Text = "--", TextColor3 = CONFIG.Colors.Text, Font = Enum.Font.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, Parent = card, ZIndex = 17})
    end

    local fpsLabel = MakeStatCard("⚡")
    local msLabel = MakeStatCard("📶")
    local timeLabel = MakeStatCard("🕐")

    --// ═══ TITLE ═══
    local titleBox = Create("Frame", {Size = UDim2.new(1, 0, 0, 95), Position = UDim2.new(0, 0, 0, 68), BackgroundTransparency = 1, Parent = keyFrame, ZIndex = 10})

    local titleLbl = Create("TextLabel", {
        Size = UDim2.new(1, -40, 0, 54),
        Position = UDim2.new(0.5, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        Text = "MAXX HUB",
        TextColor3 = CONFIG.Colors.Text,
        Font = Enum.Font.GothamBlack,
        TextSize = 50,
        Parent = titleBox,
        ZIndex = 10
    })
    local titleGrad = Create("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 185, 0)),
            ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 230, 255)),
            ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 185, 0))
        }),
        Rotation = 0, Parent = titleLbl
    })
    task.spawn(function()
        while titleLbl.Parent do
            Tween(titleGrad, 3.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {Rotation = 180})
            task.wait(3.5)
            Tween(titleGrad, 3.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {Rotation = 0})
            task.wait(3.5)
        end
    end)

    Create("TextLabel", {Size = UDim2.new(1, -40, 0, 20), Position = UDim2.new(0.5, 0, 0, 56), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Text = "P R E M I U M   A C C E S S", TextColor3 = CONFIG.Colors.SubText, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = titleBox, ZIndex = 10})

    local verBadge = Create("TextLabel", {Size = UDim2.new(0, 70, 0, 22), Position = UDim2.new(0.5, 0, 0, 80), AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = CONFIG.Colors.Surface, BackgroundTransparency = 0.3, BorderSizePixel = 0, Text = "v5.0", TextColor3 = CONFIG.Colors.Primary, Font = Enum.Font.GothamBold, TextSize = 12, Parent = titleBox, ZIndex = 10})
    Create("UICorner", {CornerRadius = UDim.new(0, 11), Parent = verBadge})
    Create("UIStroke", {Color = CONFIG.Colors.Primary, Transparency = 0.6, Thickness = 1, Parent = verBadge})

    --// ═══ UPDATES BLOCK ═══
    local updatesBlock = Create("Frame", {
        Size = UDim2.new(1, -60, 0, 90),
        Position = UDim2.new(0.5, 0, 0, 175),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = CONFIG.Colors.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Parent = keyFrame,
        ZIndex = 10
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = updatesBlock})
    Create("UIStroke", {Color = CONFIG.Colors.Secondary, Transparency = 0.7, Thickness = 1.2, Parent = updatesBlock})

    Create("TextLabel", {Size = UDim2.new(1, -20, 0, 22), Position = UDim2.new(0.5, 0, 0, 8), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Text = "📝  L A T E S T   U P D A T E S", TextColor3 = CONFIG.Colors.Secondary, Font = Enum.Font.GothamBold, TextSize = 13, Parent = updatesBlock, ZIndex = 11})
    Create("TextLabel", {Size = UDim2.new(1, -24, 0, 55), Position = UDim2.new(0.5, 0, 0, 32), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Text = "• Added Mystrix Hub (Op Script)\n• 5-script scrolling selector\n• Delta executor compatibility", TextColor3 = CONFIG.Colors.SubText, Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Parent = updatesBlock, ZIndex = 11})

    --// ═══ KEY INPUT ═══
    local inputHolder = Create("Frame", {Size = UDim2.new(1, -60, 0, 58), Position = UDim2.new(0.5, 0, 0, 280), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Parent = keyFrame, ZIndex = 10})

    local inputBg = Create("Frame", {Size = UDim2.new(1, 0, 0, 50), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = CONFIG.Colors.Surface, BackgroundTransparency = 0.2, BorderSizePixel = 0, Parent = inputHolder, ZIndex = 10})
    Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = inputBg})

    local inputStroke = Create("UIStroke", {Color = CONFIG.Colors.SubText, Transparency = 0.5, Thickness = 2, Parent = inputBg})

    Create("ImageLabel", {Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0, 14, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Image = "rbxassetid://3926307971", ImageRectOffset = Vector2.new(84, 284), ImageRectSize = Vector2.new(36, 36), ImageColor3 = CONFIG.Colors.SubText, Parent = inputBg, ZIndex = 11})

    local keyInput = Create("TextBox", {
        Size = UDim2.new(1, -55, 1, 0), Position = UDim2.new(0, 42, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
        BackgroundTransparency = 1, Text = "", PlaceholderText = "Enter Key...", PlaceholderColor3 = CONFIG.Colors.SubText,
        TextColor3 = CONFIG.Colors.Text, Font = Enum.Font.GothamSemibold, TextSize = 15, ClearTextOnFocus = false,
        Parent = inputBg, ZIndex = 11
    })

    keyInput.Focused:Connect(function()
        Tween(inputStroke, 0.3, nil, nil, {Color = CONFIG.Colors.Primary, Transparency = 0.15})
        Tween(inputBg, 0.3, nil, nil, {BackgroundTransparency = 0.05})
    end)
    keyInput.FocusLost:Connect(function()
        Tween(inputStroke, 0.3, nil, nil, {Color = CONFIG.Colors.SubText, Transparency = 0.5})
        Tween(inputBg, 0.3, nil, nil, {BackgroundTransparency = 0.2})
    end)

--// PART 2 BELOW — COPY NEXT
    --// Status
    local statusLbl = Create("TextLabel", {Size = UDim2.new(1, -60, 0, 24), Position = UDim2.new(0.5, 0, 0, 342), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Text = "", TextColor3 = CONFIG.Colors.Success, Font = Enum.Font.GothamBold, TextSize = 13, Parent = keyFrame, ZIndex = 10})

    --// Buttons Container
    local btnContainer = Create("Frame", {Size = UDim2.new(1, -60, 0, 180), Position = UDim2.new(0.5, 0, 0, 380), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Parent = keyFrame, ZIndex = 10})

    --// Footer
    Create("TextLabel", {Size = UDim2.new(1, -40, 0, 20), Position = UDim2.new(0.5, 0, 1, -26), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Text = "discord.gg/nqEUcZm4s  •  MAXX HUB © 2026", TextColor3 = CONFIG.Colors.SubText, Font = Enum.Font.Gotham, TextSize = 11, Parent = keyFrame, ZIndex = 10})

    --// ═══════════════════════════════════════════════════════
    --//  SCRIPT SELECTOR FRAME (Hidden)
    --// ═══════════════════════════════════════════════════════
    local selectorFrame = Create("Frame", {
        Name = "SelectorFrame",
        Size = UDim2.new(0, 520, 0, 640),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = CONFIG.Colors.Background,
        BackgroundTransparency = 0.06,
        BorderSizePixel = 0,
        Parent = screenGui,
        Visible = false,
        ClipsDescendants = true
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 26), Parent = selectorFrame})
    Create("UIAspectRatioConstraint", {AspectRatio = 0.81, AspectType = Enum.AspectType.FitWithinMaxSize, DominantAxis = Enum.DominantAxis.Width, Parent = selectorFrame})
    Create("UIStroke", {Color = CONFIG.Colors.Primary, Transparency = 0.6, Thickness = 1.6, Parent = selectorFrame})

    local selAmbient = Create("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Parent = selectorFrame, ZIndex = 0})
    local selAmbGrad = Create("UIGradient", {
        Color = ColorSequence.new({ColorSequenceKeypoint.new(0, CONFIG.Colors.Cyraa), ColorSequenceKeypoint.new(0.5, CONFIG.Colors.Tora), ColorSequenceKeypoint.new(1, CONFIG.Colors.Cyraa)}),
        Transparency = NumberSequence.new(0.94, 0.97), Rotation = -45, Parent = selAmbient
    })

    -- Selector Title
    local selTitle = Create("TextLabel", {Size = UDim2.new(1, -40, 0, 50), Position = UDim2.new(0.5, 0, 0, 35), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Text = "SCRIPT SELECTOR", TextColor3 = CONFIG.Colors.Text, Font = Enum.Font.GothamBlack, TextSize = 40, Parent = selectorFrame, ZIndex = 10})
    local selTitleGrad = Create("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, CONFIG.Colors.Cyraa), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, CONFIG.Colors.Tora)}), Rotation = 0, Parent = selTitle})
    task.spawn(function()
        while selTitle.Parent do
            Tween(selTitleGrad, 4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {Rotation = 180})
            task.wait(4)
            Tween(selTitleGrad, 4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, {Rotation = 0})
            task.wait(4)
        end
    end)

    Create("TextLabel", {Size = UDim2.new(1, -40, 0, 20), Position = UDim2.new(0.5, 0, 0, 86), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Text = "C H O O S E   Y O U R   S C R I P T", TextColor3 = CONFIG.Colors.SubText, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = selectorFrame, ZIndex = 10})

    --// Scrolling Grid Container
    local scrollFrame = Create("ScrollingFrame", {
        Size = UDim2.new(1, -40, 1, -140),
        Position = UDim2.new(0.5, 0, 0, 110),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        Parent = selectorFrame,
        ZIndex = 10,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = CONFIG.Colors.SubText,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 650)
    })

    local gridLayout = Create("UIGridLayout", {
        CellSize = UDim2.new(0, 230, 0, 195),
        CellPadding = UDim2.new(0, 16, 0, 12),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Parent = scrollFrame
    })

    --// Script Block Factory
    local function MakeScriptBlock(name, desc, color)
        local block = Create("Frame", {
            Size = UDim2.new(0, 230, 0, 195),
            BackgroundColor3 = CONFIG.Colors.Surface,
            BackgroundTransparency = 0.15,
            BorderSizePixel = 0,
            Parent = scrollFrame,
            ZIndex = 10
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 16), Parent = block})
        Create("UIStroke", {Color = color, Transparency = 0.5, Thickness = 1.5, Parent = block})

        Create("TextLabel", {
            Size = UDim2.new(1, -16, 0, 26),
            Position = UDim2.new(0.5, 0, 0, 10),
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            Text = name,
            TextColor3 = color,
            Font = Enum.Font.GothamBlack,
            TextSize = 20,
            Parent = block,
            ZIndex = 11
        })

        Create("TextLabel", {
            Size = UDim2.new(1, -20, 0, 40),
            Position = UDim2.new(0.5, 0, 0, 38),
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            Text = desc,
            TextColor3 = CONFIG.Colors.SubText,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextWrapped = true,
            Parent = block,
            ZIndex = 11
        })

        local status = Create("TextLabel", {
            Size = UDim2.new(1, -20, 0, 16),
            Position = UDim2.new(0.5, 0, 0, 82),
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            Text = "✓ Ready to execute",
            TextColor3 = CONFIG.Colors.Success,
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            Parent = block,
            ZIndex = 11
        })

        local execContainer = Create("Frame", {
            Size = UDim2.new(1, -20, 0, 58),
            Position = UDim2.new(0.5, 0, 0, 108),
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            Parent = block,
            ZIndex = 11
        })

        return status, execContainer
    end

    -- Create all 5 blocks
    local cyraaStatus, cyraaExecContainer = MakeScriptBlock("⚡  CYRAA HUB", "Original Lucky Block executor\nStable & optimized performance", CONFIG.Colors.Cyraa)
    local toraStatus, toraExecContainer = MakeScriptBlock("🔥  TORA IS ME", "Alternative Lucky Block script\nEnhanced features & bypasses", CONFIG.Colors.Tora)
    local fartezStatus, fartezExecContainer = MakeScriptBlock("💥  FARTEZ HUB", "Powerful Lucky Block executor\nAdvanced automation tools", CONFIG.Colors.Fartez)
    local notznxStatus, notznxExecContainer = MakeScriptBlock("🌌  NOTZNX", "Lightweight Lucky Block script\nFast & reliable execution", CONFIG.Colors.NotZnx)
    local mystrixStatus, mystrixExecContainer = MakeScriptBlock("🌀  MYSTRIX HUB", "Op Script\n⚠️ Contains its own key system", CONFIG.Colors.Mystrix)

    -- Update Mystrix status to reflect key requirement
    mystrixStatus.Text = "🔑 Requires external key"
    mystrixStatus.TextColor3 = CONFIG.Colors.Warning

    -- Selector Footer
    Create("TextLabel", {Size = UDim2.new(1, -40, 0, 20), Position = UDim2.new(0.5, 0, 1, -26), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, Text = "MAXX HUB  •  Multi-Script Platform  •  discord.gg/nqEUcZm4s", TextColor3 = CONFIG.Colors.SubText, Font = Enum.Font.Gotham, TextSize = 11, Parent = selectorFrame, ZIndex = 10})

--// PART 3 BELOW — COPY NEXT
    --// ═══════════════════════════════════════════════════════
    --//  BUTTON FACTORY
    --// ═══════════════════════════════════════════════════════
    local function MakeButton(name, text, parent, pos, accent, callback)
        local btn = Create("TextButton", {
            Name = name, Size = UDim2.new(1, 0, 0, 50), Position = pos,
            BackgroundColor3 = CONFIG.Colors.Surface, BackgroundTransparency = 0.2,
            Text = text, TextColor3 = CONFIG.Colors.Text, Font = Enum.Font.GothamBold,
            TextSize = 15, AutoButtonColor = false, Parent = parent, ZIndex = 10, ClipsDescendants = true
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = btn})
        Create("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, accent), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, accent)}), Transparency = NumberSequence.new(0.88, 0.92), Rotation = 90, Parent = btn})
        local stroke = Create("UIStroke", {Color = accent, Transparency = 0.45, Thickness = 1.5, Parent = btn})
        
        if name == "DiscordBtn" then
            Create("ImageLabel", {Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0, 16, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Image = "rbxassetid://3926307971", ImageRectOffset = Vector2.new(404, 844), ImageRectSize = Vector2.new(36, 36), ImageColor3 = Color3.new(1, 1, 1), Parent = btn, ZIndex = 11})
            btn.Text = "   " .. text
        end
        
        btn.MouseEnter:Connect(function()
            Tween(btn, 0.35, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, {Size = UDim2.new(1.02, 0, 0, 52), BackgroundTransparency = 0.05})
            Tween(stroke, 0.3, nil, nil, {Transparency = 0.15})
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, 0.35, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, {Size = UDim2.new(1, 0, 0, 50), BackgroundTransparency = 0.2})
            Tween(stroke, 0.3, nil, nil, {Transparency = 0.45})
        end)
        btn.MouseButton1Down:Connect(function(x, y)
            Ripple(btn, Vector2.new(x, y) - btn.AbsolutePosition)
            Tween(btn, 0.1, nil, nil, {Size = UDim2.new(0.98, 0, 0, 48)})
        end)
        btn.MouseButton1Up:Connect(function()
            Tween(btn, 0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, {Size = UDim2.new(1, 0, 0, 50)})
        end)
        btn.MouseButton1Click:Connect(function() if callback then callback() end end)
        return btn
    end

    --// ═══════════════════════════════════════════════════════
    --//  CORE LOGIC
    --// ═══════════════════════════════════════════════════════
    local function ExecuteScript(url, statusLabel, btn, btnText)
        local ok, result = pcall(function()
            local src = game:HttpGet(url, true)
            local fn = loadstring(src)
            if not fn then error("Failed to compile script") end
            fn()
        end)
        if not ok then
            warn("[MAXX HUB] Execution error: " .. tostring(result))
            if statusLabel then
                statusLabel.Text = "✕ Execution failed"
                statusLabel.TextColor3 = CONFIG.Colors.Error
            end
            if btn then
                btn.Text = btnText
                btn.TextColor3 = CONFIG.Colors.Text
            end
        end
    end

    local function ShowSelector()
        statusLbl.Text = "✓  Access granted"
        statusLbl.TextColor3 = CONFIG.Colors.Success
        task.wait(0.4)
        
        Tween(keyFrame, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {Position = UDim2.new(0.5, 0, 0.5, -30), BackgroundTransparency = 1})
        for _, d in ipairs(keyFrame:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                Tween(d, 0.4, nil, nil, {TextTransparency = 1})
            elseif d:IsA("Frame") and d.BackgroundTransparency < 1 and d ~= keyFrame and d ~= pContainer and d ~= ambient then
                Tween(d, 0.4, nil, nil, {BackgroundTransparency = 1})
            end
        end
        Tween(blurOverlay, 0.5, nil, nil, {BackgroundTransparency = 0.6})
        
        task.wait(0.5)
        keyFrame.Visible = false
        
        selectorFrame.Visible = true
        selectorFrame.Size = UDim2.new(0, 0, 0, 0)
        selectorFrame.BackgroundTransparency = 1
        Tween(selectorFrame, 0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {Size = UDim2.new(0, 520, 0, 640), BackgroundTransparency = 0.06})
        
        for _, d in ipairs(selectorFrame:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                local ot = d.TextTransparency
                d.TextTransparency = 1
                Tween(d, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {TextTransparency = ot}, 0.3)
            elseif d:IsA("Frame") and d.BackgroundTransparency < 1 and d ~= selectorFrame then
                local ob = d.BackgroundTransparency
                d.BackgroundTransparency = 1
                Tween(d, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {BackgroundTransparency = ob}, 0.2)
            end
        end
    end

    local function CheckKey()
        local input = keyInput.Text:gsub("^%s*(.-)%s*$", "%1")
        if input == "" then
            statusLbl.Text = "⚠  Enter your access key"
            statusLbl.TextColor3 = CONFIG.Colors.Warning
            return
        end
        statusLbl.Text = "⏳  Verifying key..."
        statusLbl.TextColor3 = CONFIG.Colors.Secondary
        task.wait(0.7)
        
        if input == CONFIG.Key then
            ShowSelector()
        else
            statusLbl.Text = "✕  Invalid key. Get key from Discord."
            statusLbl.TextColor3 = CONFIG.Colors.Error
            local bp = keyFrame.Position
            for i = 1, 6 do
                keyFrame.Position = bp + UDim2.new(0, math.random(-10, 10), 0, 0)
                RunService.Heartbeat:Wait()
            end
            keyFrame.Position = bp
        end
    end

    local function GetKey()
        statusLbl.Text = "🔗  discord.gg/nqEUcZm4s"
        statusLbl.TextColor3 = CONFIG.Colors.Secondary
        pcall(function() if setclipboard then setclipboard(CONFIG.DiscordLink) statusLbl.Text = "📋  Copied to clipboard!" end end)
    end

    local function JoinDiscord()
        statusLbl.Text = "🔗  Copied Discord invite"
        statusLbl.TextColor3 = Color3.fromRGB(88, 101, 242)
        pcall(function() if setclipboard then setclipboard(CONFIG.DiscordLink) end end)
    end

    --// Key System Buttons
    MakeButton("CheckKeyBtn", "🔐  Check Key", btnContainer, UDim2.new(0, 0, 0, 0), CONFIG.Colors.Primary, CheckKey)
    MakeButton("GetKeyBtn", "🎁  Get Key", btnContainer, UDim2.new(0, 0, 0, 62), CONFIG.Colors.Secondary, GetKey)
    MakeButton("DiscordBtn", "Join Discord", btnContainer, UDim2.new(0, 0, 0, 124), Color3.fromRGB(88, 101, 242), JoinDiscord)

    --// ═══════════════════════════════════════════════════════
    --//  EXECUTE BUTTONS  (Enhanced Visibility)
    --// ═══════════════════════════════════════════════════════
    local function MakeExecuteBtn(parent, accent, text, url, statusLblRef)
        local glow = Create("ImageLabel", {
            Name = "Glow",
            Size = UDim2.new(1, 24, 1, 24),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = "rbxassetid://5880482965",
            ImageColor3 = accent,
            ImageTransparency = 0.92,
            Parent = parent,
            ZIndex = 11,
        })

        local btn = Create("TextButton", {
            Size = UDim2.new(1, 0, 0, 58),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = accent,
            BackgroundTransparency = 0.05,
            Text = text,
            TextColor3 = CONFIG.Colors.Text,
            Font = Enum.Font.GothamBlack,
            TextSize = 17,
            AutoButtonColor = false,
            Parent = parent,
            ZIndex = 12,
            ClipsDescendants = true
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 14), Parent = btn})
        local stroke = Create("UIStroke", {Color = accent, Transparency = 0.15, Thickness = 2.5, Parent = btn})
        Create("UIGradient", {Color = ColorSequence.new({ColorSequenceKeypoint.new(0, accent), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, accent)}), Transparency = NumberSequence.new(0.72, 0.80), Rotation = 90, Parent = btn})
        
        btn.MouseEnter:Connect(function()
            Tween(btn, 0.35, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, {Size = UDim2.new(1.05, 0, 0, 62), BackgroundTransparency = 0})
            Tween(stroke, 0.3, nil, nil, {Transparency = 0, Thickness = 3.5})
            Tween(glow, 0.3, nil, nil, {ImageTransparency = 0.78})
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, 0.35, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, {Size = UDim2.new(1, 0, 0, 58), BackgroundTransparency = 0.05})
            Tween(stroke, 0.3, nil, nil, {Transparency = 0.15, Thickness = 2.5})
            Tween(glow, 0.3, nil, nil, {ImageTransparency = 0.92})
        end)
        btn.MouseButton1Down:Connect(function(x, y)
            Ripple(btn, Vector2.new(x, y) - btn.AbsolutePosition)
            Tween(btn, 0.1, nil, nil, {Size = UDim2.new(0.97, 0, 0, 56)})
            Tween(glow, 0.1, nil, nil, {ImageTransparency = 0.7})
        end)
        btn.MouseButton1Up:Connect(function()
            Tween(btn, 0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, {Size = UDim2.new(1, 0, 0, 58)})
            Tween(glow, 0.3, nil, nil, {ImageTransparency = 0.92})
        end)
        
        btn.MouseButton1Click:Connect(function()
            btn.Text = "⚡  Executing..."
            btn.TextColor3 = CONFIG.Colors.Success
            statusLblRef.Text = "⏳  Loading script..."
            statusLblRef.TextColor3 = CONFIG.Colors.Warning
            task.wait(0.5)
            
            task.spawn(function()
                ExecuteScript(url, statusLblRef, btn, text)
            end)
            
            statusLblRef.Text = "✓  Script executed!"
            statusLblRef.TextColor3 = CONFIG.Colors.Success
            task.wait(0.8)
            
            Tween(selectorFrame, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In, {Size = UDim2.new(0, 0, 0, 0), Rotation = 4})
            Tween(blurOverlay, 0.5, nil, nil, {BackgroundTransparency = 1})
            task.wait(0.5)
            screenGui:Destroy()
        end)
        
        return btn
    end

    -- Create execute buttons for all 5 scripts
    MakeExecuteBtn(cyraaExecContainer, CONFIG.Colors.Cyraa, "▶  EXECUTE CYRAA", CONFIG.ScriptURL, cyraaStatus)
    MakeExecuteBtn(toraExecContainer, CONFIG.Colors.Tora, "▶  EXECUTE TORA", CONFIG.ScriptURL2, toraStatus)
    MakeExecuteBtn(fartezExecContainer, CONFIG.Colors.Fartez, "▶  EXECUTE FARTEZ", CONFIG.ScriptURL3, fartezStatus)
    MakeExecuteBtn(notznxExecContainer, CONFIG.Colors.NotZnx, "▶  EXECUTE NOTZNX", CONFIG.ScriptURL4, notznxStatus)
    MakeExecuteBtn(mystrixExecContainer, CONFIG.Colors.Mystrix, "▶  EXECUTE MYSTRIX", CONFIG.ScriptURL5, mystrixStatus)

--// PART 4 BELOW — COPY NEXT
    --// ═══════════════════════════════════════════════════════
    --//  ENTRANCE ANIMATION
    --// ═══════════════════════════════════════════════════════
    keyFrame.Size = UDim2.new(0, 0, 0, 0)
    keyFrame.Rotation = -4

    task.wait(0.3)
    Tween(keyFrame, 0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out, {Size = UDim2.new(0, 520, 0, 640), Rotation = 0})

    for _, child in ipairs(keyFrame:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            local ot = child.TextTransparency
            child.TextTransparency = 1
            Tween(child, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {TextTransparency = ot}, 0.4)
        elseif child:IsA("Frame") and child.BackgroundTransparency < 1 and child ~= keyFrame and child ~= pContainer and child ~= ambient then
            local ob = child.BackgroundTransparency
            child.BackgroundTransparency = 1
            Tween(child, 0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, {BackgroundTransparency = ob}, 0.35)
        end
    end

    --// Ambient rotations
    task.spawn(function()
        while ambient.Parent do
            Tween(ambGrad, 12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, {Rotation = ambGrad.Rotation + 180})
            task.wait(12)
        end
    end)
    task.spawn(function()
        while selAmbient.Parent do
            Tween(selAmbGrad, 12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, {Rotation = selAmbGrad.Rotation + 180})
            task.wait(12)
        end
    end)

    --// Stats loops (with pcall to prevent crash if stats unavailable)
    local lastUp = tick()
    local fc = 0
    RunService.RenderStepped:Connect(function()
        fc += 1
        local n = tick()
        if n - lastUp >= 0.5 then
            fpsLabel.Text = tostring(math.floor(fc / (n - lastUp)))
            fc = 0
            lastUp = n
            
            local ok, ping = pcall(function()
                return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            end)
            if ok and ping then
                msLabel.Text = string.format("%.0f", ping) .. " ms"
                msLabel.TextColor3 = ping < 100 and CONFIG.Colors.Success or (ping < 200 and CONFIG.Colors.Warning or CONFIG.Colors.Error)
            else
                msLabel.Text = "-- ms"
                msLabel.TextColor3 = CONFIG.Colors.SubText
            end
        end
    end)
    task.spawn(function()
        while keyFrame.Parent do
            timeLabel.Text = os.date("%H:%M:%S")
            task.wait(1)
        end
    end)

    --// Input handling
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter then
            if keyInput:IsFocused() then CheckKey() end
        end
    end)

    print("[MAXX HUB] Loaded successfully | 5-Script Platform | Delta Ready")
end)

if not success then
    warn("[MAXX HUB] CRITICAL ERROR: " .. tostring(err))
    pcall(function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
        local lbl = Instance.new("TextLabel", gui)
        lbl.Size = UDim2.new(1, 0, 0, 100)
        lbl.Position = UDim2.new(0, 0, 0.5, -50)
        lbl.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
        lbl.TextColor3 = Color3.fromRGB(255, 50, 50)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 18
        lbl.Text = "[MAXX HUB] Error: " .. tostring(err)
    end)
end
--// END OF SCRIPT
