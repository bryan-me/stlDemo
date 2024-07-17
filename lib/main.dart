import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'flutter_api_demo_app.dart';


void main() {
   FlavorConfig(
        name: "DEV",
        color: Colors.red,
        location: BannerLocation.bottomStart,
        variables: {
            "baseApiUrl": "http://localhost:8080",
            // "baseKeycloakUrl": "http://localhost:8081",
            "baseKeycloakUrl": "http://192.168.250.209:8070",
        },
    );
  
  runApp(FlutterApiDemoApp());
}


// import 'package:flutter/material.dart';
// import 'package:gui/services/rest_api_service.dart';
// import 'package:gui/services/session_storage_service.dart';
// import 'package:gui/flutter_api_demo_app.dart'; // Replace with your actual app's main widget

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize necessary services asynchronously before building the app
//       future: initializeServices(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return MaterialApp(
//             home: Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return MaterialApp(
//             home: Scaffold(
//               body: Center(
//                 child: Text('Error initializing app: ${snapshot.error}'),
//               ),
//             ),
//           );
//         } else {
//           // If services are initialized successfully, build your app
//           return FlutterApiDemoApp(); // Replace with your actual app's main widget
//         }
//       },
//     );
//   }

//   Future<void> initializeServices() async {
//     await SessionStorageService.getInstance(); // Initialize session storage
//     await RestApiService.getInstance(); // Initialize API service
//   }
// }