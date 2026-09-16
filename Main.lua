-- Pixel Hub | Main (Rayfield Edition)

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local v = localPlayer.Name

-- === LIMPEZA DE UIs ÓRFÃS DE EXECUÇÕES ANTERIORES ===
local function limparUIsAntigas()
    local alvos = {}
    if gethui then table.insert(alvos, gethui()) end
    table.insert(alvos, game:GetService("CoreGui"))
    table.insert(alvos, game:GetService("Players").LocalPlayer)
    for _, gui in pairs(alvos) do
        for _, child in pairs(gui:GetChildren()) do
            if child:IsA("ScreenGui") then
                local nome = child.Name:lower()
                if nome == "screengui" or nome == "rayfield-old" or nome == "togglegui_v3" or nome:find("kavo") then
                    pcall(function() child:Destroy() end)
                end
            end
        end
    end
end
limparUIsAntigas()

-- === WINDOW ===
local Window = Rayfield:CreateWindow({
    Name = "Pixel Hub | V3",
    LoadingTitle = "Pixel Hub",
    LoadingSubtitle = "carregando...",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = "PixelHub",
        FileName = "Config"
    },
    KeySystem = false
})

-- === BOTÃO TOGGLE DA UI ===
local screenGui = Instance.new("ScreenGui")
local textButton = Instance.new("TextButton")
local iconImage = Instance.new("ImageLabel")
screenGui.Name = "ToggleGui_V3"
screenGui.Parent = game.CoreGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

textButton.Name = "Toggle"
textButton.Parent = screenGui
textButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
textButton.BackgroundTransparency = 0.35
textButton.Position = UDim2.new(0, 0, 0.454706937, 0)
textButton.Size = UDim2.new(0, 160, 0, 50)
textButton.Font = Enum.Font.SourceSansBold
textButton.Text = "Ativar UI"
textButton.TextColor3 = Color3.fromRGB(128, 187, 219)
textButton.TextSize = 20
textButton.TextXAlignment = Enum.TextXAlignment.Right
textButton.Active = true
textButton.Draggable = true
textButton.ZIndex = 2

iconImage.Name = "Icon"
iconImage.Parent = textButton
iconImage.BackgroundTransparency = 1
iconImage.Position = UDim2.new(0.05, 0, 0.15, 0)
iconImage.Size = UDim2.new(0.22, 0, 0.7, 0)
iconImage.Image = "rbxassetid://3159073754"
iconImage.ScaleType = Enum.ScaleType.Fit
iconImage.ZIndex = 3
iconImage.Active = false

local uiVisible = true
local function setRayfieldVisible(state)
    local gui = gethui and gethui() or game:GetService("CoreGui")
    local achou = false
    for _, child in pairs(gui:GetChildren()) do
        if child:IsA("ScreenGui") and child.Name:lower():find("rayfield") and not child.Name:lower():find("old") then
            child.Enabled = state
            achou = true
        end
    end
    if not achou then
        for _, child in pairs(game:GetService("CoreGui"):GetChildren()) do
            if child:IsA("ScreenGui") and child.Name:lower():find("rayfield") and not child.Name:lower():find("old") then
                child.Enabled = state
            end
        end
    end
end

textButton.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    setRayfieldVisible(uiVisible)
    textButton.Text = uiVisible and "Ativar UI" or "Abrir UI"
end)

-- === TABS ===
local HomeTab      = Window:CreateTab("Home")
local PlayersTab   = Window:CreateTab("Players")
local ScriptsTab   = Window:CreateTab("Scripts")
local FETab        = Window:CreateTab("FE Scripts")
local GamesTab     = Window:CreateTab("Games")
local BFTab        = Window:CreateTab("Blox Fruits")
local HubsTab      = Window:CreateTab("Hubs")
local GuisTab      = Window:CreateTab("Guis")
local AdminsTab    = Window:CreateTab("Admins")
local ToolsTab     = Window:CreateTab("Tools")
local CreditsTab   = Window:CreateTab("Credits")

-- === HOME ===
HomeTab:CreateSection("Welcome, " .. v)
HomeTab:CreateParagraph({Title = "User", Content = v .. " | UID: " .. localPlayer.UserId})
HomeTab:CreateParagraph({Title = "Game", Content = MarketplaceService:GetProductInfo(game.PlaceId).Name .. " | " .. game.PlaceId})
HomeTab:CreateParagraph({Title = "Account Age", Content = localPlayer.AccountAge .. " days"})

HomeTab:CreateButton({
    Name = "Destroy Toggle GUI",
    Callback = function()
        local cg = game:GetService("CoreGui")
        if cg:FindFirstChild("ToggleGui_V3") then
            cg:FindFirstChild("ToggleGui_V3"):Destroy()
        end
    end
})

HomeTab:CreateKeybind({
    Name = "Toggle Keybind",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Callback = function()
        uiVisible = not uiVisible
        setRayfieldVisible(uiVisible)
        textButton.Text = uiVisible and "Ativar UI" or "Abrir UI"
    end
})

HomeTab:CreateSection("Feedback")
HomeTab:CreateInput({
    Name = "Report Bugs",
    PlaceholderText = "descreve o bug",
    RemoveTextAfterFocusLost = true,
    Callback = function(t)
        if t and t ~= "" then print("[Pixel Hub] Report:", t) end
    end
})
HomeTab:CreateInput({
    Name = "Suggestions",
    PlaceholderText = "sugestão",
    RemoveTextAfterFocusLost = true,
    Callback = function(t)
        if t and t ~= "" then print("[Pixel Hub] Suggestion:", t) end
    end
})
HomeTab:CreateInput({
    Name = "Feedback",
    PlaceholderText = "feedback",
    RemoveTextAfterFocusLost = true,
    Callback = function(t)
        if t and t ~= "" then print("[Pixel Hub] Feedback:", t) end
    end
})

-- === PLAYERS ===
PlayersTab:CreateSection("Player")
PlayersTab:CreateToggle({
    Name = "Character Highlight",
    CurrentValue = false,
    Callback = function(state)
        getgenv().enabled = state
        getgenv().filluseteamcolor = true
        getgenv().outlineuseteamcolor = true
        getgenv().fillcolor = Color3.new(0, 0, 0)
        getgenv().outlinecolor = Color3.new(1, 1, 1)
        getgenv().filltrans = 0.5
        getgenv().outlinetrans = 0.5
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/Highlight-ESP.lua"))()
        end)
    end
})

PlayersTab:CreateInput({
    Name = "Hitbox Size",
    PlaceholderText = "ex: 15",
    RemoveTextAfterFocusLost = true,
    Callback = function(t) getgenv().HitboxSize = tonumber(t) or 15 end
})

PlayersTab:CreateToggle({
    Name = "Hitbox (Everyone)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().HitboxEveryone = state
        if state then
            task.spawn(function()
                while getgenv().HitboxEveryone do
                    task.wait()
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= localPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            pcall(function()
                                local hrp = plr.Character.HumanoidRootPart
                                local s = getgenv().HitboxSize or 15
                                hrp.Size = Vector3.new(s, s, s)
                                hrp.Transparency = 0.7
                                hrp.BrickColor = BrickColor.new("Really black")
                                hrp.Material = "Neon"
                                hrp.CanCollide = false
                            end)
                        end
                    end
                end
            end)
        end
    end
})

PlayersTab:CreateToggle({
    Name = "Hitbox (Enemy Only)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().HitboxEnemyOnly = state
        if state then
            task.spawn(function()
                while getgenv().HitboxEnemyOnly do
                    task.wait()
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr.Team ~= localPlayer.Team and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            pcall(function()
                                local hrp = plr.Character.HumanoidRootPart
                                local s = getgenv().HitboxSize or 15
                                hrp.Size = Vector3.new(s, s, s)
                                hrp.Transparency = 0.7
                                hrp.BrickColor = BrickColor.new("Really black")
                                hrp.Material = "Neon"
                                hrp.CanCollide = false
                            end)
                        end
                    end
                end
            end)
        end
    end
})

PlayersTab:CreateInput({
    Name = "Teleport To Player",
    PlaceholderText = "username",
    RemoveTextAfterFocusLost = true,
    Callback = function(t)
        local alvo = Players:FindFirstChild(t)
        if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = alvo.Character.HumanoidRootPart.CFrame
        end
    end
})

PlayersTab:CreateSection("LocalPlayer")
PlayersTab:CreateInput({
    Name = "Set WalkSpeed",
    PlaceholderText = "ex: 50",
    RemoveTextAfterFocusLost = true,
    Callback = function(t)
        pcall(function() localPlayer.Character.Humanoid.WalkSpeed = tonumber(t) or 16 end)
    end
})
PlayersTab:CreateInput({
    Name = "Set JumpPower",
    PlaceholderText = "ex: 100",
    RemoveTextAfterFocusLost = true,
    Callback = function(t)
        pcall(function() localPlayer.Character.Humanoid.JumpPower = tonumber(t) or 50 end)
    end
})
PlayersTab:CreateSlider({
    Name = "FOV",
    Range = {70, 120},
    Increment = 1,
    Suffix = " fov",
    CurrentValue = 70,
    Callback = function(val) workspace.CurrentCamera.FieldOfView = val end
})
PlayersTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(state)
        _G.Noclip = state
        if state then
            task.spawn(function()
                while _G.Noclip do
                    task.wait()
                    pcall(function()
                        localPlayer.Character.Head.CanCollide = false
                        if localPlayer.Character:FindFirstChild("Torso") then localPlayer.Character.Torso.CanCollide = false end
                        if localPlayer.Character:FindFirstChild("UpperTorso") then localPlayer.Character.UpperTorso.CanCollide = false end
                    end)
                end
            end)
        end
    end
})
PlayersTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(state) _G.InfJ = state end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJ then
        pcall(function() localPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end)
    end
end)

-- === SCRIPTS ===
ScriptsTab:CreateSection("Scripts")
ScriptsTab:CreateButton({Name = "Anti Fling", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/B2DCzPeD"))() end)
end})
ScriptsTab:CreateButton({Name = "Anti Attach", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/VcskV/main/Scripts/Anti-Attach"))() end)
end})
ScriptsTab:CreateButton({Name = "Shiftlock For Mobile", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/WQ9NPeDS"))() end)
end})
ScriptsTab:CreateButton({Name = "Hitbox Expander", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/HitboxExpander.lua"))() end)
end})
ScriptsTab:CreateButton({Name = "Effects Disabler (Anti Lag)", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/EffectsDisabler.lua"))() end)
end})
ScriptsTab:CreateButton({Name = "FE Yeet Gui V4", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/FEYeetGuiV4.lua"))() end)
end})
ScriptsTab:CreateButton({Name = "Mobile Fly", Callback = function()
    if game.PlaceId == 2788229376 then
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/DaHood/AntiCheatBypass.lua"))() end)
    end
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/gaz0U0XX"))() end)
end})
ScriptsTab:CreateButton({Name = "R15 To R6", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/Scripts/main/R15-To-R6.lua"))() end)
end})
ScriptsTab:CreateButton({Name = "Walk On Walls", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/RY9cBbdG"))() end)
end})
ScriptsTab:CreateButton({Name = "Keyboard", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))() end)
end})
ScriptsTab:CreateButton({Name = "Simple Spy", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/SimpleSpy.lua"))() end)
end})
ScriptsTab:CreateButton({Name = "Netless", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/vf1d0baT"))() end)
end})

-- === FE SCRIPTS ===
FETab:CreateSection("FE")
FETab:CreateButton({Name = "FE VR (Execute Netless First)", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/Test-3/main/Test-3"))() end)
end})
FETab:CreateButton({Name = "FE Cat", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/FE-Cat/main/FE-Cat"))() end)
end})
FETab:CreateButton({Name = "FE SCP-096", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/EM3gWpGZ"))() end)
end})
FETab:CreateButton({Name = "FE Baller V2", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Lowerrated/roblox-fe-baller-script/main/main"))() end)
end})
FETab:CreateButton({Name = "FE Snake", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastefy.ga/tWBTcE4R/raw", true))() end)
end})
FETab:CreateButton({Name = "FE Fake Gorilla Tag V1", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastefy.ga/osEThPw1/raw", true))() end)
end})
FETab:CreateButton({Name = "FE Fake Lag", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/VM3b0Thg"))() end)
end})
FETab:CreateButton({Name = "FE Free Tools Gamepass", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/h1MBUTui", true))() end)
end})

-- === BLOX FRUITS TAB ===
BFTab:CreateSection("Blox Fruits | Auto Farm Completo")

local function instalarHooks()
    if getgenv()._pxl_hooks_installed then return end
    getgenv()._pxl_hooks_installed = true

    local httpGetOriginal = game.HttpGet
    local httpGetAsyncOriginal = game.HttpGetAsync

    local whitelistFake = [[
return {
    ["awdafaw1dawd"] = true,
    ["vcsk0"] = true,
    ["TOXIC_SOLOZ"] = true,
    ["AstralX0"] = true,
    ["XXMALAYSIA_GGG"] = true,
    ["Aperopoh"] = true,
}
]]
    local blacklistFake = [[return {}]]

    local function substituirURL(url)
        if type(url) ~= "string" then return nil end
        if url:find("Whitelist%.lua") then return whitelistFake end
        if url:find("Blacklist%.lua") then return blacklistFake end
        return nil
    end

    game.HttpGet = newcclosure(function(self, url, ...)
        local fake = substituirURL(url)
        if fake then return fake end
        return httpGetOriginal(self, url, ...)
    end)

    if httpGetAsyncOriginal then
        game.HttpGetAsync = newcclosure(function(self, url, ...)
            local fake = substituirURL(url)
            if fake then return fake end
            return httpGetAsyncOriginal(self, url, ...)
        end)
    end
end

BFTab:CreateButton({
    Name = "⚡ Carregar Blox Fruits Script Completo",
    Callback = function()
        instalarHooks()
        local ok, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/gui3amorim-rgb/pxl-hub/main/bloxfruits.lua"))()
        end)
        if not ok then
            Rayfield:Notify({Title = "Erro BF", Content = tostring(err):sub(1, 200), Duration = 8})
        else
            Rayfield:Notify({Title = "Pixel Hub", Content = "Blox Fruits carregado.", Duration = 5})
        end
    end
})

BFTab:CreateButton({
    Name = "Esconder Pixel Hub",
    Callback = function() setRayfieldVisible(false) end
})
BFTab:CreateButton({
    Name = "Mostrar Pixel Hub",
    Callback = function() setRayfieldVisible(true) end
})

BFTab:CreateSection("Hubs BF Externos")
BFTab:CreateButton({Name = "HoHo Hub", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))() end)
end})
BFTab:CreateButton({Name = "ThunderZ", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/StringV2/StringHub/main/BF.txt", true))() end)
end})

-- === GAMES ===
GamesTab:CreateSection("Server")
GamesTab:CreateButton({Name = "Rejoin", Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, localPlayer)
end})
GamesTab:CreateButton({Name = "Server Hop", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/ServerHop.lua"))() end)
end})

local function botaoJogo(nome, placeId)
    GamesTab:CreateSection(nome)
    GamesTab:CreateButton({Name = "Teleport to " .. nome, Callback = function()
        game:GetService("TeleportService"):Teleport(placeId, localPlayer)
    end})
end

botaoJogo("Arsenal", 286090429)
botaoJogo("BedWars", 6872265039)
botaoJogo("Blox Fruits", 2753915549)
botaoJogo("Brookhaven", 4924922222)
botaoJogo("Combat Warriors", 4282985734)
botaoJogo("Chaos", 6441847031)
botaoJogo("DOORS", 6516141723)
botaoJogo("Da Hood", 2788229376)
botaoJogo("Evade", 9872472334)
botaoJogo("Murder Mystery 2", 142823291)
botaoJogo("Pet Simulator X", 7722306047)
botaoJogo("Phantom Forces", 292439477)
botaoJogo("Pop It Trading", 7346416636)
botaoJogo("Prison Life", 155615604)
botaoJogo("Strucid", 2377868063)

-- === HUBS ===
HubsTab:CreateSection("Hubs")
local hubsList = {
    {"Universal FE", "https://raw.githubusercontent.com/Dvrknvss/UniversalFEScriptHub/main/Script"},
    {"Games HUB V5", "https://raw.githubusercontent.com/TakeModzz/Games-Hub-V5-Selector-Fixed/main/Games"},
    {"Ice Hub", "https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"},
    {"HoHo Hub", "https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"},
    {"BritishHub V6", "https://raw.githubusercontent.com/YourLocalNzi/Ye/main/BHob6"},
    {"Pendulum Hub", "https://raw.githubusercontent.com/Tescalus/Pendulum-Hubs-Source/main/Pendulum%20Hub%20V5.lua"},
    {"VHub", "https://raw.githubusercontent.com/Quan8008/V-Hub/Master/Launch-Screen.lua"},
    {"DomainX Hub", "https://raw.githubusercontent.com/shlexware/DomainX/main/source"},
}
for _, hub in ipairs(hubsList) do
    HubsTab:CreateButton({Name = hub[1], Callback = function()
        pcall(function() loadstring(game:HttpGet(hub[2], true))() end)
    end})
end

-- === GUIS ===
GuisTab:CreateSection("Guis")
GuisTab:CreateButton({Name = "RTX Gui | V3.1.1", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/0G3C94Aw", true))() end)
end})
GuisTab:CreateButton({Name = "Free Gamepasses Gui", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/Scripts/main/Free-gamepasses-gui.lua"))() end)
end})
GuisTab:CreateButton({Name = "FEAG", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/Scripts/main/FEAG.lua"))() end)
end})

-- === ADMINS ===
AdminsTab:CreateSection("Admins")
AdminsTab:CreateButton({Name = "Infinite Yield", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
end})
AdminsTab:CreateButton({Name = "Fates Admin", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))() end)
end})
AdminsTab:CreateButton({Name = "Reviz Admin", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/Caniwq2N", true))() end)
end})

-- === TOOLS ===
ToolsTab:CreateSection("Tools")
ToolsTab:CreateButton({Name = "Punch Tool (Fling)", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastefy.ga/GvnHVjT5/raw", true))() end)
end})
ToolsTab:CreateButton({Name = "Super Tools", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/sQWeMuB0"))() end)
end})
ToolsTab:CreateButton({Name = "F3X", Callback = function()
    pcall(function() loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)() end)
end})
ToolsTab:CreateButton({Name = "Telekinesis", Callback = function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/b/main/Test"))() end)
end})

-- === CREDITS ===
CreditsTab:CreateSection("Créditos")
CreditsTab:CreateParagraph({
    Title = "Pixel Hub",
    Content = "Rebranded do Astral Hub. UI: Rayfield. Migrado em 2026."
})

Rayfield:Notify({
    Title = "Pixel Hub",
    Content = "Bem-vindo, " .. v .. "!",
    Duration = 5
})
