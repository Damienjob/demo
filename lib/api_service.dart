// import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_model.dart';

class ApiService {
  // URL de base de l'API
  static const String baseUrl = 'https://assurzendemo.itsmbenin.com/api';
  
  // Instance de Dio
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Intercepteurs pour le logging des requêtes et réponses (utile pour le débogage)
  static void setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
          return handler.next(e);
        },
      ),
    );
  }
// Méthode pour obtenir le token d'authentification depuis les préférences
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
// Méthode pour ajouter le token d'authentification aux headers
  static Future<Map<String, dynamic>> getAuthHeaders() async {
    final token = await getAuthToken();
    if (token == null || token.isEmpty) {
      throw Exception('Token d\'authentification non trouvé. Veuillez vous reconnecter.');
    }
    
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  // Méthode pour récupérer les paiements d'un client
  static Future<List<PaymentData>> getClientPayments() async {
    try {
      // Configuration des intercepteurs (décommenter pour le débogage)
      // setupInterceptors();
      
      // Récupérer l'ID du client depuis les préférences partagées
      final clientId = '6'; // Utiliser '6' comme valeur par défaut
  
      if (clientId.isEmpty) {
        throw Exception('ID client non trouvé. Veuillez vous reconnecter.');
      }
            // Récupérer le token et créer les headers d'authentification
      final headers = await getAuthHeaders();

      // Faire la requête HTTP avec Dio en incluant les headers d'authentification
      final response = await _dio.get(
        '/getclientassurance/$clientId',
        options: Options(headers: headers),
      );
      // Vérifier le code de statut de la réponse
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parser la réponse JSON
        final jsonResponse = response.data;

        // Utiliser le modèle pour traiter la réponse
        final apiResponse = ApiResponse.fromJson(jsonResponse);

        if (apiResponse.success) {
          return apiResponse.data;
        } else {
          throw Exception(apiResponse.message);
        }
      } else {
        throw Exception(
          'Erreur lors de la récupération des données: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Gérer les erreurs spécifiques à Dio
      String errorMessage;
      
      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Délai de connexion dépassé';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Délai de réception dépassé';
      } else if (e.type == DioExceptionType.badResponse) {
        errorMessage = 'Erreur serveur: ${e.response?.statusCode} - ${e.response?.statusMessage}';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'Erreur de connexion réseau';
      } else {
        errorMessage = 'Erreur inattendue: ${e.message}';
      }
      
      print('Erreur Dio: $errorMessage');
      throw Exception(errorMessage);
    } catch (e) {
      // Gérer les autres erreurs
      print('Erreur API: $e');
      throw Exception('Erreur inattendue: $e');
    }
  }
  
  // Méthode pour l'authentification
  static Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Échec de la connexion: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Identifiants incorrects');
      }
      throw Exception('Erreur de connexion: ${e.message}');
    }
  }
  
  // Méthode pour la déconnexion
  static Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
      return false;
    }
  }
}