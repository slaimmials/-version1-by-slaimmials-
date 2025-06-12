---@diagnostic disable-next-line: deprecated
function Nothing() end
_G.SecureMethod = "NoSecure"
_G.Mobile = false
local randomString=function(a)if typeof(a)~="number"then error("function string.random: count of char is not a number!")return""end;local b=""for c=1,a do b=b..string.char(math.random(1,255))end;return b end;print(randomString(12))
--local CFrame=CFrame;local Vector3 = Vector3;local Vector2=Vector2;local UDim2=UDim2;local Color3=Color3;local Instance=Instance;local spawn=spawn;local workspace=workspace;local Enum=Enum;local wait=wait;local math=math;local ColorSequence=ColorSequence;local ColorSequenceKeypoint=ColorSequenceKeypoint;local NumberSequence=NumberSequence;local NumberSequenceKeypoint=NumberSequenceKeypoint;
local coreLocked = pcall(function()
	local a=Instance.new("Folder",game:GetService("CoreGui"))
end)
coreLocked=not coreLocked
local guiPlacing
if coreLocked then 
	guiPlacing = game:GetService("Players").LocalPlayer.PlayerGui 
else 
	guiPlacing = game:GetService("CoreGui") 
end

local Colorize = {}
local Drawing = {}
if _G.OptimizeMenu ~= true then
    _G.OptimizeMenu = false
end
local gui = {
    objs = {
        Gui = Instance.new("ScreenGui", guiPlacing),
    },
    page = {nil, 1},
    Loaded = true
}
gui["Hooks"] = {}
gui.objs["Gui"].Name = "RobloxGui"
gui.objs["Gui"].IgnoreGuiInset = true
gui.objs["Gui"].Enabled = true
gui.objs["Gui"].ResetOnSpawn = false
local Draws = Instance.new("Folder", gui.objs["Gui"])
Draws.Name = "Drawings"
do
    local game = game
    local GetService, FindFirstChild = game.GetService, game.FindFirstChild
    local IsA = game.IsA
    local Vector2new, Instancenew, UDim2new = Vector2.new, Instance.new, UDim2.new

    local Workspace = GetService(game, "Workspace");
    local Camera = FindFirstChild(Workspace, "Camera");
    local CoreGui = GetService(game, "CoreGui");

    local BaseDrawingProperties = setmetatable({
        Visible = false,
        Color = Color3.new(),
        Transparency = 0,
        Remove = function()
        end
    }, {
        __add = function(tbl1, tbl2)
            local new = {}
            for i, v in next, tbl1 do
                new[i] = v
            end
            for i, v in next, tbl2 do
                new[i] = v
            end
            return new
        end
    })

    Drawing.new = function(Type, UI)
        UI = Draws
        if (Type == "Text") then
            local TextProperties = ({
                Text = "",
                Font = "",
                Size = 10,
                XAlign = "Center",
                YAlign = "Center",
            } + BaseDrawingProperties)
            local TextLabel = Instancenew("TextLabel")
            TextLabel.Parent = UI
            TextLabel.Text = ""
            TextLabel.BackgroundTransparency = 1
            TextLabel.TextColor3 = TextProperties.Color
            TextLabel.TextSize = TextProperties.Size
            TextLabel.TextXAlignment = Enum.TextXAlignment.Center
            TextLabel.Visible = false
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Position") then
                        TextLabel.Position = UDim2.fromOffset(Value.X,Value.Y)
                        TextProperties.Position = Value
                    end
                    if (Property == "Transparency") then
                        TextLabel.TextTransparency = Value
                        TextProperties.Transparency = Value
                    end
                    if (Property == "Text") then
                        TextLabel.Text = Value
                        TextProperties.Text = Value
                    end
                    if (Property == "Size") then
                        TextLabel.TextSize = Value
                        TextProperties.Size = Value
                    end
                    if (Property == "Color") then
                        TextLabel.TextColor3 = Value
                        TextProperties.Color = Value
                    end
                    if (Property == "XAlign") then
                        TextLabel.TextXAlignment = Enum.TextXAlignment[Value]
                        TextProperties.XAlign = Enum.TextXAlignment[Value]
                    end
                    if (Property == "YAlign") then
                        TextLabel.TextYAlignment = Enum.TextXYlignment[Value]
                        TextProperties.YAlign = Enum.TextXYlignment[Value]
                    end
                    if (Property == "Visible") then
                        TextLabel.Visible = Value
                        TextProperties.Visible = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            TextLabel:Destroy();
                        end)
                    end
                    
                    return TextProperties[Property]
                end)
            })
        end
        if (Type == "Line") then
            local LineProperties = ({
                To = Vector2new(),
                From = Vector2new(),
                Thickness = 1,
                Fade = {Enabled=false,Rotation=0,Color=Color3.new()},
            } + BaseDrawingProperties)

            local LineFrame = Instancenew("Frame");
            LineFrame.AnchorPoint = Vector2new(0.5, 0.5);
            LineFrame.BorderSizePixel = 0
            LineFrame.BackgroundColor3 = LineProperties.Color
            LineFrame.Visible = LineProperties.Visible
            LineFrame.BackgroundTransparency = LineProperties.Transparency
            LineFrame.Parent = UI
            
            local UIFade = Instance.new("UIGradient",LineFrame)

            UIFade.Rotation = LineProperties.Rotation
            UIFade.Enabled = LineProperties.Fade.Enabled

            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Fade") then
                        
                        if typeof(Value[1]) ~= typeof(Color3.new()) then 
                            warn("attempt set color to "..typeof(Value[1]).." value!")
                        else
                            LineProperties.Fade.Color = Value[1]
                        end
                        if Value[2] then
                            LineProperties.Fade.Rotation = Value[2]
                        end
                        if Value[3] then
                            LineProperties.Fade.Enabled = Value[3]
                        end
                    end
                    if (Property == "Color") then
                        LineFrame.BackgroundColor3 = Value
                        LineProperties.Color = Value
                    end
                    if (Property == "Visible") then
                        LineFrame.Visible = Value
                        LineProperties.Visible = Value
                    end
                    if (Property == "Thickness") then
                        --TODO
                        LineProperties.Thickness = Value
                    end
                    if (Property == "Transparency") then
                        LineFrame.BackgroundTransparency = Value
                        LineProperties.Transparency = Value
                    end

                    if (Property == "To") then
                        local To = Value
                        local Direction = (To - LineProperties.From);
                        local Center = (To + LineProperties.From) / 2
                        local Distance = Direction.Magnitude
                        local Theta = math.atan2(Direction.Y, Direction.X);

                        LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y);
                        LineFrame.Rotation = math.deg(Theta);
                        LineFrame.Size = UDim2.fromOffset(Distance, LineProperties.Thickness);

                        LineProperties.To = To
                    end
                    if (Property == "From") then
                        local From = Value
                        local Direction = (LineProperties.To - From);
                        local Center = (LineProperties.To + From) / 2
                        local Distance = Direction.Magnitude
                        local Theta = math.atan2(Direction.Y, Direction.X);

                        LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y);
                        LineFrame.Rotation = math.deg(Theta);
                        LineProperties.From = From
                    end
                    if (Property == "Visible") then
                        LineFrame.Visible = Value
                        LineProperties.Visible = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            LineFrame:Destroy();
                        end)
                    end
                    
                    return LineProperties[Property]
                end)
            })
        end

        if (Type == "Square") then
            local SquareProperties = ({
                Thickness = 1,
                Size = Vector2new(),
                Position = Vector2new(),
                Filled = false,
                XAlign = "Left",
                YAlign = "Top",
                Fade = {Enabled=false,Rotation=0,Color=Color3.new()},
            } + BaseDrawingProperties);

            local SquareFrame = Instance.new("Frame");
            SquareFrame.AnchorPoint = Vector2new(0, 0);
            SquareFrame.BorderSizePixel = 0
            SquareFrame.Visible = false
            SquareFrame.Parent = UI
            local UIFade = Instance.new("UIGradient",SquareFrame)
            UIFade.Rotation = SquareProperties.Rotation
            UIFade.Enabled = SquareProperties.Fade.Enabled
            local UIOutline = Instance.new("UIStroke")
            UIOutline.Thickness = SquareProperties.Thickness
            UIOutline.Enabled = false
            UIOutline.Parent = SquareFrame
            local UIFade2 = UIFade:Clone()
            UIFade2.Parent = UIOutline
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Fade") then
                        print(Value[1],Value[2],Value[3])
                        if typeof(Value[1]) ~= typeof(Color3.new()) then 
                            warn("attempt set color to "..typeof(Value[1]).." value!")
                        else
                            SquareProperties.Fade.Color = Value[1]
                        end
                        if Value[2] then
                            SquareProperties.Fade.Rotation = Value[2]
                        end
                        if Value[3] then
                            SquareProperties.Fade.Enabled = Value[3]
                        end
                    end
                    if (Property == "Size") then
                        SquareFrame.Size = UDim2new(0, Value.X, 0, Value.Y);
                        SquareProperties.Size = Value
                    end
                    if (Property == "Position") then
                        SquareFrame.Position = UDim2new(0, Value.X, 0, Value.Y);
                        SquareProperties.Position = Value
                    end
                    if (Property == "Color") then
                        SquareFrame.BackgroundColor3 = Value
                        UIOutline.Color = Value
                        SquareProperties.Color = Value
                    end
                    if (Property == "Transparency") then
                        if SquareProperties.Filled == true then
                            SquareFrame.BackgroundTransparency = Value
                        else
                            UIOutline.Transparency = Value
                        end
                        SquareProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        if Value == true then
                            SquareFrame.Visible = true
                            if SquareProperties.Filled == true then
                                SquareFrame.BackgroundTransparency = SquareProperties.Transparency
                                UIOutline.Enabled = false
                            else
                                SquareFrame.BackgroundTransparency = 1
                                UIOutline.Enabled = true
                            end
                        else
                            SquareFrame.Visible = false
                            UIOutline.Enabled = false
                        end
                        SquareProperties.Visible = Value
                    end
                    if (Property == "Filled") then -- idi naxyi
                        if SquareProperties.Visible == true then
                            if Value == false then
                                SquareFrame.BackgroundTransparency = 1
                            else
                                SquareFrame.BackgroundTransparency = SquareProperties.Transparency
                            end
                            UIOutline.Enabled = not Value
                        end
                        SquareProperties.Filled = Value
                    end
                    if (Property == "XAlign") then
                        if Value == "Left" then
                            SquareFrame.AnchorPoint = Vector2new(0,SquareFrame.AnchorPoint.Y)
                        elseif Value == "Center" then
                            SquareFrame.AnchorPoint = Vector2new(0.5,SquareFrame.AnchorPoint.Y)
                        elseif Value == "Right" then
                            SquareFrame.AnchorPoint = Vector2new(-1,SquareFrame.AnchorPoint.Y)
                        end
                        SquareProperties.XAlign = Value
                    end
                    if (Property == "YAlign") then
                        if Value == "Top" then
                            SquareFrame.AnchorPoint = Vector2new(SquareFrame.AnchorPoint.X, 0)
                        elseif Value == "Center" then
                            SquareFrame.AnchorPoint = Vector2new(SquareFrame.AnchorPoint.X, 0.5)
                        elseif Value == "Bottom" then
                            SquareFrame.AnchorPoint = Vector2new(SquareFrame.AnchorPoint.X, -1)
                        end
                        SquareProperties.YAlign = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            SquareFrame:Destroy();
                        end)
                    end
                    
                    return SquareProperties[Property]
                end)
            })
        end

        if (Type == "Image") then
            local ImageProperties = ({
                Data = "rbxassetid://848623155",
                Size = Vector2new(),
                Position = Vector2new(),
                Rounding = 0,
            });

            local ImageLabel = Instancenew("ImageLabel");

            ImageLabel.AnchorPoint = Vector2new(0.5, 0.5);
            ImageLabel.BorderSizePixel = 0
            ImageLabel.ScaleType = Enum.ScaleType.Stretch
            ImageLabel.Transparency = 1
            
            ImageLabel.Visible = false
            ImageLabel.Parent = UI

            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Position") then
                        ImageLabel.Position = UDim2new(0, Value.X, 0, Value.Y);
                        ImageProperties.Position = Value
                    end
                    if (Property == "Size") then
                        ImageLabel.Size = UDim2new(0, Value.X, 0, Value.Y);
                        ImageProperties.Size = Value
                    end
                    if (Property == "Transparency") then
                        ImageLabel.ImageTransparency = Value
                        ImageProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        ImageLabel.Visible = Value
                        ImageProperties.Visible = Value
                    end
                    if (Property == "Color") then
                        ImageLabel.ImageColor3 = Value
                        ImageLabel.Color = Value
                    end
                    if (Property == "Data") then
                        ImageLabel.Image = Value
                        ImageProperties.Data = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            ImageLabel:Destroy();
                        end)
                    end
                    
                    return ImageLabel[Property]
                end)
            })
        end

        if (Type == "Circle") then -- will add later
            local CircleProperties = ({
                Radius = 50,
                Thickness = 1,
                Position = Vector2new(),
                Filled = false,
                XAlign = "Center",
                YAlign = "Center",
            } + BaseDrawingProperties);

            local CircleFrame = Instancenew("Frame");
            CircleFrame.AnchorPoint = Vector2new(0.5, 0.5);
            CircleFrame.BorderSizePixel = 0
            CircleFrame.Visible = false
            CircleFrame.Parent = UI
            CircleFrame.Size = UDim2new(0, 100, 0, 100);
            local UIOutline = Instancenew("UIStroke")
            UIOutline.Thickness = CircleProperties.Thickness
            UIOutline.Enabled = false
            UIOutline.Parent = CircleFrame
            local UICorner = Instancenew("UICorner")
            UICorner.CornerRadius = UDim.new(1,0)
            UICorner.Parent = CircleFrame
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Radius") then
                        CircleFrame.Size = UDim2new(0, Value, 0, Value);
                        CircleProperties.Radius = Value
                    end
                    if (Property == "Thickness") then
                        UIOutline.Thickness = Value
                        CircleProperties.Thickness = Value
                    end
                    if (Property == "XAlign") then
                        if Value == "Left" then
                            CircleFrame.AnchorPoint = Vector2new(0,CircleFrame.AnchorPoint.Y)
                        elseif Value == "Center" then
                            CircleFrame.AnchorPoint = Vector2new(0.5,CircleFrame.AnchorPoint.Y)
                        elseif Value == "Right" then
                            CircleFrame.AnchorPoint = Vector2new(-1,CircleFrame.AnchorPoint.Y)
                        end
                        CircleProperties.XAlign = Value
                    end
                    if (Property == "YAlign") then
                        if Value == "Top" then
                            CircleFrame.AnchorPoint = Vector2new(CircleFrame.AnchorPoint.X, 0)
                        elseif Value == "Center" then
                            CircleFrame.AnchorPoint = Vector2new(CircleFrame.AnchorPoint.X, 0.5)
                        elseif Value == "Bottom" then
                            CircleFrame.AnchorPoint = Vector2new(CircleFrame.AnchorPoint.X, -1)
                        end
                        CircleProperties.YAlign = Value
                    end
                    if (Property == "Position") then
                        local x = Value.X
                        local y = Value.Y
                        CircleFrame.Position = UDim2new(0, x, 0, y);
                        CircleProperties.Position = Value
                    end
                    if (Property == "Color") then
                        CircleFrame.BackgroundColor3 = Value
                        UIOutline.Color = Value
                        CircleProperties.Color = Value
                    end
                    if (Property == "Transparency") then
                        if CircleProperties.Filled == true then
                            CircleFrame.BackgroundTransparency = Value
                        else
                            UIOutline.Transparency = Value
                        end
                        CircleProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        if Value == true then
                            CircleFrame.Visible = true
                            if CircleProperties.Filled == true then
                                CircleFrame.BackgroundTransparency = CircleProperties.Transparency
                                UIOutline.Enabled = false
                            else
                                CircleFrame.BackgroundTransparency = 1
                                UIOutline.Enabled = true
                            end
                        else
                            CircleFrame.Visible = false
                            UIOutline.Enabled = false
                        end
                        CircleProperties.Visible = Value
                    end
                    if (Property == "Filled") then -- idi naxyi
                        if CircleProperties.Visible == true then
                            if Value == false then
                                CircleFrame.BackgroundTransparency = 1
                            else
                                CircleFrame.BackgroundTransparency = CircleProperties.Transparency
                            end
                            UIOutline.Enabled = not Value
                        end
                        CircleProperties.Filled = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            CircleFrame:Destroy();
                        end)
                    end
                    
                    return CircleProperties[Property]
                end)
            });
        end

        if (Type == "Quad") then -- will add later
            return setmetatable({}, {
                
            });
        end

    end
end
do
    Colorize.RGB = {}
    function Colorize.RGB:Darkness(color, factor)
        color.R = math.clamp(color.R * factor,0,255)
        color.G = math.clamp(color.G * factor,0,255)
        color.B = math.clamp(color.B * factor,0,255)
        return color
    end
end
gui["pages"] = {}
if guiPlacing.Name == "CoreGui" then
    gui.objs["NotifyCore"] = guiPlacing:WaitForChild("RobloxGui")
else
    gui.objs["NotifyCore"] = Instance.new("ScreenGui", guiPlacing)
end
gui.objs["NotifyCore"].ResetOnSpawn = false

gui.objs["Notify"] = Instance.new("Frame", gui.objs["NotifyCore"])
gui.objs["Notify"].BorderSizePixel = 1
gui.objs["Notify"].BorderColor3 = Color3.new(0,0,0)
gui.objs["Notify"].Position = UDim2.new(0, 50, 0, game:GetService("Workspace").CurrentCamera.ViewportSize.y - 150)
gui.objs["Notify"].Size = UDim2.new(0, 220, 0, 100)
gui.objs["Notify"].BackgroundColor3 = Color3.fromRGB(50,50,50)
gui.objs["Notify"].Visible = false

gui.objs["NotifyUp"] = Instance.new("Frame", gui.objs["Notify"])
gui.objs["NotifyUp"].Name = "Bar"
gui.objs["NotifyUp"].BorderSizePixel = 0
gui.objs["NotifyUp"].Size = UDim2.new(0, 220, 0, 10)
gui.objs["NotifyUp"].Position = UDim2.fromOffset(0, 0)
gui.objs["NotifyUp"].BackgroundColor3 = Color3.fromRGB(68,68,68)

gui.objs["NotifyTitle"] = Instance.new("TextLabel", gui.objs["NotifyUp"])
gui.objs["NotifyTitle"].Name = "Title"
gui.objs["NotifyTitle"].BackgroundTransparency = 1
gui.objs["NotifyTitle"].TextSize = 7
gui.objs["NotifyTitle"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["NotifyTitle"].Text = "Title"
gui.objs["NotifyTitle"].Size = UDim2.new(0, 220, 0, 10)

gui.objs["NotifyText"] = Instance.new("TextLabel", gui.objs["NotifyUp"])
gui.objs["NotifyText"].Name = "Text"
gui.objs["NotifyText"].BackgroundTransparency = 1
gui.objs["NotifyText"].TextSize = 10
gui.objs["NotifyText"].Text = "Text"
gui.objs["NotifyText"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["NotifyText"].Size = UDim2.new(0, 220, 0, 90)
gui.objs["NotifyText"].Position = UDim2.fromOffset(0, 10)

local notifyQueue = {}
local notifyCount = 0

function gui:Notify(Title,Text,time)
    notifyCount = notifyCount + 1
    gui.objs["NotifyTitle"].Text = Title or ""
    gui.objs["NotifyText"].Text = Text or ""
    gui.objs["Notify"].Visible = true
    spawn(function()
        wait(time or 3.5)
        gui.objs["Notify"].Visible = false
    end)
    --return true
end

--[[gui.objs["Gui"].Name = randomString(math.random(5,13))
game:GetService("RunService").RenderStepped:Connect(function()
    gui.objs["Gui"].Name = randomString(math.random(5,20))
end)]]

function gui:Modal(title, button1, button2)
    local selection = false
    local startup = {}
    startup["Frame"] = Instance.new("Frame")
    startup["Frame"].Parent = gui.objs["Gui"]
    startup["Frame"].BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    startup["Frame"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Frame"].BorderSizePixel = 0
    startup["Frame"].Size = UDim2.new(0, 182, 0, 58)
    startup["Frame"].Position = UDim2.fromOffset(gui.objs["Gui"].AbsoluteSize.X/2-startup["Frame"].AbsoluteSize.X/2, gui.objs["Gui"].AbsoluteSize.Y/2-startup["Frame"].AbsoluteSize.Y/2)
    startup["UIStroke"] = Instance.new("UIStroke")
    startup["UIStroke"].Color = Color3.new(1,1,1)
    startup["UIStroke"].Thickness = 1
    startup["UIStroke"].Parent = startup["Frame"]
    startup["Title"] = Instance.new("TextLabel")
    startup["Title"].Name = "Title"
    startup["Title"].Parent = startup["Frame"]
    startup["Title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    startup["Title"].BackgroundTransparency = 1.000
    startup["Title"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Title"].BorderSizePixel = 0
    startup["Title"].Size = UDim2.new(0, 181, 0, 15)
    startup["Title"].Font = Enum.Font.SourceSans
    startup["Title"].Text = " "..title
    startup["Title"].TextColor3 = Color3.fromRGB(255, 255, 255)
    startup["Title"].TextSize = 14.000
    startup["Title"].TextXAlignment = Enum.TextXAlignment.Left
    startup["UIGradient"] = Instance.new("UIGradient")
    startup["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(184, 184, 184))}
    startup["UIGradient"].Rotation = -90
    startup["UIGradient"].Parent = startup["Title"]
    startup["UIGradient_2"] = Instance.new("UIGradient")
    startup["UIGradient_2"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(186, 186, 186))}
    startup["UIGradient_2"].Rotation = 52
    startup["UIGradient_2"].Parent = startup["Frame"]
    startup["UIGradient_21"] = Instance.new("UIGradient")
    startup["UIGradient_21"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
    startup["UIGradient_21"].Rotation = 70
    startup["UIGradient_21"].Parent = startup["UIStroke"]
    startup["Frame_2"] = Instance.new("Frame")
    startup["Frame_2"].Parent = startup["Frame"]
    startup["Frame_2"].BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    startup["Frame_2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Frame_2"].Position = UDim2.new(0, 10, 0, 23)
    startup["Frame_2"].Size = UDim2.new(0, 77, 0, 24)
    startup["UIGradient_3"] = Instance.new("UIGradient")
    startup["UIGradient_3"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(213, 213, 213))}
    startup["UIGradient_3"].Rotation = -125
    startup["UIGradient_3"].Parent = startup["Frame_2"]
    startup["TextLabel"] = Instance.new("TextLabel")
    startup["TextLabel"].Parent = startup["Frame_2"]
    startup["TextLabel"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel"].BackgroundTransparency = 1.000
    startup["TextLabel"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["TextLabel"].BorderSizePixel = 0
    startup["TextLabel"].Size = UDim2.new(0, 77, 0, 24)
    startup["TextLabel"].Font = Enum.Font.SourceSans
    startup["TextLabel"].Text = button1
    startup["TextLabel"].TextColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel"].TextSize = 14.000
    startup["UIGradient_4"] = Instance.new("UIGradient")
    startup["UIGradient_4"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(253, 253, 253)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 102, 102))}
    startup["UIGradient_4"].Rotation = -125
    startup["UIGradient_4"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.63, 0.36), NumberSequenceKeypoint.new(1.00, 0.00)}
    startup["UIGradient_4"].Parent = startup["TextLabel"]
    startup["Frame_3"] = Instance.new("Frame")
    startup["Frame_3"].Parent = startup["Frame"]
    startup["Frame_3"].BackgroundColor3 = Color3.fromRGB(68, 68, 68)
    startup["Frame_3"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["Frame_3"].Position = UDim2.new(0, 96, 0, 23)
    startup["Frame_3"].Size = UDim2.new(0, 77, 0, 24)
    startup["UIGradient_5"] = Instance.new("UIGradient")
    startup["UIGradient_5"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(213, 213, 213))}
    startup["UIGradient_5"].Rotation = -125
    startup["UIGradient_5"].Parent = startup["Frame_3"]
    startup["TextLabel_2"] = Instance.new("TextLabel")
    startup["TextLabel_2"].Parent = startup["Frame_3"]
    startup["TextLabel_2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel_2"].BackgroundTransparency = 1.000
    startup["TextLabel_2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
    startup["TextLabel_2"].BorderSizePixel = 0
    startup["TextLabel_2"].Size = UDim2.new(0, 77, 0, 24)
    startup["TextLabel_2"].Font = Enum.Font.SourceSans
    startup["TextLabel_2"].Text = button2
    startup["TextLabel_2"].TextColor3 = Color3.fromRGB(255, 255, 255)
    startup["TextLabel_2"].TextSize = 14.000
    startup["UIGradient_6"] = Instance.new("UIGradient")
    startup["UIGradient_6"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.24, Color3.fromRGB(253, 253, 253)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(102, 102, 102))}
    startup["UIGradient_6"].Rotation = -125
    startup["UIGradient_6"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.63, 0.36), NumberSequenceKeypoint.new(1.00, 0.00)}
    startup["UIGradient_6"].Parent = startup["TextLabel_2"]

    local methodSelected = false

    local c1 = startup["Frame_2"].InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            methodSelected = true
        end
    end)

    local c2 = startup["Frame_3"].InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            selection = true
            methodSelected = true
        end
    end)

    repeat
        wait(0.05)
    until methodSelected
    
    
    c1:Disconnect()
    c2:Disconnect()
    startup["Frame"]:Destroy()

    return selection
end

if gui:Modal("Select startup method", "Default", "Secure") then
    _G.SecureMethod = "FullSecurity" 
end

--gui:Modal("Select startup method", "Default", "Secure")

gui.objs["Gui"].Enabled = false

gui:Notify("Info","Loading",1)

if _G.SecureMethod ~= "FullSecurity" then
    local VPFrame = Instance.new("ViewportFrame", gui.objs["Gui"])
    --VPFrame.Name = randomString(math.random(5,13))
    VPFrame.Size = UDim2.fromScale(1,1)
    VPFrame.CurrentCamera = game:GetService("Workspace").CurrentCamera or game:GetService("Workspace").Camera
    VPFrame.BackgroundTransparency = 1
end

gui.objs["AntiMissclick"] = Instance.new("TextButton", gui.objs["Gui"])
gui.objs["AntiMissclick"].Name = "Frame"
gui.objs["AntiMissclick"].Size = UDim2.new(0, 350, 0, 200)
gui.objs["AntiMissclick"].Position = UDim2.new(0, 250, 0, 250)
gui.objs["AntiMissclick"].BackgroundTransparency = 1
gui.objs["AntiMissclick"].Text = ""

gui.objs["MainFrame"] = Instance.new("Frame", gui.objs["AntiMissclick"])
gui.objs["MainFrame"].Name = "Frame"
--gui.objs["MainFrame"].BorderSizePixel = 1
--gui.objs["MainFrame"].BorderColor3 = Color3.new(0,0,0)
gui.objs["MainFrame"].Size = UDim2.new(0, 350, 0, 200)
gui.objs["MainFrame"].Position = UDim2.new(0, 250, 0, 250)
gui.objs["MainFrame"].BackgroundTransparency = 0
gui.objs["MainFrame"].BackgroundColor3 = Color3.fromRGB(100,100,100)

gui.objs["MenuOutline"] = Instance.new("UIStroke", gui.objs["MainFrame"])
gui.objs["MenuOutline"].Thickness = 1.5
gui.objs["MenuOutline"].Color = Color3.fromRGB(255,255,255)

gui.objs["MenuOutlineGradient"] = Instance.new("UIGradient", gui.objs["MenuOutline"])
gui.objs["MenuOutlineGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)) ,ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))}
gui.objs["MenuOutlineGradient"].Rotation = 180

gui.objs["PageFrame"] = Instance.new("Frame", gui.objs["MainFrame"])
gui.objs["PageFrame"].BorderSizePixel = 0
gui.objs["PageFrame"].Size = UDim2.new(0, 70, 0, 200)
gui.objs["PageFrame"].Position = UDim2.new(0, 0, 0, 0)
gui.objs["PageFrame"].BackgroundColor3 = Color3.fromRGB(68,68,68)

gui.objs["FunctionFrame"] = Instance.new("Frame", gui.objs["MainFrame"])
gui.objs["FunctionFrame"].BorderSizePixel = 0
gui.objs["FunctionFrame"].Position = UDim2.new(0, 70, 0, 0)
gui.objs["FunctionFrame"].Size = UDim2.new(0, 280, 0, 200)
gui.objs["FunctionFrame"].BackgroundColor3 = Color3.fromRGB(50,50,50)

gui.objs["ListSwitcher+"] = Instance.new("TextLabel", gui.objs["FunctionFrame"])
gui.objs["ListSwitcher+"].Size = UDim2.fromOffset(15,15)
gui.objs["ListSwitcher+"].Position = UDim2.fromOffset(256,178)
gui.objs["ListSwitcher+"].BackgroundColor3 = Color3.fromRGB(80,80,80)
gui.objs["ListSwitcher+"].Text = ">"
gui.objs["ListSwitcher+"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["ListSwitcher+"].BorderSizePixel = 0

gui.objs["ListSwitcherNum"] = Instance.new("TextLabel", gui.objs["ListSwitcher+"])
gui.objs["ListSwitcherNum"].Size = UDim2.fromOffset(15,15)
gui.objs["ListSwitcherNum"].Position = UDim2.fromOffset(-15,0)
gui.objs["ListSwitcherNum"].BackgroundTransparency = 1
gui.objs["ListSwitcherNum"].Text = "1"
gui.objs["ListSwitcherNum"].TextColor3 = Color3.fromRGB(255,255,255)

gui.objs["ListSwitcher-"] = Instance.new("TextLabel", gui.objs["ListSwitcher+"])
gui.objs["ListSwitcher-"].Size = UDim2.fromOffset(15,15)
gui.objs["ListSwitcher-"].Position = UDim2.fromOffset(-30,0)
gui.objs["ListSwitcher-"].BackgroundColor3 = Color3.fromRGB(80,80,80)
gui.objs["ListSwitcher-"].Text = "<"
gui.objs["ListSwitcher-"].TextColor3 = Color3.fromRGB(255,255,255)
gui.objs["ListSwitcher-"].BorderSizePixel = 0

gui.objs["ListSwitcher+"].InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        if gui.page[1] ~= nil then
            if gui["pages"][gui.page[1]]["Count"] ~= nil then
                local max = tonumber(gui["pages"][gui.page[1]]["Count"])
                local current = tonumber(gui.objs["ListSwitcherNum"].Text)
                if current < max then
                    current = current + 1
                    gui.objs["ListSwitcherNum"].Text = tostring(current)
                    gui.page[2] = current
                end
            end
        end
    end
end)

gui.objs["ListSwitcher-"].InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        if gui.page[1] ~= nil then
            if gui["pages"][gui.page[1]]["Count"] ~= nil then
                local max = tonumber(gui["pages"][gui.page[1]]["Count"])
                local current = tonumber(gui.objs["ListSwitcherNum"].Text)
                if current-1 > 0 then
                    current = current - 1
                    gui.objs["ListSwitcherNum"].Text = tostring(current)
                    gui.page[2] = current
                end
            end
        end
    end
end)

local ActiveFunctions = {
    Enabled = false,
}
ActiveFunctions["active"] = {}
ActiveFunctions["list"] = {}
function ActiveFunctions:Create(Name,Text)
    Text = Text or Name
    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Text = Text
    local Frame_2 = Instance.new("Frame")
    local UIGradient = Instance.new("UIGradient")
    Frame.Parent = gui.objs["Gui"]
    Frame.AnchorPoint = Vector2.new(1, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(1, 0, 0, 0)
    Frame.Size = UDim2.new(0, 48, 0, 26)
    Frame.Visible = false
    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Size = UDim2.new(1, 0, 0.9, 0)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 26.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    Frame_2.Parent = Frame
    Frame_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.BorderSizePixel = 0
    Frame_2.Position = UDim2.new(0, 0, 0.9, 0)
    Frame_2.Size = UDim2.new(1, 0, 0.1, 0)
    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(143, 143, 143))}
    UIGradient.Parent = Frame
    Frame.Size = UDim2.fromOffset(TextLabel.TextBounds.X,26)

    ActiveFunctions.list[Name] = {}
    ActiveFunctions.list[Name].ui = Frame
    ActiveFunctions.list[Name].size = TextLabel.TextBounds.X
    ActiveFunctions.list[Name].Enabled = false
end

spawn(function()
    gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
        local actives = {}
        for name, fn in pairs(ActiveFunctions.list) do
            if fn.Enabled == true and ActiveFunctions.Enabled then
                local ptr = #actives
                actives[ptr+1] = name
            else
                fn.ui.Visible = false
            end
        end
        
        local sorted = true
        while sorted do
            sorted = false
            for i = 2, #actives do
                if ActiveFunctions.list[actives[i]].size > ActiveFunctions.list[actives[i-1]].size then
                    sorted = true
                    local old = actives[i-1]
                    actives[i-1] = actives[i]
                    actives[i] = old
                end
            end
        end
        
        for num, name in pairs(actives) do
            ActiveFunctions.list[name].ui.Position = UDim2.new(1,0,0,(num-1)*26)
            ActiveFunctions.list[name].ui.Visible = true
        end
    end)
end)

function gui:ToggleListSwithcer(state)
    if typeof(state) == "boolean" then
        gui.objs["ListSwitcher+"].Visible = state
        return true
    else
        error("Cannot toggle list switcher, state is not bool")
        return false
    end
end

function gui:Page(Name)
    local obj = Instance.new("TextLabel", gui.objs["PageFrame"])
    gui["pages"][Name] = {}
    gui["pages"][Name]["Enabled"] = false
    gui["pages"][Name]["Functions"] = {}
    gui["pages"][Name]["Spots"] = {}
    gui["pages"][Name]["Exec"] = function()end
    gui["pages"][Name]["Count"] = 0
    --obj.Name = Name
    obj.Size = UDim2.fromOffset(70, 20)
    local pages = -1
    for _,_ in pairs(gui["pages"]) do
        pages = pages + 1
    end
    obj.Position = UDim2.fromOffset(0,20*pages)
    obj.Text = Name
    obj.BackgroundColor3 = Color3.fromRGB(68,68,68)
    obj.BorderSizePixel = 0
    obj.TextColor3 = Color3.fromRGB(150,150,150)
    obj.InputBegan:Connect(function(input)
	    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            gui.objs["ListSwitcherNum"].Text = "1"
            gui.page[2] = 1
            
            if gui.page[1] == Name then
                gui.page[1] = nil
            else
                gui.page[1] = Name
            end
            if typeof(gui["pages"][Name]["Exec"]) == "function" then
                pcall(gui["pages"][Name]["Exec"])
            else warn("call error") end
        end
    end)
    spawn(function()
        gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
            --obj.Name = randomString(math.random(5,13))
            if gui.page == Name then
                obj.TextColor3 = Color3.fromRGB(255,255,255)
                gui["pages"][Name]["Enabled"] = true
            else
                obj.TextColor3 = Color3.fromRGB(150,150,150)
                gui["pages"][Name]["Enabled"] = false
            end
        end)
    end)
end

function gui:Input(Page, Name, Text, NumberInList, Dependence)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        --obj.Name = randomString(math.random(5,13))
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "Input"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Text"] = Text or ""

        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,60,0,15)
        obj.BorderSizePixel = 2
        obj.BackgroundColor3 = Color3.fromRGB(50,50,50)
        obj.BorderMode = Enum.BorderMode.Inset
        obj.BorderColor3 = Color3.fromRGB(100,100,100)
        local text = Instance.new("TextBox", obj)
        text.Size = UDim2.fromOffset(60,15)
        text.Position = UDim2.fromOffset(-2,-2)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Center
        text.TextSize = 8
        text.Text = gui["pages"][Page]["Functions"][NumberInList][Name]["Text"]
        text.TextColor3 = Color3.new(1,1,1)
        text.TextScaled = true
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                gui["pages"][Page]["Functions"][NumberInList][Name]["Text"] = text.Text
            end)
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                --obj.Name = randomString(math.random(5,13))
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    if Dependence ~= nil then
                        local isEnabled = gui:GetDropItem(Dependence[1], Dependence[2])
                        if isEnabled == Dependence[3] then
                            obj.Visible = true
                        else
                            obj.Visible = false
                        end
                    else
                        obj.Visible = true
                    end
                else
                    obj.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:Button(Page, Name, Executable, NumberInList, Dependence)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        --obj.Name = randomString(math.random(5,13))
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "Button"
		if Executable ~= nil then
			if type(Executable) == "function" then
				gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"] = Executable
			else	
				gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"] = function()end
			end
		end
        
        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,60,0,15)
        obj.BorderSizePixel = 0
        obj.BackgroundColor3 = Color3.fromRGB(100,100,100)
        local text = Instance.new("TextLabel", obj)
        text.Size = UDim2.fromOffset(60,15)
        text.Position = UDim2.fromOffset(0,0)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Center
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                pcall(gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"])
            end
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                obj.Name = randomString(math.random(5,13))
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    if Dependence ~= nil then
                        local isEnabled = gui:GetDropItem(Dependence[1], Dependence[2])
                        if isEnabled == Dependence[3] then
                            obj.Visible = true
                        else
                            obj.Visible = false
                        end
                    else
                        obj.Visible = true
                    end
                else
                    obj.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:CheckBox(Page, Name, NumberInList, ManualActivate, AddFBar, FBarText)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        if ManualActivate == nil then
            ManualActivate = false
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "CheckBox"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] = ManualActivate
        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,15,0,15)
        obj.BorderSizePixel = 0
        obj.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
        local check = Instance.new("Frame", obj)
        check.Size = UDim2.fromOffset(11,11)
        check.BorderSizePixel = 0
        check.Position = UDim2.fromOffset(2,2)
        check.Visible = false
        check.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        local text = Instance.new("TextLabel", obj)
        text.Size = UDim2.fromOffset(75,15)
        text.Position = UDim2.fromOffset(20,0)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"]
                check.Visible = gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] 
            end
        end)
        if AddFBar then
            ActiveFunctions:Create(FBarText or Name)
        end
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                if AddFBar then
                    ActiveFunctions.list[FBarText or Name].Enabled = gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"]
                end
                --obj.Name = randomString(math.random(5,13))
                check.Visible = gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] 
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    obj.Visible = true
                else
                    obj.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:Slider(Page, Name, Max, NumberInList, Dependence)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "Slider"
        gui["pages"][Page]["Functions"][NumberInList][Name]["State"] = 0

        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,100,0,15)
        obj.BorderSizePixel = 0
        obj.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        local check = Instance.new("Frame", obj)
        check.Size = UDim2.fromOffset(0,15)
        check.BorderSizePixel = 0
        check.Position = UDim2.fromOffset(0,0)
        check.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        local text = Instance.new("TextLabel", obj)
        text.Size = UDim2.fromOffset(obj.AbsoluteSize.X,15)
        text.Position = UDim2.fromOffset(obj.AbsoluteSize.X+5,0)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        local num = Instance.new("TextLabel", obj)
        num.Size = UDim2.fromOffset(0,15)
        num.Position = UDim2.fromOffset(0,0)
        num.BackgroundTransparency = 1
        num.TextSize = 8
        num.TextXAlignment = Enum.TextXAlignment.Right
        num.Text = "0"
        text.TextColor3 = Color3.new(1,1,1)
        local state = {
            current = 0,
            max     = Max,
            enabled = false,
        }
        local holding = false
        spawn(function()
            local time = 0
            if _G.OptimizeMenu == true then time = 0.09 end
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    if Dependence ~= nil then
                        local isEnabled = gui:GetDropItem(Dependence[1], Dependence[2])
                        if isEnabled == Dependence[3] then
                            obj.Visible = true
                        else
                            obj.Visible = false
                        end
                    else
                        obj.Visible = true
                    end
                else
                    obj.Visible = false
                end
            end)
        end)
        
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
                holding = true
            end
        end)
        obj.InputEnded:Connect(function()
            holding = false
        end)
        local firstDel = true
        gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
            --obj.Name = randomString(math.random(5,13))
            if num.Size ~= UDim2.fromOffset(check.AbsoluteSize.X,15) then
                num.Size = UDim2.fromOffset(check.AbsoluteSize.X,15)
            end
            if check.Size.X.Scale <= 0.05 then
                num.TextXAlignment = Enum.TextXAlignment.Left
            elseif num.TextXAlignment == Enum.TextXAlignment.Left then
                num.TextXAlignment = Enum.TextXAlignment.Right
            end
            if holding then
                local pos = math.clamp(mouse.X, obj.AbsolutePosition.X, obj.AbsolutePosition.X+obj.AbsoluteSize.X) - obj.AbsolutePosition.X
                local locMax = obj.AbsoluteSize.X
                local step = state.max/obj.AbsoluteSize.X
                state.current = math.floor(step*pos)
                check.Size = UDim2.new(pos/locMax,0,1,0)
                num.Text = state.current
            else
                if gui["pages"][Page]["Functions"][NumberInList][Name]["State"] ~= state.current then
                    state.current = gui["pages"][Page]["Functions"][NumberInList][Name]["State"]
                    num.Text = state.current
                    local step = state.max/obj.AbsoluteSize.X 
                    local pos = gui["pages"][Page]["Functions"][NumberInList][Name]["State"]/step
                    check.Size = UDim2.new(pos/obj.AbsoluteSize.X,0,1,0)
                end
            end
            gui["pages"][Page]["Functions"][NumberInList][Name]["State"] = state.current
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:MultiDropDown(Page, Name, Params, NumberInList)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "MultiDropDown"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Items"] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"] = Params or {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = false
        local distance = 5
        local MainBar = Instance.new("Frame", gui.objs["FunctionFrame"])
        --MainBar.Name = Name
        MainBar.Size = UDim2.fromOffset(60,15)
        MainBar.Position = UDim2.fromOffset(15,fns*15+distance*fns+13)
        MainBar.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        MainBar.BorderSizePixel = 0
        local Label = Instance.new("TextLabel", MainBar)
        Label.Text = Name
        Label.Position = UDim2.fromOffset(65,0)
        Label.Size = UDim2.fromOffset(45,15)
        Label.TextSize = 8
        Label.BackgroundTransparency = 1
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.TextColor3 = Color3.fromRGB(255,255,255)
        local BG = Instance.new("TextLabel", MainBar)
        BG.Name = Name
        BG.Size = UDim2.fromOffset(56,11)
        BG.Position = UDim2.fromOffset(2,2)
        BG.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        BG.BorderSizePixel = 0
        BG.TextXAlignment = Enum.TextXAlignment.Center
        BG.TextSize = 8
        BG.Text = ""
        BG.TextColor3 = Color3.new(1,1,1)
        local listt = {}
        local function showList(toggle)
            for _,panel in pairs(listt) do
                panel.Visible = toggle
            end
        end
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                if gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] == false then
                    for _,v in pairs(listt) do
                        v:Destroy()
                    end
                    listt = {}
                    local count = 0
                    for _i,v in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"]) do
                        count = count + 1
                        local namee = ""
                        namee = _i
                        local Panel = Instance.new("TextLabel", MainBar)
                        Panel.Name = count
                        Panel.Size = UDim2.fromOffset(60,15)
                        Panel.Position = UDim2.fromOffset(0,15+(((count-1)*15)-(1*count-1)))
                        Panel.Visible = false
                        Panel.BorderSizePixel = 1
                        Panel.BackgroundColor3 = Color3.fromRGB(100,100,100)
                        for _pos,_name in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["Items"]) do
                            if _name == namee then
                                Panel.BackgroundColor3 = Color3.fromRGB(130,130,130)
                            end
                        end
                        Panel.BorderColor3 = Color3.new(0,0,0)
                        Panel.BorderMode = Enum.BorderMode.Inset
                        Panel.Text = count..". "..namee
                        Panel.TextSize = 8
                        Panel.TextScaled = true
                        Panel.TextXAlignment = Enum.TextXAlignment.Center
                        Panel.TextColor3 = Color3.new(1,1,1)
                        Panel.ZIndex = 10
                        
                        Panel.InputBegan:Connect(function(input)
                            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                                if not gui["pages"][Page]["Functions"][NumberInList][Name]["Items"][namee] then
                                    gui["pages"][Page]["Functions"][NumberInList][Name]["Items"][namee] = {Panel.Name, v}
                                    Panel.BackgroundColor3 = Color3.fromRGB(130,130,130)
                                else
                                    gui["pages"][Page]["Functions"][NumberInList][Name]["Items"][namee] = nil
                                    Panel.BackgroundColor3 = Color3.fromRGB(100,100,100)
                                end
                            end
                        end)
                        listt[count] = Panel
                    end
                end
            end)
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                --MainBar.Name = randomString(math.random(5,13))
                local count = 0
                local txt = ""
                for name,val in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["Items"]) do
                    count = count + 1
                    txt = txt .. val[1]..", "
                end
                if count == 0 then
                    BG.Text = ""
                else
                    txt = txt:sub(1,#txt-2)
                    BG.Text = txt
                end
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    MainBar.Visible = true
                else
                    MainBar.Visible = false
                end
            end)
        end)
        MainBar.InputBegan:Connect(function(input)
            local connection = nil
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
                gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
                if gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] == true then
                    connection = game:GetService("UserInputService").InputBegan:Connect(function(i)
                        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.MouseButton2 then
                            local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                            if mouse.X < MainBar.AbsolutePosition.X and mouse.Y < MainBar.AbsolutePosition.Y and mouse.X > MainBar.AbsolutePosition.X + MainBar.AbsoluteSize.X and mouse.Y > MainBar.AbsolutePosition.Y + MainBar.AbsoluteSize.Y then
                                gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = false
                                showList(gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"])
                                print("closing")
                                connection:Disconnect()
                            end
                        end
                    end)
                end
                showList(gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"])
            end
        end)
    end
end

function gui:DropDown(Page, Name, Params, NumberInList, Default)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        if Default == nil then
            Default = ""
        end
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "DropDown"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Item"] = Default
        gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"] = Params or {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = false
        local distance = 5
        local MainBar = Instance.new("Frame", gui.objs["FunctionFrame"])
        --MainBar.Name = Name
        MainBar.Size = UDim2.fromOffset(60,15)
        MainBar.Position = UDim2.fromOffset(15,fns*15+distance*fns+13)
        MainBar.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        MainBar.BorderSizePixel = 0
        local Label = Instance.new("TextLabel", MainBar)
        Label.Text = Name
        Label.Position = UDim2.fromOffset(65,0)
        Label.Size = UDim2.fromOffset(45,15)
        Label.TextSize = 8
        Label.BackgroundTransparency = 1
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.TextColor3 = Color3.fromRGB(255,255,255)
        local BG = Instance.new("TextLabel", MainBar)
        BG.Name = Name
        BG.Size = UDim2.fromOffset(56,11)
        BG.Position = UDim2.fromOffset(2,2)
        BG.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        BG.BorderSizePixel = 0
        BG.TextXAlignment = Enum.TextXAlignment.Center
        BG.TextSize = 8
        BG.Text = ""
        BG.TextColor3 = Color3.new(1,1,1)
        local listt = {}
        local function showList(toggle)
            for _,panel in pairs(listt) do
                panel.Visible = toggle
            end
        end
        spawn(function ()
            while wait(0.1) do
                if not gui.Loaded then break end
                if gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] == false then
                    for _,v in pairs(listt) do
                        v:Destroy()
                    end
                    listt = {}
                    for _i,v in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"]) do
                        local Panel = Instance.new("TextLabel", MainBar)
                        Panel.Size = UDim2.fromOffset(60,15)
                        Panel.Position = UDim2.fromOffset(0,15+(((_i-1)*15)-(1*_i-1)))
                        Panel.Visible = false
                        Panel.BorderSizePixel = 1
                        Panel.BackgroundColor3 = Color3.fromRGB(100,100,100)
                        Panel.BorderColor3 = Color3.new(0,0,0)
                        Panel.BorderMode = Enum.BorderMode.Inset
                        Panel.Text = tostring(v)
                        Panel.TextSize = 8
                        Panel.TextScaled = true
                        Panel.TextXAlignment = Enum.TextXAlignment.Center
                        Panel.TextColor3 = Color3.new(1,1,1)
                        Panel.ZIndex = 10
                        Panel.InputBegan:Connect(function(input)
                            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
                                gui["pages"][Page]["Functions"][NumberInList][Name]["Item"] = tostring(v)
                                showList(false)
                            end
                        end)
                        listt[_i] = Panel
                    end
                end
            end
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                --MainBar.Name = randomString(math.random(5,13))
                BG.Text = gui["pages"][Page]["Functions"][NumberInList][Name]["Item"]
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    MainBar.Visible = true
                else
                    MainBar.Visible = false
                end
            end)
        end)
        MainBar.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
                gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
                showList(gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"])
            end
        end)
    end
end

function gui:Paragraph(Page, Name, NumberInList)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "Paragraph"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Text"] = Name
        local distance = 5
        local text = Instance.new("TextLabel", gui.objs["FunctionFrame"])
        --text.Name = Name
        text.Size = UDim2.fromOffset(75,15)
        text.Position = UDim2.fromOffset(15,fns*15+distance*fns+13)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                text.Text = gui["pages"][Page]["Functions"][NumberInList][Name]["Text"]
                --text.Name = randomString(math.random(5,13))
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    text.Visible = true
                else
                    text.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:PlayerSpot(Page, Name, Type, NumberInList)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        --[[
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        --]]
        if gui["pages"][Page]["Spots"][NumberInList] == nil then
            gui["pages"][Page]["Spots"][NumberInList] = {}
        end
        --[[
        for _,_ in pairs(gui["pages"][Page]["Spots"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        --]]
        if Type == nil then
            Type = "R15"
        end
        gui["pages"][Page]["Spots"][NumberInList][Name] = {}
        gui["pages"][Page]["Spots"][NumberInList][Name]["Type"] = "Spot"
        gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "Head"
        local localBone = "Head"
        local distance = 5
        local Main = Instance.new("Frame", gui.objs["FunctionFrame"])
        Main.Name = Name
        Main.Size = UDim2.fromOffset(100,170)
        Main.Position = UDim2.fromOffset(180,13)
        Main.BackgroundTransparency = 1
        local Head = Instance.new("Frame", Main)
        Head.Size = UDim2.fromOffset(26,26)
        Head.Position = UDim2.fromOffset(37,0)
        Head.BackgroundTransparency = 0
        Head.BackgroundColor3 = Color3.fromRGB(150,150,150)
        Head.BorderSizePixel = 0
        local HumanoidRootPart = Instance.new("Frame", Main)
        HumanoidRootPart.Size = UDim2.fromOffset(26,40)
        HumanoidRootPart.Position = UDim2.fromOffset(37,28)
        HumanoidRootPart.BackgroundTransparency = 0
        HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(100,100,100)
        HumanoidRootPart.BorderSizePixel = 0
        local LeftArm = Instance.new("Frame", Main)
        LeftArm.Size = UDim2.fromOffset(12,40)
        LeftArm.Position = UDim2.fromOffset(23,28)
        LeftArm.BackgroundTransparency = 0
        LeftArm.BackgroundColor3 = Color3.fromRGB(100,100,100)
        LeftArm.BorderSizePixel = 0
        local RightArm = Instance.new("Frame", Main)
        RightArm.Size = UDim2.fromOffset(12,40)
        RightArm.Position = UDim2.fromOffset(65,28)
        RightArm.BackgroundTransparency = 0
        RightArm.BackgroundColor3 = Color3.fromRGB(100,100,100)
        RightArm.BorderSizePixel = 0
        local LeftLeg = Instance.new("Frame", Main)
        LeftLeg.Size = UDim2.fromOffset(12,40)
        LeftLeg.Position = UDim2.fromOffset(37,70)
        LeftLeg.BackgroundTransparency = 0
        LeftLeg.BackgroundColor3 = Color3.fromRGB(100,100,100)
        LeftLeg.BorderSizePixel = 0
        local RightLeg = Instance.new("Frame", Main)
        RightLeg.Size = UDim2.fromOffset(12,40)
        RightLeg.Position = UDim2.fromOffset(51,70)
        RightLeg.BackgroundTransparency = 0
        RightLeg.BackgroundColor3 = Color3.fromRGB(100,100,100)
        RightLeg.BorderSizePixel = 0
        local function deSelectAll()
            Head.BackgroundColor3 = Color3.fromRGB(100,100,100)
            HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(100,100,100)
            LeftArm.BackgroundColor3 = Color3.fromRGB(100,100,100)
            RightArm.BackgroundColor3 = Color3.fromRGB(100,100,100)
            LeftLeg.BackgroundColor3 = Color3.fromRGB(100,100,100)
            RightLeg.BackgroundColor3 = Color3.fromRGB(100,100,100)
        end
        spawn(function()
            while wait(0.1) do
                if not gui.Loaded then break end
                local bone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
                if localBone ~= bone then
                    if bone == "Head" then
                        deSelectAll()
                        Head.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "HumanoidRootPart" then
                        deSelectAll()
                        HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "LeftLowerArm" or bone == "LeftArm" then
                        deSelectAll()
                        LeftArm.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "RightLowerArm" or bone == "RightArm" then
                        deSelectAll()
                        RightArm.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "LeftLowerLeg" or bone == "LeftLeg" then
                        deSelectAll()
                        LeftLeg.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    elseif bone == "RightLowerLeg" or bone == "RightLeg" then
                        deSelectAll()
                        RightLeg.BackgroundColor3 = Color3.fromRGB(150,150,150)
                    end
                end
            end
        end)
        Head.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "Head"
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            Head.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        HumanoidRootPart.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "HumanoidRootPart"
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            HumanoidRootPart.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        LeftArm.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            if Type == "R15" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "LeftLowerArm"
            elseif Type == "R6" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "LeftArm"
            end
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            LeftArm.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        RightArm.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            if Type == "R15" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "RightLowerArm"
            elseif Type == "R6" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "RightArm"
            end
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            RightArm.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        LeftLeg.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            if Type == "R15" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "LeftLowerLeg"
            elseif Type == "R6" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "LeftLeg"
            end
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            LeftLeg.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        RightLeg.InputBegan:Connect(function(input) if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            if Type == "R15" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "RightLowerLeg"
            elseif Type == "R6" then
                gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"] = "RightLeg"
            end
            localBone = gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
            deSelectAll()
            RightLeg.BackgroundColor3 = Color3.fromRGB(150,150,150)
        end end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    Main.Visible = true
                else
                    Main.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:ColorSelector(Page, Name, NumberInList, DefaultColor)
    if gui["pages"][Page] ~= nil then
        if NumberInList == nil then
            NumberInList = 1
        end
        if DefaultColor == nil then
            DefaultColor = Color3.fromRGB(0,0,0)
        end
        local obj = Instance.new("Frame", gui.objs["FunctionFrame"])
        --obj.Name = Name
        local fns = 0
        local isfns = 0
        if gui["pages"][Page]["Count"] < NumberInList then
            gui["pages"][Page]["Count"] = NumberInList
        end
        if gui["pages"][Page]["Functions"][NumberInList] == nil then
            gui["pages"][Page]["Functions"][NumberInList] = {}
        end
        for _,_ in pairs(gui["pages"][Page]["Functions"][NumberInList]) do
            fns = fns + 1
            isfns = 1
        end
        gui["pages"][Page]["Functions"][NumberInList][Name] = {}
        gui["pages"][Page]["Functions"][NumberInList][Name]["Type"] = "ColorSelector"
        gui["pages"][Page]["Functions"][NumberInList][Name]["Color"] = DefaultColor
        gui["pages"][Page]["Functions"][NumberInList][Name]["Rainbow"] = false
        gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = false
        local function rgb_to_hsv(r, g, b)
            r, g, b = (r / 255), (g / 255), (b / 255)
            local mx = math.max(r, g, b)
            local mn = math.min(r, g, b)
            local h, s
         
            if mx == mn then
                h = 0
            d = 0
            else
            local d = mx - mn
                if     mx == r then h = (g - b) / d + (g < b and 6 or 0)
                elseif mx == g then h = (b - r) / d + 2
                elseif mx == b then h = (r - g) / d + 4 end
                h = h / 6
            end
            s = (mx == 0) and 0 or (d / mx)
         
            return h, s, mx
        end
        local function hsvToRgb(h, s, v)
            local hi = math.floor(h * 6)
            local f = h * 6 - hi
            local p = v * (1 - s)
            local q = v * (1 - f * s)
            local t = v * (1 - (1 - f) * s)
            local r
            local g
            local b
            
            if hi == 0 then
                r, g, b = v, t, p
            elseif hi == 1 then
                r, g, b = q, v, p
            elseif hi == 2 then
                r, g, b = p, v, t
            elseif hi == 3 then
                r, g, b = p, q, v
            elseif hi == 4 then
                r, g, b = t, p, v
            elseif hi == 5 then
                r, g, b = v, p, q
            end
            
            local a, b = pcall(function()
                r = math.floor(r * 255)
                g = math.floor(g * 255)
                b = math.floor(b * 255)
            end)
            if not a then
                return 0,0,0
            end
        
            return r, g, b
        end

        local Hue, Saturation, Value = rgb_to_hsv(DefaultColor.R, DefaultColor.G, DefaultColor.B)
        gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"] = {H=Hue, S=Saturation, V=Value}
        local distance = 5
        obj.Position = UDim2.new(0,15,0,fns*15+distance*fns+13)
        obj.Size = UDim2.new(0,15,0,15)
        obj.BorderSizePixel = 0
        obj.BackgroundColor3 = Color3.fromRGB(0,0,0)
        local gearImage = Instance.new("ImageLabel", obj)
        gearImage.Size = UDim2.fromScale(1,1)
        gearImage.BorderSizePixel = 0
        gearImage.Position = UDim2.fromOffset(0,0)
        gearImage.Visible = true
        gearImage.BackgroundTransparency = 1
        gearImage.Image = "http://www.roblox.com/asset/?id=14562134132"
        local text = Instance.new("TextLabel", obj)
        text.Size = UDim2.fromOffset(75,15)
        text.Position = UDim2.fromOffset(20,0)
        text.BackgroundTransparency = 1
        text.TextXAlignment = Enum.TextXAlignment.Left
        text.TextSize = 8
        text.Text = Name
        text.TextColor3 = Color3.new(1,1,1)
        local HueMul = 0.71030640668523676880222841225627
        local SelectBG = Instance.new("Frame", obj)
        SelectBG.Position = UDim2.fromOffset(20,0)
        SelectBG.Size = UDim2.fromOffset(157,148)
        SelectBG.BackgroundColor3 = Color3.fromRGB(68,68,68)
        SelectBG.BorderSizePixel = 0
        SelectBG.ZIndex = 2
        SelectBG.Visible = false
        local ColorSelector = {
            Main = Instance.new("Frame", SelectBG),
            HueGradient = Instance.new("UIGradient"),
            SaturationFrame = Instance.new("Frame"),
            SaturationGradient = Instance.new("UIGradient")
        }
        ColorSelector.HueGradient.Parent = ColorSelector.Main
        ColorSelector.SaturationFrame.Parent = ColorSelector.Main
        ColorSelector.SaturationGradient.Parent = ColorSelector.SaturationFrame

        ColorSelector.Main.BackgroundColor3 = Color3.fromRGB(255,255,255)
        ColorSelector.Main.Position = UDim2.fromOffset(9,7)
        ColorSelector.Main.Size = UDim2.fromOffset(124,118)
        ColorSelector.Main.BorderSizePixel = 0
        ColorSelector.Main.ZIndex = 3

        ColorSelector.HueGradient.Color = ColorSequence.new{ 
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)), 
            ColorSequenceKeypoint.new(1/6*1, Color3.fromRGB(255,0,255)),
            ColorSequenceKeypoint.new(1/6*2, Color3.fromRGB(0,0,255)),
            ColorSequenceKeypoint.new(1/6*3, Color3.fromRGB(0,255,255)),
            ColorSequenceKeypoint.new(1/6*4, Color3.fromRGB(0,255,0)),
            ColorSequenceKeypoint.new(1/6*5, Color3.fromRGB(255,255,0)), 
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,0)),
        }

        ColorSelector.SaturationFrame.Size = UDim2.fromScale(1,1)
        ColorSelector.SaturationFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
        ColorSelector.SaturationFrame.BorderSizePixel = 0
        ColorSelector.SaturationFrame.ZIndex = 3
        ColorSelector.SaturationGradient.Rotation = -90
        ColorSelector.SaturationGradient.Transparency = NumberSequence.new{
            NumberSequenceKeypoint.new(0,0),
            NumberSequenceKeypoint.new(1,1)
        }

        local ValueSelector = {
            Main = Instance.new("Frame", SelectBG),
            Gradient = Instance.new("UIGradient")
        }
        ValueSelector.Gradient.Parent = ValueSelector.Main
        
        ValueSelector.Main.BackgroundColor3 = DefaultColor
        ValueSelector.Main.Size = UDim2.fromOffset(8,117)
        ValueSelector.Main.Position = UDim2.fromOffset(140,7)
        ValueSelector.Main.BorderSizePixel = 0
        ValueSelector.Main.ZIndex = 3

        ValueSelector.Gradient.Rotation = 90
        ValueSelector.Gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
            ColorSequenceKeypoint.new(1,Color3.new(0,0,0))
        }

        local RainbowCheck = {
            Main = Instance.new("Frame", SelectBG),
            Check = Instance.new("Frame"),
            Text = Instance.new("TextLabel")
        }
        RainbowCheck.Check.Parent = RainbowCheck.Main
        RainbowCheck.Text.Parent = RainbowCheck.Main
        
        RainbowCheck.Main.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
        RainbowCheck.Main.Position = UDim2.fromOffset(9,130)
        RainbowCheck.Main.Size = UDim2.fromOffset(12,12)
        RainbowCheck.Main.BorderSizePixel = 0
        RainbowCheck.Main.ZIndex = 3

        RainbowCheck.Check.BackgroundColor3 = Color3.fromRGB(100,100,100)
        RainbowCheck.Check.Size = UDim2.fromOffset(8,8)
        RainbowCheck.Check.Position = UDim2.fromOffset(2,2)
        RainbowCheck.Check.Visible = false
        RainbowCheck.Check.BorderSizePixel = 0
        RainbowCheck.Check.ZIndex = 3

        RainbowCheck.Text.BackgroundTransparency = 1
        RainbowCheck.Text.Position = UDim2.fromOffset(17,0)
        RainbowCheck.Text.Size = UDim2.fromOffset(1,12)
        RainbowCheck.Text.Text = "Rainbow"
        RainbowCheck.Text.TextColor3 = Color3.new(1,1,1)
        RainbowCheck.Text.TextSize = 8
        RainbowCheck.Text.TextXAlignment = Enum.TextXAlignment.Left
        RainbowCheck.Text.ZIndex = 3

        RainbowCheck.Main.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                gui["pages"][Page]["Functions"][NumberInList][Name]["Rainbow"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Rainbow"]
                RainbowCheck.Check.Visible = gui["pages"][Page]["Functions"][NumberInList][Name]["Rainbow"]
            end
        end)
        local selectingSaturation = false
        ValueSelector.Main.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                selectingSaturation = true
                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                repeat
                    local ry = ValueSelector.Main.AbsoluteSize.Y - math.clamp(mouse.Y - ValueSelector.Main.AbsolutePosition.Y, 0, ValueSelector.Main.AbsoluteSize.Y)
                    local stepY = 255/ValueSelector.Main.AbsoluteSize.Y
                    local newV = math.floor(ry*stepY)
                    gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["V"] = newV
                    wait()
                until not selectingSaturation
            end
        end)
        ValueSelector.Main.InputEnded:Connect(function(input)
            selectingSaturation = false
        end)

        local selectingColor = false
        ColorSelector.Main.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                selectingColor = true
                local mouse = game:GetService("Players").LocalPlayer:GetMouse()
                repeat
                    local rx = ColorSelector.Main.AbsoluteSize.X - math.clamp(mouse.X - ColorSelector.Main.AbsolutePosition.X, 0, ColorSelector.Main.AbsoluteSize.X)
                    local ry = ColorSelector.Main.AbsoluteSize.Y - math.clamp(mouse.Y - ColorSelector.Main.AbsolutePosition.Y, 0, ColorSelector.Main.AbsoluteSize.Y)
                    local stepX = 255/ColorSelector.Main.AbsoluteSize.X
                    local stepY = 255/ColorSelector.Main.AbsoluteSize.Y
                    local newH = math.floor(rx*stepX)
                    local newS = math.floor(ry*stepY)
                    gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["H"] = newH
                    gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["S"] = newS
                    wait()
                until not selectingColor
            end
        end)

        ColorSelector.Main.InputEnded:Connect(function(input)
            selectingColor = false
        end)

        obj.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] = not gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
                SelectBG.Visible = gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
                if gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"] == true then
                    game:GetService("TweenService"):Create(gearImage, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Rotation = 180}):Play()
                    spawn(function()
                        wait(0.7)
                        --gearImage.Rotation = 0
                    end)
                    
                else
                    game:GetService("TweenService"):Create(gearImage, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Rotation = 0}):Play()
                end
            end
        end)
        spawn(function()
            gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
                local r,g,b = hsvToRgb(gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["H"]/255,gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["S"]/255,gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["V"]/255)
                obj.BackgroundColor3 = Color3.fromHSV(gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["H"]/255,gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["S"]/255,gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["V"]/255)
                gui["pages"][Page]["Functions"][NumberInList][Name]["Color"] = obj.BackgroundColor3
                ValueSelector.Main.BackgroundColor3 = Color3.fromHSV(gui["pages"][Page]["Functions"][NumberInList][Name]["ColorHSV"]["H"]/255,1,1)
                
                if gui.page[1] == Page and gui.page[2] == NumberInList then
                    obj.Visible = true
                else
                    obj.Visible = false
                end
            end)
        end)
    else
        warn("No page named:",Name)
    end
end

function gui:IsExist(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    if gui["pages"][Page]["Functions"][NumberInList] ~= nil then
        return gui["pages"][Page]["Functions"][NumberInList][Name] ~= nil
    else
        return false
    end
end

function gui:SetIsChecked(Page, Name, Value, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"] = Value
end

function gui:IsChecked(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    local ret;
    xpcall(function() 
        ret = gui["pages"][Page]["Functions"][NumberInList][Name]["Enabled"]
    end, function()
        ret = false
    end)
    return ret
end

function gui:IsOpened(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Opened"]
end

function gui:IsItemSelected(Page, Name, ItemName, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    local selected = false
    for _i,_ in pairs(gui["pages"][Page]["Functions"][NumberInList][Name]["Items"]) do
        if _i == ItemName then
            selected = true
        end
    end
    return selected
end

function gui:GetState(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["State"]
end

function gui:SetState(Page, Name, Value, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["State"] = Value
end

function gui:GetDropItem(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Item"]
end

function gui:GetDropSelectedItems(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Items"]
end

function gui:GetSelectedBone(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Spots"][NumberInList][Name]["Bone"]
end

function gui:SetText(Page, Name, Text, NumberInList)
	if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["Text"] = Text
end

function gui:SetButtonExec(Page, Name, Exec, NumberInList)
	if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"] = Exec
end

function gui:SetPageExec(Page, Exec)
    gui["pages"][Page]["Exec"] = Exec
end

function gui:SetList(Page, Name, Params, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    gui["pages"][Page]["Functions"][NumberInList][Name]["ItemList"] = Params
end

function gui:GetText(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Text"]
end

function gui:GetColor(Page, Name, NumberInList)
    if NumberInList == nil then
        NumberInList = 1
    end
    return gui["pages"][Page]["Functions"][NumberInList][Name]["Color"]
end

gui:Page("Aimbot")
gui:CheckBox("Aimbot", "Enabled")
gui:Slider("Aimbot", "Hitbox size")

gui:Page("Visuals")
gui:CheckBox("Visuals", "Enabled")
gui:CheckBox("Visuals", "Team check")
gui:CheckBox("Visuals", "Box")
gui:CheckBox("Visuals", "Lines")
gui:CheckBox("Visuals", "Chams")
gui:CheckBox("Visuals", "Skeleton")
--gui:CheckBox("Visuals", "Health")
--gui:CheckBox("Visuals", "Health bar")
--gui:CheckBox("Visuals", "Weapon")
--gui:CheckBox("Visuals", "Distance")

gui:Page("Player")
gui:Slider("Player", "Speed", 500)

gui:Page("Misc")
gui:CheckBox("Misc", "Noclip")

gui:Page("HvH")
--gui:CheckBox("HvH", "Masskill")

gui:Page("Configs")
gui:Button("Configs", "Load")
gui:Button("Configs", "Save")
gui:Button("Configs", "Create")
gui:Input("Configs", "Config name")
gui:Button("Configs", "Update list")
gui:DropDown("Configs", "Config")

gui:Page("Colors")
gui:ColorSelector("Colors", "Esp color", 1, Color3.fromRGB(0,0,0))
gui:ColorSelector("Colors", "Chams color", 1, Color3.fromRGB(0,0,0))

wait(1)

pcall(function()
    if gui["pages"]["Configs"]["Functions"][1]["Config"]["Opened"] == false then
        local list = {}
        for _,v in pairs(listfiles("")) do
            if v:sub(#v-4,#v) == ".scfg" then
                list[#list+1] = v:sub(1,#v-5)
            end
        end
        gui:SetList("Configs", "Config", list)
    end
end)

gui:SetButtonExec("Configs", "Update list", function()
    if gui["pages"]["Configs"]["Functions"][1]["Config"]["Opened"] == false then
        local list = {}
        for _,v in pairs(listfiles("")) do
            if v:sub(#v-4,#v) == ".scfg" then
                list[#list+1] = v:sub(1,#v-5)
            end
        end
        gui:SetList("Configs", "Config", list)
    end
end)

gui:SetButtonExec("Configs", "Create", function()
    if gui:GetText("Configs", "Config name") ~= "" then
        writefile(gui:GetText("Configs", "Config name")..".scfg", "")
    end
end)

gui:SetButtonExec("Configs", "Load", function()
    local HttpService = game:GetService("HttpService")
    if gui:GetDropItem("Configs", "Config") ~= "" then
        local loadedData = readfile(gui:GetDropItem("Configs", "Config")..".scfg")
        local config = {}
        config = HttpService:JSONDecode(loadedData)
        local a,b = pcall(function()
            for pageName,page in pairs(config) do
                for num,func in pairs(page["Functions"]) do
                    for paramName,param in pairs(func) do
                        pcall(function()
                            if param["Type"] == "CheckBox" then
                                gui["pages"][pageName]["Functions"][num][paramName]["Enabled"] = param["Enabled"]
                            end
                            if param["Type"] == "Slider" then
                                gui["pages"][pageName]["Functions"][num][paramName]["State"] = param["State"]
                            end
                            if param["Type"] == "DropDown" then
                                gui["pages"][pageName]["Functions"][num][paramName]["Item"] = param["Item"]
                            end
                            if param["Type"] == "MultiDropDown" then
                                gui["pages"][pageName]["Functions"][num][paramName]["Items"] = param["Items"]
                            end
                            if param["Type"] == "ColorSelector" then
                                print("set",paramName,"to",param["H"])
                                gui["pages"][pageName]["Functions"][num][paramName]["ColorHSV"]["H"] = param["ColorHSV"]["H"]
                                gui["pages"][pageName]["Functions"][num][paramName]["ColorHSV"]["S"] = param["ColorHSV"]["S"]
                                gui["pages"][pageName]["Functions"][num][paramName]["ColorHSV"]["V"] = param["ColorHSV"]["V"]
                                gui["pages"][pageName]["Functions"][num][paramName]["Color"] = param["Color"]
                            end
                        end)
                    end
                end
                for num,spot in pairs(page["Spots"]) do
                    for paramName,param in pairs(spot) do
                        pcall(function()
                            if param["Type"] == "Spot" then
                                gui["pages"][pageName]["Spots"][num][paramName]["Bone"] = param["Bone"]
                            end
                        end)
                    end
                end
            end
        end)
        if not a then
            print(b)
        end
    end
end)

gui:SetButtonExec("Configs", "Save", function()
    local HttpService = game:GetService("HttpService")
    local toSave = {}--gui["pages"][Page]["Functions"][NumberInList][Name]["Executable"]
    local counter = 0
    local line = 0
    

    local data = HttpService:JSONEncode(gui["pages"])
    --print(data)
    if gui:GetDropItem("Configs", "Config") ~= "" then
        writefile(gui:GetDropItem("Configs", "Config")..".scfg", data)
    end
end)

------------------------------------------  ██▓      █    ██  ▄▄▄      -----------------------------------------
-----------------------------------------   ▓██▒     ██  ▓██▒▒████▄     ---------------------------------------
----------------------------------------    ▒██░    ▓██  ▒██░▒██  ▀█▄    --------------------------------------
---------------------------------------     ▒██░    ▓▓█  ░██░░██▄▄▄▄██    -------------------------------------
--------------------------------------      ░██████▒▒▒█████▓  ▓█   ▓██▒    ------------------------------------
---------------------------------------     ░ ▒░▓  ░░▒▓▒ ▒ ▒  ▒▒   ▓▒█░   -------------------------------------
----------------------------------------    ░ ░ ▒  ░░░▒░ ░ ░   ▒   ▒▒ ░  --------------------------------------
-----------------------------------------     ░ ░    ░░░ ░ ░   ░   ▒    ---------------------------------------
------------------------------------------      ░  ░   ░           ░  ░----------------------------------------

local mainGame = {
    initlized = false,
    lplr = nil,
    playerList = {},
}

function SpawnVisuals(plr)
    plr["Box"] = Drawing.new("Square")
    plr["Box"].Color = Color3.new(255,255,255)
    plr["Box"].Thickness = 1
    plr["Box"].Filled = false
    --[[plr["Nametag"] = Drawing.new("Text")
    plr["Nametag"].Text = "Name"
    plr["Nametag"].Font = 2
    plr["Nametag"].Size = 12
    plr["Nametag"].Center = true]]
    plr["Tracer"] = Drawing.new("Line")
    plr["Tracer"].Color = Color3.new(255,255,255)
    plr["Chams"] = Instance.new("Highlight", plr.char)
    for i = 1, 15 do
        pcall(function()
            plr["Freeline"..tostring(i)] = Drawing.new("Line")
            plr["Freeline"..tostring(i)].Color = Color3.new(255,255,255)
        end)
    end
    
end

gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
    if not workspace:FindFirstChild("ads_in",true) then
        if mainGame.initlized == true then
            gui:Notify("Info", "Disconnected from the game", 2)
        end
        for i,v in pairs(guiPlacing:GetChildren()) do
            if v.Name == "Drawing" then
                for _,obj in pairs(v:GetChildren()) do
                    obj:Destroy()
                end
            end
        end
        mainGame.initlized = false
        for _, plr in pairs(mainGame.playerList) do
            for paramName,param in pairs(plr["Visuals"]) do
                if paramName ~= "Box" or paramName ~= "Tracer" then return end
                param.Visible = false
            end
        end
        mainGame.playerList = {}
        return;
    end

    for _,v in pairs(workspace:GetChildren()) do
        if v.Name == "soldier_model" then
            if v:FindFirstChild("fpv_rig",true) then
                mainGame.lplr = v
            else
                local alreadyExists = false
                for _,plr in pairs(mainGame.playerList) do
                    if plr.char == v then
                        alreadyExists = true
                    end
                end
                if not alreadyExists then
                    mainGame.playerList[#mainGame.playerList+1] = {
                        char = v,
                    }
                    mainGame.playerList[#mainGame.playerList]["Visuals"] = {}
                    SpawnVisuals(mainGame.playerList[#mainGame.playerList]["Visuals"])
                end
            end
        end   
    end
    if mainGame.initlized == false then
        gui:Notify("Info", "Game initlized", 2)
    end
    mainGame.initlized = true
end)

local Vec2 = {}
setmetatable(Vec2, {__call = function(_,x, y) 
    return Vector2.new(x,y)
end})
function Vec2:Normalize(vector)
    if vector.x and vector.y then
        return Vector2.new(vector.x, vector.y)
    end
end
local printed = false
gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
    if mainGame.initlized == true then
        --mainGame.lplr.HumanoidRootPart.Rotation = Vector3.new(0, -0.35499998927116394, 0)
        for _,plr in pairs(mainGame.playerList) do
            spawn(function()
                if gui:IsChecked("Aimbot", "Enabled") then
                    local hitSize = "Aimbot", "Hitbox size"
                    local head = plr.char:FindFirstChild("TPVBodyVanillaHead")

                    if not printed then
                        print(head.Size)
                        printed = true
                    end

                end
            end)
            spawn(function()
                local camera = workspace.CurrentCamera
                local function getBone2D(bone)
                    return Vec2:Normalize( camera:WorldToViewportPoint(plr.char:FindFirstChild("TPVBodyVanilla"..bone).CFrame.Position) )
                end
                local primarypart = plr.char:FindFirstChild("TPVBodyVanillaTorsoFront")
                local primarypartVec, onScreen = camera:WorldToViewportPoint(primarypart.Position)
                primarypartVec = Vec2:Normalize(primarypartVec)
                local headVec = Vec2:Normalize( camera:WorldToViewportPoint(plr.char:FindFirstChild("TPVBodyVanillaHead").Position) )
                local shoelVec = Vec2:Normalize( camera:WorldToViewportPoint(plr.char:FindFirstChild("TPVBodyVanillaShoesL").Position) )
                local leglVec = Vec2:Normalize( camera:WorldToViewportPoint(plr.char:FindFirstChild("TPVBodyVanillaLegL").Position) )
                --[[]]
                local bones = {
                    Head = getBone2D("Head"),
                    Torso = getBone2D("TorsoFront"),
                    TorsoDown = Vec2:Normalize( camera:WorldToViewportPoint(plr.char:FindFirstChild("TPVBodyVanillaTorsoFront").CFrame.Position-Vector3.new(0,4,0)) ),
                    ArmL = getBone2D("ArmL"),
                    ArmR = getBone2D("ArmR"),
                    GloveL = getBone2D("GloveL"),
                    GloveR = getBone2D("GloveR"),
                    LegL = getBone2D("LegL"),
                    LegR = getBone2D("LegR"),
                    KneecapL = getBone2D("KneecapL"),
                    KneecapR = getBone2D("KneecapR"),
                    ShoesL = getBone2D("ShoesL"),
                    ShoesR = getBone2D("ShoesR"),
                }
                --]]
                local height = shoelVec.y - headVec.y
                local width = height/2
                --print(height,onScreen,primarypartVec)
                local work = true
                if gui:IsChecked("Visuals", "Team check") then
                    if plr.char:FindFirstChild("friendly_marker") and plr.char:FindFirstChild("friendly_marker").marker.ImageColor3 == Color3.fromRGB(67, 140, 229) then
                        work = false
                    end
                end
                if onScreen and gui:IsChecked("Visuals", "Enabled") and work == true then
                    local BaseColor = gui:GetColor("Colors", "Esp color", 1)
                    local ChamsColor = gui:GetColor("Colors", "Chams color", 1)
                    if gui:IsChecked("Visuals", "Box") then
                        plr["Visuals"]["Box"].Size = Vec2(width,height)
                        plr["Visuals"]["Box"].Position = Vec2(shoelVec.x-width/2,leglVec.y)
                        plr["Visuals"]["Box"].Color = BaseColor
                    end
                    if gui:IsChecked("Visuals", "Lines") then
                        plr["Visuals"]["Tracer"].Thickness = 1
                        plr["Visuals"]["Tracer"].From = Vec2(workspace.CurrentCamera.ViewportSize.x/2, workspace.CurrentCamera.ViewportSize.y)
                        plr["Visuals"]["Tracer"].To = Vec2(shoelVec.x,leglVec.y+height)
                        plr["Visuals"]["Tracer"].Color = BaseColor
                    end
                    
                    if gui:IsChecked("Visuals", "Skeleton") then
                        
                        local skeletonThick = 2
                        local iter = 0
                        local function drawBone(from,to)
                            iter = iter + 1
                            plr["Visuals"]["Freeline"..iter].Thickness = skeletonThick
                            plr["Visuals"]["Freeline"..iter].From = bones[from]
                            plr["Visuals"]["Freeline"..iter].To = bones[to]
                            plr["Visuals"]["Freeline"..iter].Color = BaseColor
                        end

                        drawBone("Head","Torso")

                        drawBone("Torso","ArmL")
                        drawBone("ArmL","GloveL")
                        drawBone("Torso","ArmR")
                        drawBone("ArmR","GloveR")
                        drawBone("ArmR","GloveR")

                        drawBone("Torso","TorsoDown")
                        drawBone("TorsoDown","LegL")
                        drawBone("LegL","KneecapL")
                        drawBone("KneecapL","ShoesL")
                        drawBone("TorsoDown","LegR")
                        drawBone("LegR","KneecapR")
                        drawBone("KneecapR","ShoesR")
                        
                    end
                    --]]
                    if gui:IsChecked("Visuals", "Chams") then
                        plr["Visuals"]["Chams"].Name = "OutLine"
                        plr["Visuals"]["Chams"].Enabled = true 
                        plr["Visuals"]["Chams"].DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        plr["Visuals"]["Chams"].FillTransparency = 1
                        plr["Visuals"]["Chams"].OutlineTransparency = 0
                        plr["Visuals"]["Chams"].FillColor = ChamsColor
                        plr["Visuals"]["Chams"].OutlineColor = BaseColor
                    else
                        plr["Visuals"]["Chams"].Enabled = false 
                    end

                    for paramName, param in pairs(plr["Visuals"]) do
                        if paramName ~= "Box" or paramName ~= "Tracer" then return end
                        param.Visible = true
                    end
                else
                    for _, param in pairs(plr["Visuals"]) do
                        if paramName ~= "Box" or paramName ~= "Tracer" then return end
                        param.Visible = false
                    end
                end
            end)
        end
    end
end)

local noclipped = false
local clipped = false

gui["Hooks"][#gui["Hooks"]+1] = game:GetService("RunService").RenderStepped:Connect(function()
    if mainGame.initlized == true then
        mainGame.lplr["HumanoidRootPart"].CFrame = mainGame.lplr["HumanoidRootPart"].CFrame + mainGame.lplr["fpv_humanoid"].MoveDirection * gui:GetState("Player", "Speed")/100
    
        if gui:IsChecked("Misc", "Noclip") then
            clipped = false
            if noclipped == false then
                noclipped = true
                for i,v in pairs(workspace.workspace:GetDescendants()) do
                    local work = false
                    pcall(function()
                        if v.CanCollide == true then
                            work = true
                        end
                        if v.Parent.Name == "core" and v.Name == "Part" then
                            work = false
                        end
                    end)
                    if not v:FindFirstChild("Noclipped") and work then
                        --print("creating noclip by path", v:GetFullName())
                        local boolINST = Instance.new("BoolValue", v)
                        boolINST.Name = "Noclipped"
                        boolINST.Value = true
                        v.CanCollide = false
                    elseif v:FindFirstChild("Noclipped") and work then
                        v:FindFirstChild("Noclipped").Value = true
                        v.CanCollide = false
                    end
                end
            end
        else
            noclipped = false
            if clipped == false then
                clipped = true
                for i,v in pairs(workspace.workspace:GetDescendants()) do
                    if v:FindFirstChild("Noclipped") then
                        v:FindFirstChild("Noclipped").Value = false
                        v.CanCollide = true
                    end
                end
            end
        end
    else
        clipped = false
        noclipped = false
    end
end)

local UserInputService = game:GetService("UserInputService")
local cd = false
gui["Hooks"][#gui["Hooks"]+1] = UserInputService.InputBegan:Connect(function(input, _gameProcessed)
	if input.KeyCode == Enum.KeyCode.Insert and not cd then
        cd = true
		gui.objs["MainFrame"].Visible = not gui.objs["MainFrame"].Visible
        gui.objs["AntiMissclick"].Size = ((gui.objs["MainFrame"].Visible and UDim2.fromScale(1,1)) or UDim2.fromScale(0,0))
	end
end)

gui["Hooks"][#gui["Hooks"]+1] = UserInputService.InputEnded:Connect(function(input, _gameProcessed)
	if input.KeyCode == Enum.KeyCode.Insert then
        cd = false
	end
end)

print("made by slaimmials\ndiscord: diskord_hyeta")
gui.objs["Gui"].Enabled = true

gui:SetButtonExec("Misc", "Unload", function()
    gui.Loaded = false
    for _,hook in pairs(gui["Hooks"]) do
        spawn(function()hook:Disconnect()end)
    end
    gui.objs["Gui"]:Destroy()
end)
