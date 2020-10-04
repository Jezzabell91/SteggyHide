
require_relative '../methods/steg_methods.rb'

# Testing methodology. I am testing the primary methods for the find feature.
# To do this I have brought in a modified  method, find_test, which removes
# any return_to_menu calls, and replaces the write_to_file call with the line
# File.write("#{path[0..-5]}.txt", message) 

# I also have a modified find_feature method, find_feature_test 
# so that it directly takes a path variable when called
# that way the test does not rely on user input
# I have also added in error handling for: 
#   raise NotPngError unless path[-4..-1] == ".png"
#   raise FileMissing unless File.exist?(path)
# because these errors are normally checked in the get_filepath call 
# It calls find_test and checks to see if it finds a message 
# If it does it prints Success, if it fails it prints Fail

# I am then running a series of tests to see if it is working as intended.
# Tests include:
# Message not found
# Selecting a non .png file 
# Selecting a .png file that does not exist
# Message is hidden in image



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
            puts "Message reads: #{message}"
            File.write("#{path[0..-5]}.txt", message)
            return
        end
    end

    puts error_style("Message was not found or was unable to be recovered")

end

def find_feature_test(path)
    File.delete("#{path[0..-5]}.txt") if File.exist?("#{path[0..-5]}.txt")
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
puts "Testing The Find Feature"

# Message not found
# Expected outcome: Fail 
# => "Message was not found or was unable to be recovered"
puts "\nNo message test"
find_feature_test("no_message_test.png")

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

# Message is hidden in image
# Expected outcome: Success
# => "Created ../test_test.png"
puts "\nFind message in an image known to have a hidden message"
find_feature_test("hidden_message_test.png")
