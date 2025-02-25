_G.Main = {}

-- Function to create a draggable, dynamic frame with a scrolling mechanism
function _G.Main.createFrame(parent, position, color, text, name, maxHeight)
    local frame = Instance.new("Frame")
	local drag = Instance.new("UIDragDetector",frame)
    frame.Parent = parent
    frame.Name = name or "Frame"
    frame.Size = UDim2.new(0,135,0,50)
    frame.Position = position or UDim2.new(0.5, -100, 0.5, 0)
    frame.BackgroundColor3 = color or Color3.fromRGB(49, 49, 49)
    frame.BackgroundTransparency = 0
    frame.ClipsDescendants = true -- Prevents content overflow

    maxHeight = maxHeight or 270

    -- Corner styling
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Parent = frame
    stroke.Thickness = 5
    stroke.Color = Color3.fromRGB(0, 4, 255)

    -- Title label
    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.Size = UDim2.new(0,135,0,50)
    title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    title.BackgroundTransparency = 0.5
    title.BorderSizePixel = 0
    title.Font = Enum.Font.SourceSans
    title.Text = text
    title.TextColor3 = Color3.fromRGB(21, 0, 255)
    title.TextScaled = true
    title.TextWrapped = true

    -- Scrolling frame to contain content
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Parent = frame
    scrollingFrame.Size = UDim2.new(1, 0, 1,0) -- Adjusted to fit below title
    scrollingFrame.Position = UDim2.new(0, 0, 0, 50)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.ScrollBarThickness = 5
    scrollingFrame.ClipsDescendants = true

    -- UIListLayout for content alignment
    local layout = Instance.new("UIListLayout")
    layout.Parent = scrollingFrame
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,5)

    -- Dynamic resizing logic
    local function updateSize()
        local contentHeight = layout.AbsoluteContentSize.Y
        if contentHeight <= maxHeight then
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
            frame.Size = UDim2.new(0, frame.Size.X.Offset, 0, contentHeight + 60) -- Extra for title
            scrollingFrame.ClipsDescendants = false
        else
            scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
            frame.Size = UDim2.new(0, frame.Size.X.Offset, 0, maxHeight + 60)
            scrollingFrame.ClipsDescendants = true
        end
    end

    -- Update when content changes
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)

    return scrollingFrame -- Return scrolling frame for adding buttons
end

-- Function to create a button inside a specific frame
function _G.Main.createButton(parentFrame, text, onClick, size, color)
    local button = Instance.new("TextButton")
    button.Parent = parentFrame
    button.Size = size or UDim2.new(0, 126, 0, 31)
    button.BackgroundColor3 = color or Color3.fromRGB(255, 255, 255)
    button.BackgroundTransparency = 1
    button.Text = text or "Button"
    button.Font = Enum.Font.SourceSans
    button.TextScaled = true
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextXAlignment = "Left"

    -- Corner styling
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    -- State tracking
    local isClicked = false

    -- Click event with toggle logic
    button.MouseButton1Click:Connect(function()
        if isClicked then
            button.TextColor3 = Color3.fromRGB(255, 255, 255) -- Reset to white
        else
            button.TextColor3 = Color3.fromRGB(0,0, 255) -- Change to green when clicked
        end
        isClicked = not isClicked -- Toggle state

        -- Call custom click function if provided
        if onClick then
            onClick()
        end
    end)

    return button
end

function _G.Main.createmarkframe(parent)
local Frame = Instance.new("Frame")
local drag = Instance.new("UIDragDetector",Frame)
local TextLabel = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0,2)

Frame.Parent = parent
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(1,0,0,0)
Frame.AnchorPoint = Vector2.new(1, 0)
Frame.Size = UDim2.new(0.49, 0, 0.456, 0)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Size = UDim2.new(0, 138, 0, 43)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Sapien V1"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

	local label = TextLabel
	local hue = 0 -- Starting hue value

task.spawn(function()
while true do
	label.TextColor3 = Color3.fromHSV(hue, 1, 1) -- Generate rainbow color for text
	hue = hue + 0.01 -- Increment hue
	if hue >= 1 then
		hue = 0 -- Reset hue after one full cycle
	end
	task.wait(0.05) -- Wait for a short duration to control the speed
end
end)
    return Frame
end

function _G.Main.createwatermark(parent,watermark)
local TextLabel_2 = Instance.new("TextLabel")
TextLabel_2.Parent = parent
TextLabel_2.Name = watermark
TextLabel_2.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextLabel_2.BackgroundTransparency = 0.899
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Size = UDim2.new(0, 120, 0, 30)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = watermark
TextLabel_2.TextScaled = true
TextLabel_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.TextSize = 14.000
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
	local label = TextLabel_2
local hue = 0 -- Starting hue value

task.spawn(function()
while true do
	label.TextColor3 = Color3.fromHSV(hue, 1, 1) -- Generate rainbow color for text
	hue = hue + 0.01 -- Increment hue
	if hue >= 1 then
		hue = 0 -- Reset hue after one full cycle
	end
	task.wait(0.05) -- Wait for a short duration to control the speed
end
end)
return TextLabel_2
end
