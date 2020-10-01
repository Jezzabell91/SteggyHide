require 'pastel'
require 'tty-font'

def header_style(header)
    pastel = Pastel.new
    font = TTY::Font.new(:standard)
    puts pastel.cyan(font.write("#{header}"))
end