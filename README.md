This repository is a module for the authorization system in a Flutter application with a backend connection created in Node.js. MongoDB is used for this project. After changing the appropriate addresses, this module can be deployed on a backend server. The code includes:

sending a verification message to the provided address (if the address is incorrect, the user can re-enter the registration data, and the provided address is not blocked). After clicking the link in the message, the user is verified, and logging in succeeds.

logging in with access and refresh tokens (the token is valid for one hour and is refreshed after expiration).

checking the authorization status (if the user closes the application but wants to return to it, they do not have to log in again).

logging out.

the application state is managed using a BLoC. The BLoC returns the authorization status along with a 'user' object containing user information.

routing between screens in the application is handled by go_router, which depends on the change in authorization status in the BLoC. The user will not pass through the "wall" to home if the user's authorization status does not change.

The frontend (Flutter) and backend (Node.js) are written according to clean architecture principles.