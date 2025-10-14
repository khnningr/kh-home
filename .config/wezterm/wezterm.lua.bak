local wezterm = require("wezterm")
local home = wezterm.home_dir
wezterm.add_to_config_reload_watch_list(home .. "/.config/wezterm/colors/wezterm-colors.toml")

config = wezterm.config_builder() -- Objeto que construye la configuración.

config = {
  automatically_reload_config = true, -- Recarga automáticamente la configuración (true).
  use_fancy_tab_bar = false,
  enable_tab_bar = false, -- Deshabita las tabs o barra de pestañas.
    window_close_confirmation = "NeverPrompt", -- No pide confirmación para salir del terminal.
  enable_wayland = true,

  -- Appearance
  window_decorations = "NONE",
  --window_decorations = "RESIZE", -- Deshabita la barra de titulo pero habilita una barra para redimencionar el tamaño de la ventana.
  hide_tab_bar_if_only_one_tab = true,
  
  default_cursor_style = "BlinkingUnderline",-- Cambia el estilo del cursos; BlinkingBar - barra parpadeante.
  cursor_blink_rate = 500, -- Configura la velocidad de parpadeo del cursor.
  color_scheme = "wezterm-colors", -- Define la paleta de colores del terminal
  window_background_opacity = 0.95, -- Define la opacidad del fondo del terminal.

  -- Font settings
  -- Puedes usar el siguiente comando para buscar las fonts disponibles y el formato que admite: wezterm ls-fonts --list-system | grep Mono
  font = wezterm.font("IosevkaTerm Nerd Font Mono", { weight = "Bold" }), -- Estáblece la font con el valor 'Bold' (negrita).
  font_size = 16.0, -- Tamaño de la font.
  line_height = 1.2, -- Define el espacio entre las líneas.
  
  -- Colors 
  colors = {
    cursor_bg = "white",
    cursor_border = "white",
  },

  --default_prog = { 'zellij' }, -- Inicializa un programa con el terminal.
  --front_end = "Software", -- Renderiza el terminal con CPU en lugar de GPU.
  background = { -- Define el fondo del terminal...
    {
      source = {
        File = (home .. "/.config/wezterm/background-wez.png"),
      },
      hsb = {
        hue = 1.0,
        saturation = 1.02,
        brightness = 0.25,
      },
      width = "100%",
      height = "100%",
    },
    {
      source = {
        Color = "#282c35",
      },
      width = "100%",
      height = "100%",
      opacity = 0.55,
    },
  },
  window_padding = { -- Define el padding del terminal.
    left = 3,
    right = 3,
    top = 0,
    bottom = 0,
  },

}

return config -- Es necesario retornar el objeto creado.
