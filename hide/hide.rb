require 'chunky_png'

def rgb2hex(rgb)
    hex = "#{rgb[0].to_s(16)}#{rgb[1].to_s(16)}#{rgb[2].to_s(16)}"
    return hex
end

# puts rgb2hex([245, 120, 65])

#{g.to_i(16)}#{b.to_i(16)}

def hex2rgb (hex)
    hex = hex.delete_prefix("#")
    r = hex[0..1].to_i(16)
    g = hex[2..3].to_i(16)
    b = hex[4..5].to_i(16)

    rgb = [r, g, b]
    return rgb
end

# p hex2rgb(rgb2hex([245, 120, 64]))


# https://blog.anidear.com/2011/11/convert-string-to-binary-in-ruby.html

def str2bin(message)
    binary = message.unpack("B*")[0]
    # if binary.length % 8 == 0
    #     padding = binary.length + (binary.length % 8)
    #     binary.rjust(padding, "0")
    # end
    return binary
end

# puts str2bin("Hello worl") 
# puts str2bin("Hello worl").length

def bin2str(binary)
    str = [binary].pack("B*")
    return str
end

# puts bin2str(str2bin("Hello worl"))

# https://stackoverflow.com/questions/3505475/check-if-an-integer-is-within-a-range/18599494 

def encode(hex, digit)
    hex = hex.delete_prefix("#")
    if (0..5) === hex[-1].to_i
        hex[-1] = (hex[-1].to_i + digit).to_s
        return hex
    else 
        return
    end
end

# puts encode("#f57841", 1)

def decode(hex) 
    hex = hex.delete_prefix("#")
    if (0..1) === hex[-1].to_i
        return hex[-1]
    else
        return
    end
end

# path = "ruby_icon.png"
# if File.extname(path) == ".png"
#     puts "Woohoo"
# end

# def hide(message)
#     delimiter = '1111111111111110'
    puts "Enter image path"
    path = gets.chomp
    if File.extname(path) == ".png"
        img = ChunkyPNG::Image.from_blob(File.read(path))
        puts img.pixels.count
        # Writes an image to newfile.png.
        # File.open("hidden_#{path}", 'wb') { |io| image.write(io) }
        # binary_string = image.to_blob

        
    else
        exit
    end
#     binary = str2bin(message) + delimiter

# end

# ChunkyPNG::Color.rgba
