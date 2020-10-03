## Purpose and Scope

### What does it do?
SteggyHide is a terminal app that handles image based steganography. It can hide a user written message inside an png image, it can read a hidden message from a user selected image. SteggyHide also has four conversion tools if users simply want to do conversions between hexadecimal and RGB color values as well between strings and binary.  

### Why make it? 
Secrets can be fun and SteggyHide allows a user to create secrets to share, read secrets that they've been sent. It also allows the user to have an introduction to steganography and working with hexadecimal and RGB values. Making it has been an exercise in learning. There have been many frustrations but also a similar level of wins and my knowledge of ruby and programming has increased significantly by creating this application.   

### Who is the audience? 
The audience is primarily for groups of friends who want to show off something cool to each other and share in a bit of fun. Curious learners will also find it useful to discover steganography, something that they may not have even been aware of. 

### How is it used? 
A user will start the application in the terminal and they can pass in options as command line arguments. Command line options include %%%%%%%%%% Once the application has started and the user goes past the start page they will be presented with an options menu which will present them with the options to hide a message, find a message, use conversion tools, access help documentation to understand how to use the application and finally an option to exit the application. 

### Overall Scope
The scope of SteggyHide is limited and this is due to time constraints and current knowledge constraints. It can only handle PNG image files and secret messages can only be found if they were previously encoded by SteggyHide. The encoding method is very inelegant and unrefined. In future versions I would like to implement different methods of encoding, ability to handle most image types, ability to decode from externally encoded images. 




