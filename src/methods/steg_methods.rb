require 'chunky_png'
require 'open3'
require_relative '../classes/not_png_error.rb'
require_relative '../classes/file_missing_error.rb'
require_relative '../classes/message_too_big_error.rb'
require_relative 'font_methods.rb'

# Takes an array with values [r, g, b] and converts to hexidecimal
def rgb2hex(rgb)
    hex = "#{rgb[0].to_s(16)}#{rgb[1].to_s(16)}#{rgb[2].to_s(16)}"
    return hex
end

# Takes a hexidecimal value and converts it to rgb array [r, g, b]
def hex2rgb (hex)
    hex = hex.delete_prefix("#")
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

def encode(hex, digit)
        hex[-1] = digit
        return hex
end

def decode(hex) 
    hex = hex.delete_prefix("#")
    if hex[-1] == "0"
        return "0"
    elsif hex[-1] == "1"
        return "1"
    else
        return "nope"
    end
end

# Populates and returns an array with the rgb values for each pixel
def get_pixel_data(image)
    pixel_data = []
    (0..image.dimension.width-1).each do |x|
        (0..image.dimension.height-1).each do |y|
            rgb = [ChunkyPNG::Color.r(image[x,y]), ChunkyPNG::Color.g(image[x,y]), ChunkyPNG::Color.b(image[x,y])]
            pixel_data << rgb
        end
    end
    return pixel_data
end

# Creates an image from an array of pixel data
def create_image_with_pixel(pixels, image)
    new_img = ChunkyPNG::Image.new("#{image.dimension.width}".to_i,"#{image.dimension.height}".to_i, ChunkyPNG::Color::TRANSPARENT)

    pixel_index = 0

    (0..image.dimension.width-1).each do |x|
        (0..image.dimension.height-1).each do |y|
            new_img[x,y] = ChunkyPNG::Color.rgb(pixels[pixel_index][0], pixels[pixel_index][1], pixels[pixel_index][2])
            pixel_index += 1 
        end
    end
    return new_img
end

def hide(message, path)

    delimiter = '1111111111111110'
    binary_message = str2bin(message) + delimiter

    img = ChunkyPNG::Image.from_file(path)
    old_data = get_pixel_data(img)
    begin
        raise MessageTooBig unless binary_message.length < old_data.length
        rescue MessageTooBig => e
            puts error_style(e.message)
            return_to_menu
    end 

    new_data = []

    binary_message_index = 0
    temp = ''

    old_data.each do |pixel|

        if binary_message_index < binary_message.length

            new_pixel = encode(rgb2hex(pixel), binary_message[binary_message_index])

            new_data << hex2rgb(new_pixel)
            binary_message_index += 1
        else
            new_data << pixel
        end
    end

    new_img = create_image_with_pixel(new_data, img)
    save_image(new_img)

    # new_path = get_filepath 
    # new_img.save("#{new_path}")
    # puts "Image saved - #{`pwd`.chomp + '/' + new_path}"
    return_to_menu
end

def save_image(image_data)
    path = save_filepath
    image_data.save(path)
    
    puts success_style("Image saved - #{`pwd`.chomp + '/' + path}")
end

def save_filepath
    begin
        puts "\nEnter the filename for the new image (must end in .png)"
        path = gets.chomp
        raise NotPngError unless path[-4..-1] == ".png"
        rescue
            puts "Invalid file name"
        retry
    end
    return path
end

def get_filepath
    begin
        puts "\nEnter image file path. (must end in .png)"
        puts "Type exit to return to main menu"
        path = gets.chomp
        exit_to_menu?(path)
        raise NotPngError unless path[-4..-1] == ".png"
        raise FileMissing unless File.exist?(path)
        rescue NotPngError, FileMissing => e
            puts error_style(e.message)
            # unless path[-4..-1] == ".png"
            #     puts e.message
            # else
            #     puts "File not found"
            # end
                            # puts "Invalid filetype or file not found"
        retry
    end
    return path
end

def get_message
    puts "Enter the message to hide or type exit to return to main menu"
    message = gets.chomp
    exit_to_menu?(message)
    return message
end

def list_png
    stdout, stderr, status = Open3.capture3("ls *.png")
    puts "PNG Files in:  " + "#{`pwd`}"
    puts stdout
end

def list_prompt
    prompt = TTY::Prompt.new

    if prompt.yes?("Do you want to list .png files in current directory?") == true
        list_png
    end
end


def exit_to_menu?(str)
    if str == "exit"
        main_menu
    end
end

def return_to_menu
    puts "Returning to menu"
    sleep(4)
    main_menu
end

def write_to_file(binary_message, path)
    prompt = TTY::Prompt.new
    if prompt.yes?("Do you want to save the message to a .txt file?") == true
        File.write("#{path[0..-5]}.txt", bin2str(binary_message))
        puts success_style("Message was saved to #{path[0..-5]}.txt")
        return_to_menu
    else
        puts "Message was not saved"
        return_to_menu
    end
end

def find(path)

        img = ChunkyPNG::Image.from_file(path)
        pixel_data = get_pixel_data(img)

        binary = ""
        delimiter = "1111111111111110"

        pixel_data.each do |pixel|
            
            digit = decode(rgb2hex(pixel))
            if digit == "0"
                binary += "0"
            elsif digit == "1"
                binary += "1"
            else
                next
            end
            if binary[-16..-1] == delimiter
                puts success_style("Message was successfully found")
                binary_message = binary[0..-17]
                message = bin2str(binary_message)
                puts "Message reads: "
                puts message
                write_to_file(message, path)
            end
        end

        puts "Message was not found or was unable to be recovered"
        return_to_menu

end
