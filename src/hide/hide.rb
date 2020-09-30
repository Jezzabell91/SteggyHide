require 'chunky_png'

# Takes an array with values [r, g, b] and converts to hexidecimal
def rgb2hex(rgb)
    hex = "#{rgb[0].to_s(16)}#{rgb[1].to_s(16)}#{rgb[2].to_s(16)}"
    return hex
end

# Test to see if rgb2hex works as expected
# puts rgb2hex([245, 120, 65])
# => "f57841"


# Takes a hexidecimal value and converts it to rgb array [r, g, b]
def hex2rgb (hex)
    # remove # character from in front of hex value if it is present
    hex = hex.delete_prefix("#")
    # first two values represent red, next two represent green, last two represent blue
    r = hex[0..1].to_i(16)
    g = hex[2..3].to_i(16)
    b = hex[4..5].to_i(16)
    # place in array
    rgb = [r, g, b]
    return rgb
end

# Test to see if hex2rgb works as expected
# p hex2rgb(rgb2hex([245, 120, 64]))
# => [245, 120, 64]

# https://blog.anidear.com/2011/11/convert-string-to-binary-in-ruby.html


# Takes a string and turns it into a binary string 
def str2bin(message)
    binary = message.unpack("B*")[0]
    return binary
end

# Test to see if str2bin works as expected
# puts str2bin("Hello world") 
# => "0100100001100101011011000110110001101111001000000111011101101111011100100110110001100100"

# Takes a binary string and returns a string of ASCII characters
def bin2str(binary)
    str = [binary].pack("B*")
    return str
end

# Test to see if bin2str works as expected
# puts bin2str("0100100001100101011011000110110001101111001000000111011101101111011100100110110001100100")
# => "Hello world"


# https://stackoverflow.com/questions/3505475/check-if-an-integer-is-within-a-range/18599494 


# BUG IS HERE - works now i think
def encode(hex, digit)
    hex = hex.delete_prefix("#")
    # return hex[-1]
    if hex[-1] == "0" || hex[-1] == "1" || hex[-1] == "2" || hex[-1] == "3" || hex[-1] == "4" || hex[-1] == "5"
        hex[-1] = digit
        return hex
    else 
        return hex
    end
end

# Test to see if encode works as expected
# puts encode("f57840", "0")
# puts encode("f57841", "1")
# puts encode("f57842", "1")
# puts encode("f57843", "0")
# puts encode("f57844", "1")
# puts encode("f57845", "0")
# puts encode("f57846", "1")
# puts encode("f57847", "1")
# puts encode("f57848", "1")
# puts encode("f57849", "1")
# puts encode("f5784b", "1")
# puts encode("f5784c", "1")
# puts encode("f5784d", "1")
# puts encode("f5784e", "1")
# puts encode("f5784f", "1")

# => "f57842"

def decode(hex) 
    hex = hex.delete_prefix("#")
    if hex[-1] == "0"
        return "0"
    elsif hex[-1] == "1"
        return "1"
    else
        return nil
    end
end

# puts decode(rgb2hex([247, 247, 247]))
# puts decode(rgb2hex([243, 192, 193]))
# puts decode(rgb2hex([45, 49, 24]))
# puts decode(rgb2hex([30, 32, 34]))
# puts rgb2hex([30, 32, 34])
# puts decode(rgb2hex([46, 50, 16]))

# Test to see if decode works as expected
# puts decode("#f57841")
# => "1"

# puts decode("#f57847")
# puts decode("#f57841")
# puts decode("#f57842")
# puts decode("#f57840")
# puts decode("#f57844")
# puts decode("#f57845")
# puts decode("#f57846")

# https://stackoverflow.com/a/11907718


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

# Test to see if get_pixel_data works as expected
# image = ChunkyPNG::Image.from_file('r_tiny.png')
# p get_pixel_data(image)
# => [[247, 247, 247], [247, 247, 247], [247, 247, 247], [247, 247, 247], 
#       [247, 251, 251], [247, 253, 253], [247, 247, 247], ..., [243, 192, 193]]


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

# Test to see if create_image_with_pixel works as expected
# image = ChunkyPNG::Image.from_file('r_tiny.png')
# new_img = create_image_with_pixel(get_pixel_data(image), image)
# new_img.save("test.png")
# => test.png created in current directory

def hide(message)
    delimiter = '1111111111111110'
    binary_message = str2bin(message) + delimiter
    p binary_message
    p bin2str(binary_message[0..-17])

    # puts "Enter image path"
    # path = gets.chomp
    # if File.extname(path) == ".png"
    #     img = ChunkyPNG::Image.from_file(path)
    #     old_data = get_pixel_data(img)

    #     # part of test
    #     # p old_data[0..10]

    #     # all of our new pixel data
    #     new_data = []
    #     # the current place we are up to in our binary
    #     binary_message_index = 0
    #     temp = ''
    #     # hex_data = []
    #     # for each pixel in old_data
    #     old_data.each do |pixel|
    #         # hex_data << rgb2hex(pixel)

    #         # if binary_message_index is less than the length of the binary then try and story data
    #         if binary_message_index < binary_message.length
    #             # encode new pixels 

    #             new_pixel = encode(rgb2hex(pixel), binary_message[binary_message_index])

    #             new_data << hex2rgb(new_pixel)
    #             binary_message_index += 1
    #         else
    #             new_data << pixel
    #         end
    #     end
    #     # p hex_data
    #     # part of test
    #     # p new_data[0..10]

    #     new_img = create_image_with_pixel(new_data, img)
    #     new_img.save("test#{path}")
    #     puts "Successful image save"
    # else
    #     puts "Invalid file"
    # end
end

# Test if hide is working as expected 

# --uncomment line 141 "p pixel_data[0..10]"
# --uncomment line 163 "p new_data[0..10]"
# => pixel_data [[69, 70, 77], [30, 32, 36], [46, 54, 28], [46, 50, 26], [45, 50, 25], 
#   [45, 50, 25], [44, 49, 24], [44, 49, 24], [45, 49, 24], [45, 49, 24], [43, 49, 24]]
# => new_data [[69, 70, 64], [30, 32, 37], [46, 54, 17], [46, 50, 16], [45, 50, 25], [45, 50, 25], 
#   [44, 49, 24], [44, 49, 24], [45, 49, 24], [45, 49, 24], [43, 49, 24]]

# binary = "01001000011001010110110001101100011011110010000001110111011011110111001001101100011001001111111111111110"
# delimiter = '1111111111111110'
#     if binary[-16..-1] == delimiter
#         puts "Done"
#         puts "#{bin2str(binary[0..-17])}"
#     else
#         puts "It's bwoken"
#     end

def find
    binary = ""
    delimiter = '1111111111111110'

    puts "Enter image path"
    path = gets.chomp

    if File.extname(path) == ".png"
        img = ChunkyPNG::Image.from_file(path)
        pixel_data = get_pixel_data(img)

        binary = ""
        delimiter = "1111111111111110"

        pixel_data.each do |pixel|
            
            digit = decode(rgb2hex(pixel))
            if digit.nil? == false
                binary = binary + digit
                # p binary
                if binary[-16..-1] == delimiter
                    puts "Success"
                    puts binary
                    # puts bin2str(binary[0..-17])
                    return bin2str(binary[0..-17])
                end
            end
        end
        # Edge cases - 
        # Reach end of each and haven't hit delimiter
        # possible if message is longer than image size
        puts   bin2str(binary)  
        return bin2str(binary)
    else
        puts "Invalid file"
    end

end

hide("a".strip)
# find

# binary = ""
# delimiter = '1111111111111110'
# for each pixel in old_data
# pixel_data.each do |pixel|
    
    # digit = decode(rgb2hex([69, 70, 76])).to_i
    # p digit
#     if digit.nil? == false
#         binary = binary + digit
#         if binary[-16..-1] == delimiter
#             puts "Success"
#             return bin2str(binary[0..-17])
#         end
#     end
# end