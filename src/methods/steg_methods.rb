require 'chunky_png'
require 'open3'
require 'tty-prompt'
require_relative '../classes/not_png_error.rb'
require_relative '../classes/file_missing_error.rb'
require_relative '../classes/message_too_big_error.rb'
require_relative 'font_methods.rb'
require_relative 'conversion_methods.rb'

# Encodes data 
def encode(hex, digit)
    hex[-1] = digit
    return hex
end

# Decodes data 
def decode(hex) 
    hex = hex.delete_prefix("#")
    if hex[-1] == "0"
        return "0"
    elsif hex[-1] == "1"
        return "1"
    else
        return
    end
end

# Populates and returns an array with the rgb values for each pixel
def get_pixel_data(image)
    pixel_data = []

    # Loop through every pixel. Each pixel has an x and y coordinate.
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

    # Loop through every pixel. Each pixel has an x and y coordinate.
    (0..image.dimension.width-1).each do |x|
        (0..image.dimension.height-1).each do |y|
            new_img[x,y] = ChunkyPNG::Color.rgb(pixels[pixel_index][0], pixels[pixel_index][1], pixels[pixel_index][2])
            pixel_index += 1 
        end
    end
    return new_img
end

def hide(message, path)
    # delimiter is encoded so that when the decode happens the delimiter is found and we know a message was hidden
    delimiter = "11111001010101010010101011110101"
    binary_message = str2bin(message) + delimiter

    # use ChunkyPNG to create an image instance
    img = ChunkyPNG::Image.from_file(path)
    # turn image pixels into formatted data
    old_data = get_pixel_data(img)
    begin
        raise MessageTooBig unless binary_message.length < old_data.length
        rescue MessageTooBig => e
            puts error_style(e.message)
            return_to_menu?
    end 

    # array to store the new pixel data
    new_data = []
    # the current place we are up to in our binary
    binary_message_index = 0

    old_data.each do |pixel|
        # if binary_message_index is less than the length of the binary then try and store data
        if binary_message_index < binary_message.length
            # encode new pixels, convert back to rgb and push into new_data, increment binary_message_index
            new_pixel = encode(rgb2hex(pixel), binary_message[binary_message_index])
            new_data << hex2rgb(new_pixel)
            binary_message_index += 1
        else
            # if message already encoded the rest of pixels are pushed into new_data without changing
            new_data << pixel
        end
    end

    # turn the new pixel data into a new image instance. Old image passed to get dimensions
    new_img = create_image_with_pixel(new_data, img)
    # save image to file
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

# Lists the png files in the current directory
def list_png
    stdout, _stderr, _status = Open3.capture3("ls *.png")
    puts "PNG Files in:  " + "#{`pwd`}"
    puts stdout
end

def list_prompt
    prompt = TTY::Prompt.new
    if prompt.yes?("Do you want to list .png files in current directory?") == true
        list_png
    end
end

# Exits back to the terminal
def exit_app
    puts "Exiting"
    sleep(2)
    system "clear"
    exit
end

def exit_to_menu?(str)
    if str == "exit"
        return_to_menu
    end
end

def return_to_menu?
    prompt = TTY::Prompt.new
    if prompt.yes?("Do you want to return to the main menu?") == true
        return_to_menu
    else
        exit_app
    end
end

def return_to_menu
    puts "Returning to menu"
    sleep(3)
    main_menu
end

# Writes the .txt file
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
    # use ChunkyPNG to create an image instance
    img = ChunkyPNG::Image.from_file(path)
    pixel_data = get_pixel_data(img)

    binary = ""
    delimiter = "11111001010101010010101011110101"

    # iterate over ever pixel and add to binary if there is a message hidden
    pixel_data.each do |pixel|
        
        digit = decode(rgb2hex(pixel))
        if digit == "0"
            binary += "0"
        elsif digit == "1"
            binary += "1"
        else
            next
        end
        # if binary[-32..-1] is same as delimiter then the message has been completely found
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
