<?php
session_start();
require_once 'config.php';

if (isset($_POST['submit'])) {
    $nom = htmlspecialchars($_POST['nom']);
    $prenom = htmlspecialchars($_POST['prenom']);  // Ajouter le prénom
    $email = htmlspecialchars($_POST['email']);
    $phone = htmlspecialchars($_POST['phone']);  // Ajouter le téléphone
    $npi = htmlspecialchars($_POST['npi']);  // Ajouter le téléphone
    $genre = htmlspecialchars($_POST['genre']);  // Ajouter le genre
    $naissance = $_POST['naissance'];  // Ajouter la date de naissance
    $lieu = htmlspecialchars($_POST['lieu']);  // Ajouter le lieu
    $ville = htmlspecialchars($_POST['ville']);  // Ajouter la ville
    $quartier = htmlspecialchars($_POST['quartier']);  // Ajouter le quartier
    $password = $_POST['password'];

    // Vérification du mot de passe confirmé (s'il y en a un)
    if ($password !== $_POST['confirmPassword']) {
        $_SESSION['error'] = "Les mots de passe ne correspondent pas.";
        header('Location: index.php');
        exit();
    }

    // Vérifier si l'email existe déjà
    $check = $pdo->prepare("SELECT id FROM clients WHERE email = ?");
    $check->execute([$email]);

    if ($check->rowCount() > 0) {
        $_SESSION['error'] = "Cet email est déjà utilisé.";
        header('Location: index.php');
        exit();
    }

    // Hachage du mot de passe
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        // Obtention de la date actuelle pour created_at et updated_at
        $currentDateTime = date('Y-m-d H:i:s');

    // Insertion dans la base de données (ajout des nouveaux champs)
    $stmt = $pdo->prepare("INSERT INTO clients (nom, prenom, email,npi, phone, genre, naissance, lieu, ville, quartier, password,created_at, updated_at) 
    VALUES (?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?,?,?)");
    $stmt->execute([$nom, $prenom, $email, $npi, $phone, $genre, $naissance, $lieu, $ville, $quartier, $hashedPassword, $currentDateTime, $currentDateTime]);

    // Sauvegarde dans la session
    $_SESSION['user_nom'] = $nom;
    $_SESSION['user_email'] = $email;

    header('Location: connexion.php');
    exit();
} else {
    header('Location: index.php');
    exit();
}
