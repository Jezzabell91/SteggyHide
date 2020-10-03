require 'pastel'
require 'tty-font'

def header_style(header)
    pastel = Pastel.new
    font = TTY::Font.new(:standard)
    return pastel.cyan(font.write("#{header}"))
end

def error_style(error)
    pastel = Pastel.new
    return pastel.red("#{error}")
end

def success_style(success)
    pastel = Pastel.new
    return pastel.green("#{success}")
end

def rgb_style(string)
    pastel = Pastel.new
    styled_rgb = pastel.red("#{string[0]}") + pastel.green("#{string[1]}") + pastel.blue("#{string[2]}")
    return styled_rgb
end
