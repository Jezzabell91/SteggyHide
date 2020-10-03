require 'pastel'
require 'tty-font'
require_relative 'methods/steg_methods'

def print_help
    font = TTY::Font.new(:standard)
    pastel = Pastel.new
    puts pastel.cyan(font.write("HELP"))

    puts "Instructions on how to use each feature: "

    puts "\nHide a message".upcase

    puts "\n\t1. If you're not sure what images are in your directory use the prompt to list images"

    puts "\n\t2. Select a png image by entering the filepath. If the filepath does not end in .png\n\t   or if the file does not exist in the directory an error will occur and you will\n\t   be given the option to retry or exit back to the main menu."

    puts "\n\t3. Enter a message that you want to hide. If the message is too large\n\t   to be hidden in the chosen image an error will occur and you will be taken back to the main menu."

    puts "\n\t4. SteggyHide now does it's thing and encodes the message in the image"

    puts "\n\t5. Finally, enter the filepath for the new image which has the secret message hidden inside.\n\t   If the filepath does not end in .png an error will occur and you will be given the option to retry."

    puts "\nFind a message".upcase

    puts "\n\t1. If you're not sure what images are in your directory use the prompt to list images"

    puts "\n\t2. Select a png image by entering the filepath. If the filepath does not end in .png\n\t   or if the file does not exist in the directory an error will occur and you will\n\t   be given the option to retry or exit back to the main menu."

    puts "\n\t3. SteggyHide now does it's thing and if there is a hidden message it will decode the message"

    puts "\n\t3. If you want to save the message in a text file input the filepath where you want to save"

    puts "\nConversion Tools".upcase

    puts "\n\tSelect which conversion tool you would like to use from the list"

    puts "\n\t1. Convert from string to binary - Enter a string, just make sure it isn't too long."

    puts "\n\t2. Convert from binary to string - Enter the binary and make sure there's only '1's and '0's."

    puts "\n\t3. Convert from hexadecimal to RGB - Enter a hexadecimal value with at least 3 digits.\n\t   Can use common formats including hex numbers prefixed with 0x and # "

    puts "\n\t4. Convert from RGB to hexadecimal - Enter values for Red, Green and Blue. Numbers must be between 0 and 255."

    puts "\n"
    
    return_to_menu?
end 
