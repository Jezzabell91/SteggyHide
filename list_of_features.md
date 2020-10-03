## Features
- at least THREE features
- describe each feature

Note: Ensure that your features above allow you to demonstrate your understanding of the following language elements and concepts:
- use of variables and the concept of variable scope
- loops and conditional control structures
- error handling

### Feature 1: Hide message in an image
This feature allows the user to hide a message within an image and then save a new image with the message encoded. The application can only handle .png image files as the ChunkyPNG gem is used to handle image functions. Errors are handled if the wrong filetype is used, if the image file does not exist or if the message is too large to hide in the chosen image. 


### Feature 2: Find message in an image
This feature allows the user to find a message within an image and then gives the user the option to save the message in a text file. If no message is found the user is informed. In the current version SteggyHide is only able to find messages that have been hidden using SteggyHide. If there is a hidden message that was encoded by another method, they will not be found by SteggyHide. 


### Feature 3: Conversion Tools
This feature allows the user to utilise some of the conversion functions that SteggyHide uses in the other features. This includes converting hexadecimal colors to RGB colors and vice versa, converting binary values to strings and string messages to binary values. Users can use command line arguments to quickly convert hex to rgb (-hex 'hexvalue') and rgb to hex (-rgb 'red' 'green' 'blue'). 