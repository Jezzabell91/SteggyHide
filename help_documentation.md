
### 1. Hide a message

1.  If you're not sure what images are in your directory use the prompt to list images
   
2.  Select a png image by entering the filepath. If the filepath does not end in .png or if the file does not exist in the directory an error will occur and you will be given the option to retry or exit back to the main menu.
    
3.  Enter a message that you want to hide. If the message is too large to be hidden in the chosen image an error will occur and you will be taken back to the main menu.  
   
4.  SteggyHide now does it's thing and encodes the message in the image
   
5.  Finally, enter the filepath for the new image which has the secret message hidden inside. If the filepath does not end in .png an error will occur and you will be given the option to retry.

### 2. Find a message

1.  If you're not sure what images are in your directory use the prompt to list images
   
2.  Select a png image by entering the filepath. If the filepath does not end in .png or if the file does not exist in the directory an error will occur and you will be given the option to retry or exit back to the main menu.
    
3.  SteggyHide now does it's thing and if there is a hidden message it will decode the message  
   
4.  If you want to save the message in a text file input the filepath where you want to save
   
### 3. Conversion Tools

1.  Select which conversion tool you would like to use from the list
   
2.  Convert from string to binary - Enter a string, just make sure it isn't too long.
    
3.  Convert from binary to string - Enter the binary and make sure there's only '1's and '0's.

4.  Convert from hexadecimal to RGB - Enter a hexadecimal value with at least 3 digits. Can use common formats including hex numbers prefixed with 0x and # 
   
5.  Convert from RGB to hexadecimal - Enter values for Red, Green and Blue. Numbers must be between 0 and 255. 
<!-- 

The user selects a png image and the filepath is stored in a variable called path. Errors are raised if the image is not a .png file (NotPngError) or if the file does not exist (FileMissing).  The user provides a message they want to hide and this is stored in a variable called message. The path and message variables are passed to the hide method. The hide method converts the message to a binary string and adds a delimiter. The delimeter is a binary pattern used to tell the method that it has reached end of message. The path variable is passed and a new image instance is created using the ChunkyPNG gem. The pixels in the image are stored in an array called old_data in RGB format. If there are more bits in the binary message than there are pixels in the array the error MessageTooBig is raised and the user is taken back to the main menu. 

Each element of old_data is looped over. If the message hasn't been completely encoded yet a temporary variable called new_pixel is created. The pixel is then encoded by converting it to a hexadecimal string, changing the last character in the hexadecimal string to either "0" or "1", based on the current index of the binary message. The new_pixel is then pushed into an array called new_data which stores the pixel data for the encoded image. The new image is then created, again using ChunkyPNG, and the user gives the filepath to where they want to save the new image.  -->