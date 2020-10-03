require_relative 'font_methods.rb'
require_relative 'steg_methods.rb'

# Takes an array with values [r, g, b] and converts to hexidecimal
def rgb2hex(rgb)
    hex = "#{rgb[0].to_s(16)}#{rgb[1].to_s(16)}#{rgb[2].to_s(16)}"
    return hex
end

# Takes a hexidecimal value and converts it to rgb array [r, g, b]
def hex2rgb (hex)
    hex = hex.delete_prefix("#")
    # Convert 3 digit hexadecimal to 6 digit 
    if hex.size == 3 
        hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2]
    end
    r = hex[0..1].to_i(16)
    g = hex[2..3].to_i(16)
    b = hex[4..5].to_i(16)
    rgb = [r, g, b]
    return rgb
end

# Takes a string and turns it into a binary string 
def str2bin(message)
    binary = message.unpack("B*")[0]
    return binary
end

# Takes a binary string and returns a string of ASCII characters
def bin2str(binary)
    str = [binary].pack("B*")
    return str
end

def conversion_feature
    system "clear"
    prompt = TTY::Prompt.new
    case prompt.select("What converstion would you like to do?", cycle: true) do |menu|
        # For ordered choices set enum to any delimiter String. 
        # In that way, you can use arrows keys and numbers (0-9) to select the item.
        menu.enum "."
        
        menu.choice "String to binary", 1
        menu.choice "Binary to string", 2
        menu.choice "Hexadecimal to RGB", 3
        menu.choice "RGB to hexadecimal", 4
        menu.choice "Return to main menu", 5
        end
    when 1
        system "clear"
        convert_string_to_binary
    when 2
        system "clear"
        convert_binary_to_string
    when 3
        system "clear"
        convert_hex_to_rgb
    when 4
        system "clear"
        convert_rgb_to_hex        
    when 5
        system "clear"
        return_to_menu
    end
end

def convert_hex_to_rgb
    system "clear"
    puts "#{header_style("HEX  to  RGB")}"
end

def convert_rgb_to_hex
    system "clear"
    puts "#{header_style("RGB  to  HEX")}"
end

def convert_binary_to_string
    system "clear"
    puts "#{header_style("Binary  to  String")}"
end

def convert_string_to_binary
    system "clear"
    puts "#{header_style("String  to  Binary")}"
end
