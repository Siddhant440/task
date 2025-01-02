# task
 
My Flutter App is a user-friendly task management tool that allows users to add, view, and delete items in a list, securely stored on a Firebase server. Users can sign up and log in with their email and password, ensuring data privacy and easy access. The Home Screen displays the item list and features options to add or delete items, as well as a profile icon for quick navigation to the Profile Screen. The Profile Screen shows the user's email and includes a logout button for secure sign-out. Built with Flutter and using state management solutions like provider and flutter_riverpod, the app ensures a smooth, and a responsive experience.

**Built With**
Flutter - The framework used

Dart - The programming language used

**Notes on Used Packages**
go_router: ^14.2.1 - Used for handling routing in your Flutter app.

provider: ^6.1.2 - A dependency injection and state management solution.

cloud_firestore: ^4.13.6 - A Cloud Firestore plugin for Flutter.

firebase_core: ^2.27.0 - Core functionalities for Firebase integration.

firebase_auth: ^4.17.8 - For Firebase Authentication.

firebase_storage: ^11.6.9 - To work with Firebase Cloud Storage.

flutter_riverpod: ^2.0.0 - A complete rewrite of the provider package for state management.

**Screens and How They Work**

## Login Screen
Functionality: Allows users to log in with their email and password.

Implementation: Utilizes firebase_auth to authenticate users and flutter_riverpod to manage the login state and carry the user email throughout the app.

## Signup Screen
Functionality: Allows new users to create an account by providing their name, email, password, and confirm password.

Implementation: Uses firebase_auth for creating new user accounts and provider for state management.

## Home Screen
Functionality: Displays a list of items saved by the user with options to add and delete items from the list. Also has a profile icon button on the top right corner that navigates to the profile screen.

Implementation: Fetches data from cloud_firestore and displays it in a list format using custom widgets. The profile button uses go_router to navigate to the profile screen.

## Item Detail Screen
Functionality: Shows detailed information about a selected item from the list.

Implementation: Retrieves item details from cloud_firestore and displays them using custom widgets. Provides options to edit or delete the item.

## Profile Screen
Functionality: Displays the email of the logged-in user and includes a logout button on the top right corner.

Implementation: Fetches user data from cloud_firestore and displays it. The logout button uses firebase_auth to sign out the user.
