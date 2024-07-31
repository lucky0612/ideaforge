Ideaforge
Overview
Ideaforge is a Flutter-based application designed to assist users in rapidly prototyping and visualizing their project ideas. It allows users to input prompts and generate detailed responses covering user requirements, technical aspects, and the project lifecycle. Additionally, Ideaforge features APIs that generate dummy UI/UX images based on user input and even create a full, viewable website with downloadable HTML and CSS code.

Features
Prompt-Based Generation: Input prompts and receive detailed responses on user requirements, technical aspects, and lifecycle stages of the project.
UI/UX Design Generation: Input an overview and generate a dummy UI/UX image to visualize the project's interface.
Website Prototyping:
Input project details such as title, overview, color scheme, features, and layout.
Generate a viewable website.
Download the website's HTML and CSS code in a zip format.
APIs Used
User Requirement API:

Takes user prompts and generates responses covering requirements, technical details, and project lifecycle.
UI/UX Image Generation API:

Takes an overview as input and generates a dummy UI/UX image to help visualize the project.
Website Prototyping API:

Takes input such as title, overview, color scheme, features, and layout.
Returns a viewable website.
Provides an option to download the generated website's HTML and CSS code in a zip file.


Dependencies
The project relies on several essential Flutter packages:

webview_flutter: To integrate WebView for displaying web content.
url_launcher: To handle launching URLs in external browsers.
path_provider: To handle file storage and access paths on the device.
http: To handle HTTP requests for API communication and file downloads.
permission_handler: To handle runtime permissions for accessing external storage.
Installation
Prerequisites
Before setting up this project, ensure you have the following installed on your machine:

Flutter SDK
Android Studio or Visual Studio Code with Flutter and Dart extensions.
Git (optional, for cloning the repository)
Setup
Clone the repository:

bash
Copy code
git clone https://github.com/yourusername/ideaforge.git
cd ideaforge
Install dependencies:

Navigate to the project directory and run:

bash
Copy code
flutter pub get
Run the project:

To run the app on an emulator or a connected device, use:

bash
Copy code
flutter run
Permissions
Ensure the following permissions are added to your AndroidManifest.xml:

xml
Copy code
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
These permissions are necessary for the app to access the internet and save files to the device's storage.

Usage
Prompt-Based Generation:

Enter your prompt to receive detailed insights into user requirements, technical aspects, and the project lifecycle.
UI/UX Image Generation:

Input an overview and receive a generated UI/UX image to visualize your project's design.
Website Prototyping:

Input details like title, overview, color scheme, features, and layout.
View the generated website directly in the app.
Download the website's HTML and CSS code in a zip file for further development.
Error Handling:

The app provides feedback for any errors during API communication, file downloads, or URL launching.
Project Structure
lib/screens: Contains the main screen (OutputScreen) and the WebView screen (WebViewScreen).
lib/main.dart: Entry point of the application.
pubspec.yaml: Contains all the dependencies used in the project.
Contributions
Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

License
This project is licensed under the MIT License. See the LICENSE file for more details.

Acknowledgements
Flutter and Dart communities for their excellent documentation and resources.
The maintainers of the packages used in this project.
