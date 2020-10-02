require_relative "../main.rb"
require_relative "../methods/steg_methods.rb"

# Testing methodology. I am testing the primary methods for the find feature.
# To do this I have brought in a modified  method, find_test, which removes
# any return_to_menu calls, and replaces the save_image call with the line
# new_img.save("#{path[0..-5] + "_test.png"}")

# I also have a modified find_feature method, find_feature_test 
# so that it directly takes a message and path variable when called
# that way the test does not rely on user input
# I have also added in error handling for: 
#   raise NotPngError unless path[-4..-1] == ".png"
#   raise FileMissing unless File.exist?(path)
# because these errors are normally checked in the get_filepath call 
# It calls find_test and checks to see if it creates an image
# If it does it prints Success, if it fails it prints Fail

# I am then running a series of tests to see if it is working as intended.
# Tests include:
# Using a message that is too big
# Selecting a non .png file 
# Selecting a .png file that does not exist
# Message is correct size and selecting .png file that exists



def find_test(path)

    begin
        raise NotPngError unless path[-4..-1] == ".png"
        raise FileMissing unless File.exist?(path)
        rescue NotPngError, FileMissing => e
        puts error_style(e.message)
        return
    end

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
            puts "Message reads: #{message}"
            File.write("#{path[0..-5]}.txt", bin2str(binary_message))
            return 
        end
    end

    return "Message was not found or was unable to be recovered"

end

def find_feature_test(path)
    find_test(path)

    if File.exist?("#{path[0..-5]}.txt")
        puts success_style("Created #{path[0..-5]}.txt")
        puts "Success"
    else
        puts "Fail"
    end
end



# Test Cases
system "clear"
puts "Testing find Feature"

# Message too big to find in image
# Expected outcome: Fail 
# => "The size of the message exceeds the number of pixels"
puts "\nMessage too big to find in image"
find_feature_test("test.png")

# Selecting a non .png file
# Expected outcome: Fail 
# => "File is not .png filetype"
puts "\nSelecting a non .png file"
find_feature_test("test.txt")

# Selecting a .png file that doesn't exist
# Expected outcome: Fail 
# => "File not found, sorry"
puts "\nSelecting a .png file that doesn't exist"
find_feature_test("missing.png")

# Message is correct size and selecting .png file that exists
# Expected outcome: Success
# => "Created ../test_test.png"
puts "\nMessage is correct size and selecting .png file that exists"
find_feature_test("test", "../test.png")
