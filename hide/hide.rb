require 'chunky_png'


# Takes an array with values [r, g, b] and converts to hexidecimal
def rgb2hex(rgb)
    hex = "#{rgb[0].to_s(16)}#{rgb[1].to_s(16)}#{rgb[2].to_s(16)}"
    return hex
end

# Test to see if rgb2hex works as expected
# puts rgb2hex([245, 120, 65])


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


# https://blog.anidear.com/2011/11/convert-string-to-binary-in-ruby.html
# Takes a string and turns it into a binary string 
def str2bin(message)
    binary = message.unpack("B*")[0]
    return binary
end

# Test to see if str2bin works as expected
# puts str2bin("Hello world") 

# Takes a binary string and returns a string of ASCII characters
def bin2str(binary)
    str = [binary].pack("B*")
    return str
end

# Test to see if bin2str works as expected
# # puts bin2str(str2bin("Hello world"))


# https://stackoverflow.com/questions/3505475/check-if-an-integer-is-within-a-range/18599494 
# if hex 
def encode(hex, digit)
    hex = hex.delete_prefix("#")
    if (0..5) === hex[-1].to_i
        hex[-1] = (hex[-1].to_i + digit.to_i).to_s
        return hex
    else 
        return hex
    end
end

# Test to see if encode works as expected
# puts encode("#f57841", 1)


def decode(hex) 
    hex = hex.delete_prefix("#")
    if (0..1) === hex[-1].to_i
        return hex[-1]
    else
        return
    end
end

# # path = "ruby_icon.png"
# # if File.extname(path) == ".png"
# #     puts "Woohoo"
# # end

# # def hide(message)
# #     delimiter = '1111111111111110'
#     puts "Enter image path"
#     path = gets.chomp
#     if File.extname(path) == ".png"
#         img = ChunkyPNG::Image.from_blob(File.read(path))
#         puts img.pixels.count
#         # Writes an image to newfile.png.
#         # File.open("hidden_#{path}", 'wb') { |io| image.write(io) }
#         # binary_string = image.to_blob

        
#     else
#         exit
#     end
# #     binary = str2bin(message) + delimiter

# # end

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


# Test to see if get_pixel_data works as expected
# image = ChunkyPNG::Image.from_file('r_tiny.png')
# p get_pixel_data(image)

def hide(message)
    delimiter = '1111111111111110'
    binary_message = str2bin(message) + delimiter

    puts "Enter image path"
    path = gets.chomp
    if File.extname(path) == ".png"
        img = ChunkyPNG::Image.from_file(path)
        old_data = get_pixel_data(img)

        # all of our new pixel data
        new_data = []
        # the current place we are up to in our binary
        binary_message_index = 0
        temp = ''

        # for each pixel in old_data
        old_data.each do |pixel|
            # if binary_message_index is less than the length of the binary then try and story data
            if binary_message_index < binary_message.length
                # encode new pixels 
                new_pixel = encode(rgb2hex(pixel), binary_message[binary_message_index])
                new_data << hex2rgb(new_pixel)
                binary_message_index += 1
            else
                new_data << pixel
            end
        end

        # p new_data[0][0]
        new_img = create_image_with_pixel(new_data, img)
        new_img.save("hd_#{path}")
    end
end

hide("hi")