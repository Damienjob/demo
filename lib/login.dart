import 'package:assurzenmobile/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:status_alert/status_alert.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  final Dio _dio = Dio();

  // Fonction pour gérer la connexion
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      if (_phoneController.text.isEmpty || _passwordController.text.isEmpty) {
        StatusAlert.show(
          context,
          duration: Duration(seconds: 2),
          title: 'Erreur',
          subtitle: 'Veuillez remplir tous les champs',
          configuration: IconConfiguration(icon: Icons.error),
          maxWidth: 260,
        );
        return;
      }
      setState(() {
        _isLoading = true;
      });

      try {
        // Configuration de Dio avec les en-têtes requis
        _dio.options.headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };

        // Remplacer avec votre URL d'API
        final response = await _dio.post(
          'https://assurzendemo.itsmbenin.com/api/loginclient',
          data: {
            'phone': _phoneController.text,
            'password': _passwordController.text,
          },
        );
        print("Réponse : ${response.data}");

        setState(() {
          _isLoading = false;
        });

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Stockage du token et des informations utilisateur si nécessaire
          String token = response.data['token'];
          print("token : $token");

          // Stockage du token dans SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          // Ou ajoutez le token directement aux headers de Dio
          _dio.options.headers['Authorization'] = 'Bearer $token';

          // Affichage du message de succès
          StatusAlert.show(
            context,
            duration: Duration(seconds: 1),
            title: 'Succès',
            subtitle: 'Connexion réussie!',
            configuration: IconConfiguration(icon: Icons.check),
            maxWidth: 260,
          );

          // Navigation vers la page d'accueil après le délai
          Future.delayed(Duration(milliseconds: 1200), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          });
        } else {
          // Gestion des erreurs avec code de statut
          throw DioException(
            requestOptions: RequestOptions(path: ''),
            response: response,
            type: DioExceptionType.badResponse,
          );
        }
      } on DioException catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Gestion des erreurs de l'API
        String errorMessage = 'Erreur de connexion';

        if (e.response != null) {
          // Le serveur a répondu avec un statut d'erreur
          errorMessage =
              'Erreur: ${e.response?.statusCode} - ${e.response?.statusMessage}';

          // Si l'API renvoie un message d'erreur spécifique
          if (e.response?.data != null && e.response?.data['message'] != null) {
            errorMessage = e.response?.data['message'];
          }
        } else if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = "Délai d'attente dépassé";
        } else if (e.type == DioExceptionType.cancel) {
          errorMessage = 'Requête annulée';
        } else {
          errorMessage = 'Erreur réseau: ${e.message}';
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
        StatusAlert.show(
          context,
          duration: Duration(seconds: 2),
          title: 'Erreur',
          subtitle: errorMessage,
          configuration: IconConfiguration(icon: Icons.error),
          maxWidth: 260,
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur inattendue: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeInUp(
                        duration: Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1200),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1300),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1600),
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "Connexion",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 55),
                    FadeInUp(
                      duration: Duration(milliseconds: 1800),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromRGBO(143, 148, 251, 1),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Téléphone",
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre numéro de téléphone';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: !_obscurePassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Mot de passe",
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre mot de passe';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    FadeInUp(
                      duration: Duration(milliseconds: 1900),
                      child: GestureDetector(
                        onTap: () => _login(),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ],
                            ),
                          ),
                          child: Center(
                            child:
                                _isLoading
                                    ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text(
                                      "Se connecter",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    FadeInUp(
                      duration: Duration(milliseconds: 2000),
                      child: TextButton(
                        onPressed: () {
                          // Fonction pour le mot de passe oublié
                          // Vous pouvez ajouter la navigation vers une page de récupération
                        },
                        child: Text(
                          "Mot de passe oublié?",
                          style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
