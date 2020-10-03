

### Develop an outline of the user interaction and experience for the application.
Your outline must include:
- how the user will find out how to interact with / use each feature
- how the user will interact with / use each feature
- how errors will be handled by the application and displayed to the user

## User interaction and experience

### Feature 1: Hide message in an image

This feature allows the user to enter hide a message within an image and then save a new image with the message encoded. If the user is unclear on how to use the feature they can use the -h or --help command line argument or select help documentation from the main menu. 

The user is given the option to list all of the png files in the current directory and then they select a png image. Errors are raised if the image is not a .png file (NotPngError) or if the file does not exist (FileMissing) and the user is prompted to retry.  The user provides a message they want to hide. If there are more bits in the message (when converted to binary) than there are pixels in the image the error MessageTooBig is raised and the user is taken back to the main menu. The new image is then created and the user gives the filepath to where they want to save the new image. If user enters does not enter a .png filepath the NotPngError error is raised and the user is prompted to retry. If the image is successfully created a success message with the file path is printed on the screen and the user is returned to the main menu. 


### Feature 2: Find message in an image

This feature allows the user to select an image and find if there is a secret message in the image. If the user is unclear on how to use the feature they can use the -h or --help command line argument or select help documentation from the main menu.

The user is given the option to list all of the png files in the current directory and then they select the png image that they would like to search for a hidden message. Errors are raised if the image is not a .png file (NotPngError) or if the file does not exist (FileMissing) and the user is prompted to retry.

If a secret message is found it is printed to the screen and the user is given the option to save the message to a text file, if they select no they are returned to the main menu. If they do want to save they input a filepath for the text file and the message is written to the file. A success message with the filepath is printed to the screen and the user is returned to the main menu. If no message is found the user is informed and the user is then returned to the main menu.

### Feature 3: Conversion Tools

The conversion tools feature allows the user to select from four different tools for conversion. After every conversion the user is asked if they would like to do another conversion, if not they are returned to the main menu.


If the user selects "String to Binary" they will be prompted to enter a string message. The message is converted to binary and printed out on the screen. The binary is in a readable format as a space is inserted between every 8 bits. An error is raised if the message is too long and the user will need to type in a smaller string. 


If the user selects "Binary to String" they will be prompted to enter a binary value. The binary is converted to ASCII text and the text is printed on the screen. An error is raised if the users input is not in binary format and they will be reminded to input only '1's and '0's. 


If the user selects "Hexadecimal to RGB" they will be prompted to enter a hexadecimal value. The function is able to handle shorthand hex values like #DEA as well as full values. Prefixes of # and 0x are acceptable. However if accessed via command line the '#' character is unable to be passed as an argument. The value is converted to RGB and is printed on to the screen. If the hex value is not a legitimate value an error is raised and the user is prompted to enter a valid hex value. 


If the user selects "RGB to Hexadecimal" they are prompted to enter values for red, green and blue. The function converts this to a hexadecimal value which is printed on the screen. If any of the values are outside the range 0 - 255 an error is raised and the user is prompted to input values within that range. 

