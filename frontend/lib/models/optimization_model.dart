class OptimizationRequest {
  final String fonction;
  final String typeOptimization;
  final String? contrainte;

  OptimizationRequest({
    required this.fonction,
    required this.typeOptimization,
    this.contrainte,
  });

  Map<String, dynamic> toJson() {
    return {
      'fonction': fonction,
      'type_optimization': typeOptimization,
      'contrainte': contrainte,
    };
  }
}

class PointCritique {
  final Map<String, dynamic> point;
  final List<double> valeursPropes;
  final String classification;
  final dynamic valeurFonction;
  final dynamic multiplicateurLagrange;

  PointCritique({
    required this.point,
    required this.valeursPropes,
    required this.classification,
    required this.valeurFonction,
    this.multiplicateurLagrange,
  });

  factory PointCritique.fromJson(Map<String, dynamic> json) {
    List<double> vp = [];
    if (json['valeurs_propres'] != null) {
      vp = List<double>.from(
        (json['valeurs_propres'] as List)
            .map((e) => e is double ? e : double.parse(e.toString())),
      );
    }

    return PointCritique(
      point: json['point'] ?? {},
      valeursPropes: vp,
      classification: json['classification'] ?? 'Indéterminé',
      valeurFonction: json['valeur_fonction'],
      multiplicateurLagrange: json['multiplicateur_lagrange'],
    );
  }
}

class OptimizationResponse {
  final bool success;
  final List<PointCritique> pointsCritiques;
  final String classification;
  final String message;
  final Map<String, dynamic> details;

  OptimizationResponse({
    required this.success,
    required this.pointsCritiques,
    required this.classification,
    required this.message,
    required this.details,
  });

  factory OptimizationResponse.fromJson(Map<String, dynamic> json) {
    List<PointCritique> points = [];
    if (json['points_critiques'] != null) {
      points = List<PointCritique>.from(
        (json['points_critiques'] as List)
            .map((p) => PointCritique.fromJson(p)),
      );
    }

    return OptimizationResponse(
      success: json['success'] ?? false,
      pointsCritiques: points,
      classification: json['classification'] ?? '',
      message: json['message'] ?? '',
      details: json['details'] ?? {},
    );
  }
}
