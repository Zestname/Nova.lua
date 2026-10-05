local Nova = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local NORMAL_SPEED = 16
local SPRINT_SPEED = 28
local NORMAL_JUMP = 50
local BOOST_JUMP = 75

local RED = Color3.fromRGB(235, 25, 35)
local BLACK = Color3.fromRGB(5, 5, 7)
local DARK = Color3.fromRGB(10, 10, 13)
local CARD = Color3.fromRGB(20, 20, 25)
local WHITE = Color3.fromRGB(240, 240, 245)
local GRAY = Color3.fromRGB(145, 145, 155)

function Nova.Init()

	local PlayerGui = Player:WaitForChild("PlayerGui")

	local old = PlayerGui:FindFirstChild("NOVAGui")
	if old then
		old:Destroy()
	end

	local Character
	local Humanoid

	local function setupCharacter(char)
		Character = char
		Humanoid = char:WaitForChild("Humanoid")
		Humanoid.WalkSpeed = NORMAL_SPEED
		Humanoid.JumpPower = NORMAL_JUMP
	end

	if Player.Character then
		setupCharacter(Player.Character)
	end

	Player.CharacterAdded:Connect(setupCharacter)

	-- GUI
	local Gui = Instance.new("ScreenGui")
	Gui.Name = "NOVAGui"
	Gui.ResetOnSpawn = false
	Gui.Parent = PlayerGui

	local Main = Instance.new("Frame")
	Main.Size = UDim2.new(0, 720, 0, 440)
	Main.Position = UDim2.new(0.5, -360, 0.5, -220)
	Main.BackgroundColor3 = BLACK
	Main.BorderSizePixel = 0
	Main.Parent = Gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = Main

	local stroke = Instance.new("UIStroke")
	stroke.Color = RED
	stroke.Thickness = 1.5
	stroke.Parent = Main

	-- HEADER
	local Header = Instance.new("Frame")
	Header.Size = UDim2.new(1, 0, 0, 65)
	Header.BackgroundColor3 = DARK
	Header.BorderSizePixel = 0
	Header.Parent = Main

	local Logo = Instance.new("TextLabel")
	Logo.Size = UDim2.new(0, 50, 0, 50)
	Logo.Position = UDim2.new(0, 12, 0, 7)
	Logo.BackgroundColor3 = RED
	Logo.Text = "N"
	Logo.TextColor3 = WHITE
	Logo.TextSize = 28
	Logo.Font = Enum.Font.GothamBold
	Logo.Parent = Header

	local logoCorner = Instance.new("UICorner")
	logoCorner.CornerRadius = UDim.new(0, 8)
	logoCorner.Parent = Logo

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(0, 300, 0, 30)
	Title.Position = UDim2.new(0, 75, 0, 10)
	Title.BackgroundTransparency = 1
	Title.Text = "NOVA"
	Title.TextColor3 = WHITE
	Title.TextSize = 22
	Title.Font = Enum.Font.GothamBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = Header

	local Subtitle = Instance.new("TextLabel")
	Subtitle.Size = UDim2.new(0, 300, 0, 20)
	Subtitle.Position = UDim2.new(0, 76, 0, 35)
	Subtitle.BackgroundTransparency = 1
	Subtitle.Text = "CONTROL PANEL"
	Subtitle.TextColor3 = RED
	Subtitle.TextSize = 11
	Subtitle.Font = Enum.Font.GothamBold
	Subtitle.TextXAlignment = Enum.TextXAlignment.Left
	Subtitle.Parent = Header

	-- SIDEBAR
	local Sidebar = Instance.new("Frame")
	Sidebar.Size = UDim2.new(0, 165, 1, -65)
	Sidebar.Position = UDim2.new(0, 0, 0, 65)
	Sidebar.BackgroundColor3 = DARK
	Sidebar.BorderSizePixel = 0
	Sidebar.Parent = Main

	local sideLayout = Instance.new("UIListLayout")
	sideLayout.Padding = UDim.new(0, 6)
	sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	sideLayout.Parent = Sidebar

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 15)
	padding.Parent = Sidebar

	-- CONTENT
	local Content = Instance.new("Frame")
	Content.Size = UDim2.new(1, -165, 1, -65)
	Content.Position = UDim2.new(0, 165, 0, 65)
	Content.BackgroundColor3 = BLACK
	Content.BorderSizePixel = 0
	Content.Parent = Main

	local Pages = {}
	local Buttons = {}

	local function createPage(name)
		local Page = Instance.new("ScrollingFrame")
		Page.Name = name
		Page.Size = UDim2.new(1, -30, 1, -30)
		Page.Position = UDim2.new(0, 15, 0, 15)
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.ScrollBarThickness = 3
		Page.Visible = false
		Page.Parent = Content

		local layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 12)
		layout.Parent = Page

		Pages[name] = Page
		return Page
	end

	local function createButton(name)
		local Button = Instance.new("TextButton")
		Button.Size = UDim2.new(1, -20, 0, 42)
		Button.BackgroundColor3 = DARK
		Button.Text = name
		Button.TextColor3 = GRAY
		Button.TextSize = 13
		Button.Font = Enum.Font.GothamBold
		Button.AutoButtonColor = false
		Button.Parent = Sidebar

		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, 7)
		c.Parent = Button

		Buttons[name] = Button
		return Button
	end

	local function createCard(parent, title, description)
		local Card = Instance.new("Frame")
		Card.Size = UDim2.new(1, -5, 0, 75)
		Card.BackgroundColor3 = CARD
		Card.BorderSizePixel = 0
		Card.Parent = parent

		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, 8)
		c.Parent = Card

		local line = Instance.new("Frame")
		line.Size = UDim2.new(0, 3, 1, -20)
		line.Position = UDim2.new(0, 0, 0, 10)
		line.BackgroundColor3 = RED
		line.BorderSizePixel = 0
		line.Parent = Card

		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Size = UDim2.new(1, -30, 0, 25)
		TitleLabel.Position = UDim2.new(0, 18, 0, 10)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Text = title
		TitleLabel.TextColor3 = WHITE
		TitleLabel.TextSize = 14
		TitleLabel.Font = Enum.Font.GothamBold
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		TitleLabel.Parent = Card

		local Desc = Instance.new("TextLabel")
		Desc.Size = UDim2.new(1, -30, 0, 25)
		Desc.Position = UDim2.new(0, 18, 0, 35)
		Desc.BackgroundTransparency = 1
		Desc.Text = description
		Desc.TextColor3 = GRAY
		Desc.TextSize = 11
		Desc.Font = Enum.Font.Gotham
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.Parent = Card

		return Card
	end

	local function createToggle(parent, title, description, callback)
		local Card = createCard(parent, title, description)

		local Toggle = Instance.new("TextButton")
		Toggle.Size = UDim2.new(0, 50, 0, 26)
		Toggle.Position = UDim2.new(1, -65, 0.5, -13)
		Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
		Toggle.Text = ""
		Toggle.Parent = Card

		local tc = Instance.new("UICorner")
		tc.CornerRadius = UDim.new(1, 0)
		tc.Parent = Toggle

		local Circle = Instance.new("Frame")
		Circle.Size = UDim2.new(0, 20, 0, 20)
		Circle.Position = UDim2.new(0, 3, 0.5, -10)
		Circle.BackgroundColor3 = WHITE
		Circle.Parent = Toggle

		local cc = Instance.new("UICorner")
		cc.CornerRadius = UDim.new(1, 0)
		cc.Parent = Circle

		local enabled = false

		Toggle.MouseButton1Click:Connect(function()
			enabled = not enabled

			if enabled then
				Toggle.BackgroundColor3 = RED
				Circle.Position = UDim2.new(1, -23, 0.5, -10)
			else
				Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
				Circle.Position = UDim2.new(0, 3, 0.5, -10)
			end

			callback(enabled)
		end)
	end

	-- PAGES
	local Home = createPage("Home")
	local Movement = createPage("Movement")
	local Debug = createPage("Debug")
	local Teleports = createPage("Teleports")
	local Settings = createPage("Settings")

	-- HOME
	createCard(Home, "PLAYER", "Welcome, " .. Player.Name)
	createCard(Home, "NOVA STATUS", "All systems are ready.")

	-- MOVEMENT
	createToggle(
		Movement,
		"Sprint",
		"Increase WalkSpeed.",
		function(enabled)
			if Humanoid then
				Humanoid.WalkSpeed = enabled and SPRINT_SPEED or NORMAL_SPEED
			end
		end
	)

	createToggle(
		Movement,
		"Jump Boost",
		"Increase JumpPower.",
		function(enabled)
			if Humanoid then
				Humanoid.UseJumpPower = true
				Humanoid.JumpPower = enabled and BOOST_JUMP or NORMAL_JUMP
			end
		end
	)

	-- DEBUG
	local fpsCard = createCard(Debug, "FPS", "Current frame rate")

	local FPS = Instance.new("TextLabel")
	FPS.Size = UDim2.new(0, 80, 0, 30)
	FPS.Position = UDim2.new(1, -100, 0.5, -15)
	FPS.BackgroundTransparency = 1
	FPS.Text = "0"
	FPS.TextColor3 = RED
	FPS.TextSize = 18
	FPS.Font = Enum.Font.GothamBold
	FPS.Parent = fpsCard

	local last = tick()
	local frames = 0

	RunService.RenderStepped:Connect(function()
		frames += 1

		if tick() - last >= 1 then
			FPS.Text = tostring(frames)
			frames = 0
			last = tick()
		end
	end)

	createCard(Debug, "PLAYER", Player.Name)

	-- TELEPORTS
	local function teleport(name)
		local card = createCard(
			Teleports,
			name,
			"Teleport to Workspace." .. name
		)

		local button = Instance.new("TextButton")
		button.Size = UDim2.new(0, 90, 0, 30)
		button.Position = UDim2.new(1, -110, 0.5, -15)
		button.BackgroundColor3 = RED
		button.Text = "GO"
		button.TextColor3 = WHITE
		button.Font = Enum.Font.GothamBold
		button.Parent = card

		button.MouseButton1Click:Connect(function()
			if Character then
				local target = workspace:FindFirstChild(name)

				if target and target:IsA("BasePart") then
					Character:PivotTo(
						target.CFrame + Vector3.new(0, 4, 0)
					)
				end
			end
		end)
	end

	teleport("Spawn")
	teleport("Arena")
	teleport("Shop")

	-- SETTINGS
	createCard(
		Settings,
		"KEYBIND",
		"Press RightShift to open/close NOVA."
	)

	-- NAVIGATION
	local function showPage(name)
		for pageName, page in pairs(Pages) do
			page.Visible = pageName == name
		end

		for buttonName, button in pairs(Buttons) do
			if buttonName == name then
				button.BackgroundColor3 = RED
				button.TextColor3 = WHITE
			else
				button.BackgroundColor3 = DARK
				button.TextColor3 = GRAY
			end
		end
	end

	local HomeButton = createButton("Home")
	local MovementButton = createButton("Movement")
	local DebugButton = createButton("Debug")
	local TeleportButton = createButton("Teleports")
	local SettingsButton = createButton("Settings")

	HomeButton.MouseButton1Click:Connect(function()
		showPage("Home")
	end)

	MovementButton.MouseButton1Click:Connect(function()
		showPage("Movement")
	end)

	DebugButton.MouseButton1Click:Connect(function()
		showPage("Debug")
	end)

	TeleportButton.MouseButton1Click:Connect(function()
		showPage("Teleports")
	end)

	SettingsButton.MouseButton1Click:Connect(function()
		showPage("Settings")
	end)

	showPage("Home")

	-- DRAG
	local dragging = false
	local dragStart
	local startPos

	Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPos = Main.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging then
			if input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch then

				local delta = input.Position - dragStart

				Main.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end
	end)

	-- RIGHT SHIFT
	UserInputService.InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.RightShift then
			Main.Visible = not Main.Visible
		end
	end)

	-- MOBILE
	local Mobile = Instance.new("TextButton")
	Mobile.Size = UDim2.new(0, 50, 0, 50)
	Mobile.Position = UDim2.new(1, -65, 1, -65)
	Mobile.BackgroundColor3 = RED
	Mobile.Text = "N"
	Mobile.TextColor3 = WHITE
	Mobile.TextSize = 22
	Mobile.Font = Enum.Font.GothamBold
	Mobile.Visible = UserInputService.TouchEnabled
	Mobile.Parent = Gui

	local mc = Instance.new("UICorner")
	mc.CornerRadius = UDim.new(1, 0)
	mc.Parent = Mobile

	Mobile.MouseButton1Click:Connect(function()
		Main.Visible = not Main.Visible
	end)

	print("NOVA loaded successfully.")

	return Gui
end

-- BURADA DÜZELTME YAPILDI: Modüül doğrudan çalıştırıldı.
return Nova.Init()
