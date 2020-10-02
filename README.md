# SteggyHide

## Purpose and Scope

### What does it do?
SteggyHide is a terminal app that handles image based steganography. It can hide a user written message inside an png image, it can read a hidden message from a user selected image. SteggyHide also has a tutorial for users to learn about steganography. 

### Why make it? 
Secrets can be fun and SteggyHide allows a user to create secrets to share, read secrets that they've been sent. It also allows the user to have an introduction to steganography. Making it has been an exercise in learning. There have been many frustrations but also a similar level of wins and my knowledge of ruby and programming has increased significantly by creating this application.   

### Who is the audience? 
The audience is primarily for groups of friends who want to show off something cool to each other and share in a bit of fun. Curious learners will also find it useful to discover steganography, something that they may not have even been aware of. 

### How is it used? 
A user will start the application in the terminal and they can pass in options as command line arguments. Command line options  Once the application has started they will be presented with an options menu.

### Overall Scope
The scope of SteggyHide is limited and this is due to time constraints and current knowledge constraints. It can only handle PNG image files and secret messages can only be found if they were previously encoded by SteggyHide. The encoding method is very inelegant and unrefined. In future versions I would like to implement different methods of encoding, ability to handle most image types, ability to decode from externally encoded images. 

---

## Features

### Feature 1: **Hide message in an image**
This feature allows the user to hide a message within an image and then save a new image with the message encoded. The application can only handle .png image files as the ChunkyPNG gem is used to handle image functions. Errors are handled if the wrong filetype is used, if the image file does not exist or if the message is too large to hide in the chosen image. 


### Feature 2: **Find message in an image**
This feature allows the user to find a message within an image and then gives the user the option to save the message in a text file. If no message is found the user is informed. In the current version SteggyHide is only able to find messages that have been hidden using SteggyHide. If there is a hidden message that was encoded by another method, they will not be found by SteggyHide. 

### Feature 3: Learn about steganography

---

## User interaction and experience

### Feature 1: **Hide message in an image**

This feature allows the user to enter hide a message within an image and then save a new image with the message encoded. If the user is unclear on how to use the feature they can use the -h or --help command line argument or select help documentation from the main menu. 

The user is given the option to list all of the png files in the current directory and then they select a png image. Errors are raised if the image is not a .png file (NotPngError) or if the file does not exist (FileMissing) and the user is prompted to retry.  The user provides a message they want to hide. If there are more bits in the message (when converted to binary) than there are pixels in the image the error MessageTooBig is raised and the user is taken back to the main menu. The new image is then created and the user gives the filepath to where they want to save the new image. If user enters does not enter a .png filepath the NotPngError error is raised and the user is prompted to retry. If the image is successfully created a success message with the file path is printed on the screen and the user is returned to the main menu. 


### Feature 2: **Find message in an image**

This feature allows the user to select an image and find if there is a secret message in the image. If the user is unclear on how to use the feature they can use the -h or --help command line argument or select help documentation from the main menu.

The user is given the option to list all of the png files in the current directory and then they select the png image that they would like to search for a hidden message. Errors are raised if the image is not a .png file (NotPngError) or if the file does not exist (FileMissing) and the user is prompted to retry.

If a secret message is found it is printed to the screen and the user is given the option to save the message to a text file, if they select no they are returned to the main menu. If they do want to save they input a filepath for the text file and the message is written to the file. A success message with the filepath is printed to the screen and the user is returned to the main menu. If no message is found the user is informed and the user is then returned to the main menu.


### Feature 3: 


