require_relative 'font_methods.rb'
require_relative 'steg_methods.rb'
require_relative '../classes/not_hex_error.rb'
require_relative '../classes/not_rgb_error.rb'
require_relative '../classes/not_binary_error.rb'
require_relative '../classes/string_too_big_error.rb'
require_relative '../classes/argument_missing_error.rb'

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

# Converting hex to rgb using command line arguments
def argv_convert_hex_to_rgb
    hex = ARGV[1]
    raise ArgumentMissing if ARGV[1].nil?
    hex = hex.delete_prefix("0x")

    raise NotHexError unless check_if_hex(hex)

    puts "\nConverting: ##{hex.upcase} to RGB\n"

    rgb = hex2rgb(hex)
    p rgb
end

# Converting rgb to hex using command line arguments
def argv_convert_rgb_to_hex
    rgb = []
    rgb << ARGV[1].to_i
    rgb << ARGV[2].to_i
    rgb << ARGV[3].to_i

    raise NotRgbError unless check_if_valid_rgb(rgb[0])
    raise NotRgbError unless check_if_valid_rgb(rgb[1])
    raise NotRgbError unless check_if_valid_rgb(rgb[2])

    puts "\nConverting Red: #{rgb[0].to_s}, Green: #{rgb[1].to_s}, Blue: #{rgb[2].to_s}, to hexadecimal\n"
    
    hex = rgb2hex(rgb)
    sleep(1)
    puts "##{hex.upcase}"
end

def check_if_hex(hex)
    # Hex for RGB needs to be between 3 and 6 digits
    if hex.size < 3 || hex.size > 6
        return false
    end

    hex.chars.each do |char|
        # Each character must be [0-9][A-F]
        unless char.match(/\h/)
            return false
        end
    end
    return true 
end

def convert_hex_to_rgb
    system "clear"
    puts "#{header_style("HEX  to  RGB")}"

    loop do
        begin
            puts "\nTo convert to RGB enter a hexadecimal color value: "
            hex = gets.chomp.upcase
            hex = hex.delete_prefix("#")
            hex = hex.delete_prefix("0x")

            raise NotHexError unless check_if_hex(hex)
            rescue NotHexError => e
                puts error_style(e.message)
            retry
        end
        
        puts "\nConverting: ##{hex} to RGB\n"
        
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

def check_if_valid_rgb(value)
    # RGB values must be in the range 0-255
    unless value >= 0 && value <= 255
        return false
    end
    return true
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
            raise NotRgbError unless check_if_valid_rgb(red)

            puts "Green:"
            green = gets.chomp
            green = check_if_integer(green)
            raise NotRgbError unless check_if_valid_rgb(green)
            
            puts "Blue:"
            blue = gets.chomp
            blue = check_if_integer(blue)
            raise NotRgbError unless check_if_valid_rgb(blue)
            
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

            raise StringTooBig unless string.size < 512
            rescue StringTooBig => e
                puts error_style(e.message)
            retry

        end
        puts "\nConverting string to binary\n"
        
        binary = str2bin(string)
        
        sleep(1)

        # Formats the binary string with spaces e.g. "string" becomes: 
        # 01110011 01110100 01110010 01101001 01101110 01100111 
        puts binary.scan(/.{8}/).join(' ')
        
        prompt = TTY::Prompt.new
        if prompt.yes?("\nWould you like to do another string to binary conversion?") == true 
        else
            return_to_menu
        end
    end
end

# convert_hex_to_rgb
# convert_rgb_to_hex 
# convert_binary_to_string
# convert_string_to_binary
