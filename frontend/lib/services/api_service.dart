import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/optimization_model.dart';

class ApiService {
  static late String _baseUrl;

  static void init(String baseUrl) {
    _baseUrl = baseUrl;
  }

  static Future<OptimizationResponse> optimize({
    required String fonction,
    required String typeOptimization,
    String? contrainte,
  }) async {
    try {
      final request = OptimizationRequest(
        fonction: fonction,
        typeOptimization: typeOptimization,
        contrainte: contrainte,
      );

      final response = await http.post(
        Uri.parse('$_baseUrl/optimize'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw Exception('Timeout - vérifiez votre connexion'),
      );

      if (response.statusCode == 200) {
        return OptimizationResponse.fromJson(
          jsonDecode(response.body),
        );
      } else {
        throw Exception(
          'Erreur serveur: ${response.statusCode}',
        );
      }
    } catch (e) {
      return OptimizationResponse(
        success: false,
        pointsCritiques: [],
        classification: '',
        message: 'Erreur: $e',
        details: {},
      );
    }
  }

  static Future<bool> checkHealth() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/health'))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
