-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- wezterm.font("Source Han Sans SC VF", {weight=250, stretch="Normal", style="Normal"}) 

config.initial_cols = 135
config.initial_rows = 27

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_blink_rate = 500

-- wezterm has default fallback including Nerd Font Symbols, so no need using patched fonts (2025.08.15)
config.font = wezterm.font_with_fallback {
    -- 'Source Han Sans SC VF',
    'Sarasa Fixed SC',
    'JetBrains Mono',
}

-- For example, changing the color scheme:
-- config.color_scheme = 's3r0 modified (terminal.sexy)'
config.color_scheme = 'Decaf (base16)'

-- key and mouse bindings
config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = wezterm.action_callback(function(window, pane)
            local has_selection = window:get_selection_text_for_pane(pane) ~= ""
            if has_selection then
                window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
                window:perform_action(act.ClearSelection, pane)
            else
                window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
            end
        end),
    },
}

config.keys = {
    -- '%' / '%' registered by default
    {
        key = 'x',
        mods = 'CTRL|SHIFT|ALT',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    -- use 'ctrl' + 'shift' + arrow to navigate between panes
    {
        key = 'h',
        mods = 'CTRL|SHIFT|ALT',
        action = wezterm.action.AdjustPaneSize { 'Left', 1 },
    },
    {
        key = 'j',
        mods = 'CTRL|SHIFT|ALT',
        action = wezterm.action.AdjustPaneSize { 'Up', 1 },
    },
    {
        key = 'k',
        mods = 'CTRL|SHIFT|ALT',
        action = wezterm.action.AdjustPaneSize { 'Down', 1 },
    },
    {
        key = 'l',
        mods = 'CTRL|SHIFT|ALT',
        action = wezterm.action.AdjustPaneSize { 'Right', 1 },
    },
}

-- and finally, return the configuration to wezterm
return config
