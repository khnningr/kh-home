local wezterm = require("wezterm")
local home = wezterm.home_dir
wezterm.add_to_config_reload_watch_list(home .. "/.config/wezterm/colors/wezterm-colors.toml")
local constants = require("constants")
local commands = require("commands")
local act = wezterm.action

config = wezterm.config_builder() -- Objeto que construye la configuración.

config = {
    -- Miscellaneous settings
    automatically_reload_config = true, -- Recarga automáticamente la configuración (true).
    enable_wayland = true,
    max_fps = 120,
    scrollback_lines = 3000,
    default_workspace = "home",

    -- Font settings
    -- Puedes usar el siguiente comando para buscar las fonts disponibles y el formato que admite: wezterm ls-fonts --list-system | grep Mono
    font = wezterm.font("IosevkaTerm Nerd Font Propo", {weight="Bold", stretch="Normal", style="Normal"}), -- Estáblece la font con el valor 'Bold' (negrita).
    font_size = 16.0,                                                        -- Tamaño de la font.
    line_height = 1.2,                                                       -- Define el espacio entre las líneas.

    -- Appearance
    window_decorations = "NONE",
    --window_decorations = "RESIZE", -- Deshabita la barra de titulo pero habilita una barra para redimencionar el tamaño de la ventana.
    hide_tab_bar_if_only_one_tab = true,
    enable_tab_bar = false,                    -- Deshabita las tabs o barra de pestañas.
    use_fancy_tab_bar = false,
    window_close_confirmation = "NeverPrompt", -- No pide confirmación para salir del terminal.
    window_padding = {                         -- Define el padding del terminal.
        left = 20,
        right = 20,
        top = 10,
        bottom = 10,
    },
    --window_background_image = constants.bg_image,
    default_cursor_style = "BlinkingUnderline", -- Cambia el estilo del cursos; BlinkingBar - barra parpadeante.
    cursor_blink_rate = 500,                    -- Configura la velocidad de parpadeo del cursor.
    color_scheme = "wezterm-colors",            -- Define la paleta de colores del terminal
    --window_background_opacity = 0.95, -- Define la opacidad del fondo del terminal.

    -- Colors
    colors = {
        cursor_bg = "white",
        cursor_border = "white",
    },

    --default_prog = { 'zellij' }, -- Inicializa un programa con el terminal.
    --front_end = "Software", -- Renderiza el terminal con CPU en lugar de GPU.

    -- 7.38
    -- Dim inactive panes
    inactive_pane_hsb = {

    },

    -- keys
    leader = { key = "a", mods = "ALT" },
    keys = {
        --
        {
            key = "a",
            mods = "LEADER",
            action = act.SendKey { key = "a", mods = "CTRL" },
        },
        {
            key = "c",
            mods = "LEADER",
            action = act.ActivateCopyMode,
        },
        --
        {
            key = "|",
            mods = "LEADER",
            action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
        },
        {
            key = "-",
            mods = "LEADER",
            action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
        },
        --
        {
            key = "h",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Left"),
        },
        {
            key = "j",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Down"),
        },
        {
            key = "k",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Up"),
        },
        {
            key = "l",
            mods = "LEADER",
            action = act.ActivatePaneDirection("Right"),
        },
        -- Cierra el panel actual.
        {
            key = "x",
            mods = "LEADER",
            action = act.CloseCurrentPane { confirm = true },
        },
        --
        {
            key = "z",
            mods = "LEADER",
            action = act.TogglePaneZoomState,
        },
        --
        {
            key = "s",
            mods = "LEADER",
            action = act.RotatePanes "Clockwise",
        },
        --
        {
            key = "r",
            mods = "LEADER",
            action = act.ActivateKeyTable { name = "resize_pane", one_shot = false },
        },
    },

    key_tables = {
        resize_pane = {
            {
                key = "h",
                action = act.AdjustPaneSize { "Left", 1 }
            },
            {
                key = "j",
                action = act.AdjustPaneSize { "Down", 1 }
            },
            {
                key = "k",
                action = act.AdjustPaneSize { "Up", 1 }
            },
            {
                key = "l",
                action = act.AdjustPaneSize { "Right", 1 }
            },
            {
                key = "Escape",
                action = "PopKeyTable"
            },
            {
                key = "Enter",
                action = "PopKeyTable"
            },
        },
    },


    -- Custom commands
    wezterm.on("augment-command-palette", function()
        return commands
    end),


}

return config -- Es necesario retornar el objeto creado.
