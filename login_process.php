<?php
// Démarrer la session PHP
session_start();

// URL de l'API
$api_url = 'https://assurzendemo.itsmbenin.com/api/loginclient';

try {
    // Récupération des données du formulaire
    $phone = isset($_POST['phone']) ? $_POST['phone'] : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';
    
    // Validation des données
    if (empty($phone) || empty($password)) {
        $_SESSION['error'] = "Veuillez remplir tous les champs.";
        header("Location: connexion.php");
        exit();
    }
    
    // Validation du format du numéro de téléphone
    if (!preg_match('/^[0-9]{10}$/', $phone)) {
        $_SESSION['error'] = "Format de numéro de téléphone invalide.";
        header("Location: connexion.php");
        exit();
    }
    
    // Préparation des données pour l'API
    $data = array(
        'phone' => $phone,
        'password' => $password
    );
    
    // Configuration de la requête avec file_get_contents
    $options = array(
        'http' => array(
            'header'  => "Content-type: application/json\r\nAccept: application/json\r\n",
            'method'  => 'POST',
            'content' => json_encode($data)
        )
    );
    
    $context = stream_context_create($options);
    $response = file_get_contents($api_url, false, $context);
    
    // Récupération du code HTTP
    $http_response_header = $http_response_header ?? array('HTTP/1.1 500 Internal Server Error');
    preg_match('/^HTTP\/\d\.\d\s+(\d+)/', $http_response_header[0], $matches);
    $http_code = intval($matches[1]);
    
    // Traitement de la réponse
    $result = json_decode($response, true);
    
    // Vérification de la réponse de l'API
    if ($http_code == 200 && isset($result['success']) && $result['success'] === true) {
        // Authentification réussie, création de la session utilisateur
        $_SESSION['user_id'] = $result['data']['id'];
        $_SESSION['phone'] = $result['data']['phone'];
        $_SESSION['nom'] = $result['data']['nom'] ?? '';
        $_SESSION['prenom'] = $result['data']['prenom'] ?? '';
        console.log($result['data']);
        $_SESSION['logged_in'] = true;
        
        // Stockage éventuel du token d'API si fourni dans la réponse
        if (isset($result['data']['token'])) {
            $_SESSION['api_token'] = $result['data']['token'];
        }
        
        // Ajout du message de succès
        $_SESSION['success'] = "Connexion réussie. Bienvenue !";
        
        // Redirection vers la page d'accueil après connexion
        header("Location: index.php");
        exit();
    } else {
        // Authentification échouée
        $error_message = isset($result['message']) ? $result['message'] : "Numéro de téléphone ou mot de passe incorrect.";
        $_SESSION['error'] = $error_message;
        header("Location: connexion.php");
        exit();
    }
} catch (Exception $e) {
    // Gestion des erreurs générales
    $_SESSION['error'] = "Une erreur est survenue lors de la connexion: " . $e->getMessage();
    header("Location: connexion.php");
    exit();
}
?>