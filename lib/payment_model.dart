class ApiResponse {
  final bool success;
  final String message;
  final List<PaymentData> data;

  ApiResponse({
    required this.success, 
    required this.message, 
    required this.data
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    // Vérifier si les données existent et sont dans le format attendu
    if (json.containsKey('Assurance') && json['Assurance'] is List) {
      List<dynamic> assurances = json['Assurance'];
      List<PaymentData> payments = [];
      
      // Pour chaque assurance, extraire les paiements (epargnes)
      for (var assurance in assurances) {
        if (assurance['epargnes'] != null && assurance['epargnes'] is List) {
          for (var epargne in assurance['epargnes']) {
            // Convertir chaque épargne en PaymentData
            payments.add(PaymentData.fromEpargne(epargne));
          }
        }
      }
      
      // Retourner une réponse réussie avec les données
      return ApiResponse(
        success: true,
        message: 'Données récupérées avec succès',
        data: payments,
      );
    }
    
    // Si le format est différent, retourner une réponse vide
    return ApiResponse(
      success: false,
      message: 'Format de données incorrect',
      data: [],
    );
  }
}

class PaymentData {
  final int id;
  final int assuranceId;
  final String montant;
  final String datePaiement;
  final String statuts;

  PaymentData({
    required this.id,
    required this.assuranceId,
    required this.montant,
    required this.datePaiement,
    required this.statuts,
  });

  // Conversion de l'objet epargne JSON en objet PaymentData
  factory PaymentData.fromEpargne(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'],
      assuranceId: json['assurance_id'],
      montant: json['montant'],
      datePaiement: json['date_paiement'],
      statuts: json['statuts'],
    );
  }

  // Conversion en Map pour l'affichage dans le Dashboard
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': '$montant FCFA',
      'date': datePaiement,
      'status': statuts == 'en Attente' ? 'En attente' : statuts,
    };
  }
}