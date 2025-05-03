import 'login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Importer Lottie

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Délais pour passer à la page de connexion après l'animation
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(143, 148, 251, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animation Lottie des pièces tombant dans un porte-monnaie
            ClipRRect(
              borderRadius: BorderRadius.circular(50), // rayon des coins
              child: Image.asset(
                'assets/images/finance.png',
                width: 400,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),

            Text(
              "Épargne & Sécurité",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Anticipez l'avenir, sécurisez votre assurance aujourd'hui !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 30),

            // Ajout d'une animation de chargement
            Lottie.asset(
              'assets/bNY75Xd88J.json', // Animation de chargement
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
