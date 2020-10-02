### Develop an outline of the user interaction and experience for the application.
Your outline must include:
- how the user will find out how to interact with / use each feature
- how the user will interact with / use each feature
- how errors will be handled by the application and displayed to the user

#### Feature 1: Hide message in an image

This feature allows the user to enter hide a message within an image and then save a new image with the message encoded. If the user is unclear on how to use the feature they can use the -h or --help command line argument or select help documentation from the main menu. 

The user is given the option to list all of the png files in the current directory and then they select a png image. Errors are raised if the image is not a .png file (NotPngError) or if the file does not exist (FileMissing) and the user is prompted to retry.  The user provides a message they want to hide. If there are more bits in the message (when converted to binary) than there are pixels in the image the error MessageTooBig is raised and the user is taken back to the main menu. The new image is then created and the user gives the filepath to where they want to save the new image. If user enters does not enter a .png filepath the NotPngError error is raised and the user is prompted to retry.



#### Feature 2: Find message in an image