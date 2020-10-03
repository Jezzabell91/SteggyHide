require_relative 'font_methods.rb'
require_relative 'steg_methods.rb'
require_relative '../classes/not_hex_error.rb'
require_relative '../classes/not_rgb_error.rb'
require_relative '../classes/not_binary_error.rb'

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



def convert_hex_to_rgb
    system "clear"
    puts "#{header_style("HEX  to  RGB")}"


    loop do
        begin
            puts "\nTo convert to RGB enter a hexadecimal color value: "
            hex = gets.chomp
            hex = hex.delete_prefix("#")
            hex = hex.delete_prefix("0x")

            raise NotHexError unless hex.match(/[[:xdigit:]]{3,6}/)
            rescue NotHexError => e
                puts error_style(e.message)
            retry
        end
        
        puts "\nConverting: ##{hex.upcase} to RGB\n"
        
        rgb = hex2rgb(hex)
        
        sleep(1)
        
        p rgb
        puts "#{red_style("Red:")} #{rgb[0]}, #{green_style("Green:")} #{rgb[1]}, #{blue_style("Blue:")} #{rgb[2]}"
        
        prompt = TTY::Prompt.new
        if prompt.yes?("\n Would you like to do another hex to rgb conversion?") == true 
        else
            return_to_menu
        end
    end
end

def check_if_integer(value)
    if value == "0"
        value = 0
    elsif value.to_i == 0
        value = -1
    else
        value = value.to_i
    end
    return value
end



def convert_rgb_to_hex
    system "clear"
    puts "#{header_style("RGB  to  HEX")}"

    loop do
        begin
            puts "\nTo convert to hexadecimal enter a color value in RGB format: "

            rgb = []

            puts "Red:"
            red = gets.chomp
            red = check_if_integer(red)
            raise NotRgbError unless red >= 0 && red <= 255

            puts "Green:"
            green = gets.chomp
            green = check_if_integer(green)
            raise NotRgbError unless green >= 0 && green <= 255
            
            puts "Blue:"
            blue = gets.chomp
            blue = check_if_integer(blue)
            raise NotRgbError unless blue >= 0 && blue <= 255
            
            rgb << red
            rgb << green 
            rgb << blue 

            rescue NotRgbError => e
                puts error_style(e.message)
            retry
            
        end
        puts "\nConverting Red: #{rgb[0].to_s}, Green: #{rgb[1].to_s}, Blue: #{rgb[2].to_s}, to hexadecimal\n"
        
        hex = rgb2hex(rgb)
        
        sleep(1)
        
        puts "##{hex.upcase}"
        
        prompt = TTY::Prompt.new
        if prompt.yes?("\nWould you like to do another rgb to hex conversion?") == true 
        else
            return_to_menu
        end
    end
end

def convert_binary_to_string
    system "clear"
    puts "#{header_style("Binary  to  String")}"

    loop do
        begin
            puts "\nEnter the binary to convert it to a string: "
            
            binary = gets.chomp 

            # remove any spaces from the string 
            binary = binary.delete(' ')

            raise NotBinaryError unless binary.match(/^[0-1]{1,}$/)
            rescue NotBinaryError => e
                puts error_style(e.message)
            retry

        end
        puts "\nConverting binary to string\n"
        
        string = bin2str(binary)
        
        sleep(1)
        
        puts string
        
        prompt = TTY::Prompt.new
        if prompt.yes?("\nWould you like to do another binary to string conversion?") == true 
        else
            return_to_menu
        end
    end
end

def convert_string_to_binary
    system "clear"
    puts "#{header_style("String  to  Binary")}"

    loop do
        begin
            puts "\nEnter the string to convert it to binary: "
            
            string = gets.chomp 

            # remove any spaces from the string 

            raise StringTooBigError unless string.size > 512
            rescue StringTooBigError => e
                puts error_style(e.message)
            retry

        end
        puts "\nConverting binary to string\n"
        
        string = bin2str(binary)
        
        sleep(1)
        
        puts string
        
        prompt = TTY::Prompt.new
        if prompt.yes?("\nWould you like to do another binary to string conversion?") == true 
        else
            return_to_menu
        end
    end
end

# convert_hex_to_rgb
# convert_rgb_to_hex 
# convert_binary_to_string
# convert_string_to_binary

string = "01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100 01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100
01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100
01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100
01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100
01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100
01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100
01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100
01101000 01100101 01101100 01101100 01101111 00100000 01110111 01101111 01110010 01101100"

p string.size