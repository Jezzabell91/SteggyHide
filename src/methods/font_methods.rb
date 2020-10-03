require 'pastel'
require 'tty-font'

# Style for feature headers
def header_style(header)
    pastel = Pastel.new
    font = TTY::Font.new(:standard)
    return pastel.cyan(font.write("#{header}"))
end

# Red color for errors
def error_style(error)
    red_style(error)
end

# Green color for successful operations
def success_style(success)
    green_style(success)
end

# RGB style for making RGB thing look
def rgb_style(string)
    pastel = Pastel.new
    styled_rgb = pastel.red("#{string[0]}") + pastel.green("#{string[1]}") + pastel.blue("#{string[2]}")
    return styled_rgb
end

# Red for RGB Strings and errors
def red_style(string)
    pastel = Pastel.new
    red_string = pastel.red("#{string}")
    return red_string
end

# Green for RGB Strings and success
def green_style(string)
    pastel = Pastel.new
    green_string = pastel.green("#{string}")
    return green_string
end

# Blue for RGB Strings
def blue_style(string)
    pastel = Pastel.new
    blue_string = pastel.blue("#{string}")
    return blue_string
end