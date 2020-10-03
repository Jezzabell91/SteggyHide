require 'chunky_png'
require 'open3'
require 'tty-prompt'
require_relative '../classes/not_png_error.rb'
require_relative '../classes/file_missing_error.rb'
require_relative '../classes/message_too_big_error.rb'
require_relative 'font_methods.rb'
require_relative 'conversion_methods.rb'

require 'pry'



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

    delimiter = "11111001010101010010101011110101"
    binary_message = str2bin(message) + delimiter

    img = ChunkyPNG::Image.from_file(path)
    old_data = get_pixel_data(img)
    begin
        raise MessageTooBig unless binary_message.length < old_data.length
        rescue MessageTooBig => e
            puts error_style(e.message)
            return_to_menu?
    end 

    new_data = []

    binary_message_index = 0

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
    return_to_menu?
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

def return_to_menu?
    prompt = TTY::Prompt.new
    if prompt.yes?("Do you want to return to the main menu?") == true
        return_to_menu
    else
        exit
    end
end

def return_to_menu
    puts "Returning to menu"
    sleep(3)
    main_menu
end

def write_to_file(message, path)
    prompt = TTY::Prompt.new
    if prompt.yes?("Do you want to save the message to a .txt file?") == true
        File.write("#{path[0..-5]}.txt", message)
        puts success_style("Message was saved to #{path[0..-5]}.txt")
        return_to_menu?
    else
        puts "Message was not saved"
        return_to_menu?
    end
end

def find(path)

        img = ChunkyPNG::Image.from_file(path)
        pixel_data = get_pixel_data(img)

        binary = ""
        delimiter = "11111001010101010010101011110101"

        pixel_data.each do |pixel|
            
            digit = decode(rgb2hex(pixel))
            if digit == "0"
                binary += "0"
            elsif digit == "1"
                binary += "1"
            else
                next
            end
            if binary[-32..-1] == delimiter
                puts success_style("Message was successfully found")
                binary_message = binary[0..-33]
                message = bin2str(binary_message)
                puts "Message reads: "
                puts message
                write_to_file(message, path)
            end
        end

        puts "Message was not found or was unable to be recovered"
        return_to_menu?

end
