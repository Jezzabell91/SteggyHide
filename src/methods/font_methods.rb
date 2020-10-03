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

def red_style(string)
    pastel = Pastel.new
    red_string = pastel.red("#{string}")
    return red_string
end

def green_style(string)
    pastel = Pastel.new
    green_string = pastel.green("#{string}")
    return green_string
end

def blue_style(string)
    pastel = Pastel.new
    blue_string = pastel.blue("#{string}")
    return blue_string
end