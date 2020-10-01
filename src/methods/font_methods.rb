require 'pastel'
require 'tty-font'

def header_style(header)
    pastel = Pastel.new
    font = TTY::Font.new(:standard)
    puts pastel.cyan(font.write("#{header}"))
end

def error_style(error)
    pastel = Pastel.new
    return pastel.red("#{error}")
end

def success_style(success)
    pastel = Pastel.new
    return pastel.green("#{success}")
end