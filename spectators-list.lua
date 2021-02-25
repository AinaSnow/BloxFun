--Credits for Spectators List to Venosu/HexHub Creator

local dragger = {}; do
	local mouse        = game:GetService("Players").LocalPlayer:GetMouse();
	local inputService = game:GetService('UserInputService');
	local heartbeat    = game:GetService("RunService").Heartbeat;
	function dragger.new(frame)
		local s, event = pcall(function()
			return frame.MouseEnter
		end)
	
		if s then
			frame.Active = true;
			
			event:connect(function()
				local input = frame.InputBegan:connect(function(key)
					if key.UserInputType == Enum.UserInputType.MouseButton1 then
						local objectPosition = Vector2.new(mouse.X - frame.AbsolutePosition.X, mouse.Y - frame.AbsolutePosition.Y);
						while heartbeat:wait() and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
							pcall(function()
								frame:TweenPosition(UDim2.new(0, mouse.X - objectPosition.X + (frame.Size.X.Offset * frame.AnchorPoint.X), 0, mouse.Y - objectPosition.Y + (frame.Size.Y.Offset * frame.AnchorPoint.Y)), 'Out', 'Linear', 0.1, true);
							end)
						end
					end
				end)
				
				local leave;
				leave = frame.MouseLeave:connect(function()
					input:disconnect();
					leave:disconnect();
				end)
			end)
		end
	end
end

local SpectatorsList = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ListText = Instance.new("TextLabel")
local Players = Instance.new("TextLabel")

SpectatorsList.Name = "SpectatorsList"
SpectatorsList.Parent = game:WaitForChild("CoreGui")
SpectatorsList.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SpectatorsList.Enabled = false

Frame.Parent = SpectatorsList
Frame.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.699999988, 0, 0, 0)
Frame.Size = UDim2.new(0.150000006, 0, 0.0299999993, 0)
dragger.new(Frame)

ListText.Name = "ListText"
ListText.Parent = Frame
ListText.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
ListText.BackgroundTransparency = 1
ListText.BorderSizePixel = 0
ListText.Size = UDim2.new(1, 0, 1, 0)
ListText.Font = Enum.Font.SourceSansBold
ListText.Text = "Spectators"
ListText.TextColor3 = Color3.new(1, 1, 1)
ListText.TextSize = 20
ListText.TextWrapped = true

Players.Name = "Players"
Players.Parent = Frame
Players.BackgroundColor3 = Color3.new(0.372549, 0.372549, 0.372549)
Players.BackgroundTransparency = 1
Players.BorderSizePixel = 0
Players.Position = UDim2.new(0, 0, 1, 0)
Players.Size = UDim2.new(1, 0, 5, 0)
Players.Font = Enum.Font.SourceSansBold
Players.Text = "loading..."
Players.TextColor3 = Color3.new(1, 1, 1)
Players.TextSize = 16
Players.TextWrapped = true
Players.TextYAlignment = Enum.TextYAlignment.Top

function GetSpectators()
	local CurrentSpectators = ""
	for i,v in pairs(game.Players:GetChildren()) do 
		pcall(function()
			if v ~= game.Players.LocalPlayer then
				if not v.Character then 
					if (v.CameraCF.Value.p - game.Workspace.CurrentCamera.CFrame.p).Magnitude < 10 then 
						if CurrentSpectators == "" then
							CurrentSpectators = v.Name
						else
							CurrentSpectators = CurrentSpectators.. "\n" ..v.Name
						end
					end
				end
			end
		end)
	end
	return CurrentSpectators
end


spawn(function()
	while wait(0.3) do
		if SpectatorsList.Enabled then
			Players.Text = GetSpectators()
		end
	end
end)
