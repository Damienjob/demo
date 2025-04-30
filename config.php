<?php
$host = 'localhost';
$dbname = 'assurzen';
$username = 'root'; // à adapter selon ton environnement
$password = '';     // à adapter aussi

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erreur de connexion : " . $e->getMessage());
}
