require_relative "../main.rb"
require_relative "../methods/steg_methods.rb"

# Testing methodology. I am testing the primary methods for the hide feature.
# To do this I have brought in a modified hide method, hide_test, which removes
# any return_to_menu calls, and replaces the save_image call with the line
# new_img.save("#{path[0..-5] + "_test.png"}")

# I also have a modified hide_feature method, hide_feature_test 
# so that it directly takes a message and path variable when called
# that way the test does not rely on user input
# I have also added in error handling for: 
#   raise NotPngError unless path[-4..-1] == ".png"
#   raise FileMissing unless File.exist?(path)
# because these errors are normally checked in the get_filepath call 
# It calls hide_test and checks to see if it creates an image
# If it does it prints Success, if it fails it prints Fail

# I am then running a series of tests to see if it is working as intended.
# Tests include:
# Using a message that is too big
# Selecting a non .png file 
# Selecting a .png file that does not exist
# Message is correct size and selecting .png file that exists




def hide_test(message, path)
    delimiter = '1111111111111110'
    binary_message = str2bin(message) + delimiter
    begin
        raise NotPngError unless path[-4..-1] == ".png"
        raise FileMissing unless File.exist?(path)
        rescue NotPngError, FileMissing => e
        puts error_style(e.message)
        return
    end

    img = ChunkyPNG::Image.from_file(path)
    old_data = get_pixel_data(img)
    begin
        raise MessageTooBig unless binary_message.length < old_data.length
        rescue MessageTooBig => e
            puts error_style(e.message)
            return
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
    new_img.save("#{path[0..-5] + "_test.png"}")
end


def hide_feature_test(message, path)
    File.delete("#{path[0..-5] + "_test.png"}") if File.exist?("#{path[0..-5] + "_test.png"}")
    hide_test(message, path)
    if File.exist?("#{path[0..-5] + "_test.png"}")
        puts success_style("Created #{path[0..-5] + "_test.png"}")
        puts "Success"
    else
        puts "Fail"
    end
end

# Test Cases
system "clear"
puts "Testing Hide Feature"

# Message too big to hide in image
# Expected outcome: Fail 
# => "The size of the message exceeds the number of pixels"
puts "\nMessage too big to hide in image"
hide_feature_test("thismessageiswaytoobigforsuchatinyimage", "../test.png")

# Selecting a non .png file
# Expected outcome: Fail 
# => "File is not .png filetype"
puts "\nSelecting a non .png file"
hide_feature_test("test", "../test.txt")

# Selecting a .png file that doesn't exist
# Expected outcome: Fail 
# => "File not found, sorry"
puts "\nSelecting a .png file that doesn't exist"
hide_feature_test("test", "missing.png")

# Message is correct size and selecting .png file that exists
# Expected outcome: Success
# => "Created ../test_test.png"
puts "\nMessage is correct size and selecting .png file that exists"
hide_feature_test("test", "../test.png")

