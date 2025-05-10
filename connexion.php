<?php
// Démarrer la session PHP
session_start();

if (isset($_SESSION['user_id'])) {
    header('Location: index.php');
    exit;
}
// Point d'entrée pour stocker les données de session (appelé après authentification réussie côté client)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
    // Récupérer les données JSON envoyées
    $jsonData = file_get_contents('php://input');
    $userData = json_decode($jsonData, true);
    
    if (isset($userData['action']) && $userData['action'] === 'saveSession' && isset($userData['userData'])) {
        // Vérifier que les données requises sont présentes
        if (isset($userData['userData']['id']) && isset($userData['userData']['phone'])) {
           
            $_SESSION['logged_in'] = true;
            
            
            // Renvoyer une réponse positive
            header('Content-Type: application/json');
            echo json_encode([
                'success' => true,
                'message' => 'Session enregistrée avec succès'
            ]);
            exit;
        }
    }
    
    // En cas de données invalides
    header('Content-Type: application/json');
    echo json_encode([
        'success' => false,
        'message' => 'Données de session invalides'
    ]);
    exit;
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Connexion Premium avec sessions</title>
  <!-- Importation de SweetAlert2 -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }

    body {
      background: #0d6efd; /* Couleur bg-primary de Bootstrap */
      height: 100vh;
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .background {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -1;
    }

    .particle {
      position: absolute;
      border-radius: 50%;
      background-color: rgba(255, 255, 255, 0.3);
      pointer-events: none;
    }

    .container {
      width: 400px;
      backdrop-filter: blur(16px);
      background: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 20px;
      box-shadow: 0 25px 45px rgba(0, 0, 0, 0.2);
      padding: 40px;
      transform-style: preserve-3d;
      perspective: 1000px;
      transform: translateZ(0);
      animation: float 6s ease-in-out infinite;
    }

    @keyframes float {
      0%, 100% {
        transform: translateY(0px);
      }
      50% {
        transform: translateY(-15px);
      }
    }

    .logo {
      text-align: center;
      margin-bottom: 30px;
    }

    .logo svg {
      width: 80px;
      height: 80px;
      fill: #fff;
      animation: pulse 3s infinite;
    }

    @keyframes pulse {
      0% {
        transform: scale(1);
        opacity: 1;
      }
      50% {
        transform: scale(1.1);
        opacity: 0.8;
      }
      100% {
        transform: scale(1);
        opacity: 1;
      }
    }

    h2 {
      color: #fff;
      text-align: center;
      font-size: 24px;
      margin-bottom: 30px;
      font-weight: 600;
      letter-spacing: 1px;
      text-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
    }

    .input-group {
      position: relative;
      margin-bottom: 25px;
    }

    input {
      width: 100%;
      padding: 15px 20px;
      background: rgba(255, 255, 255, 0.1);
      border: none;
      outline: none;
      border-radius: 35px;
      font-size: 16px;
      color: #fff;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
      transition: all 0.3s;
    }

    input::placeholder {
      color: rgba(255, 255, 255, 0.7);
    }

    input:focus {
      background: rgba(255, 255, 255, 0.15);
      box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
    }

    .input-icon {
      position: absolute;
      top: 50%;
      right: 20px;
      transform: translateY(-50%);
      color: rgba(255, 255, 255, 0.7);
      transition: all 0.3s;
      pointer-events: none;
    }

    input:focus + .input-icon {
      color: #fff;
    }

    .btn {
      position: relative;
      width: 100%;
      padding: 15px 0;
      background: #0d6efd; /* Couleur bg-primary de Bootstrap */
      border: none;
      outline: none;
      border-radius: 35px;
      color: #fff;
      font-size: 18px;
      font-weight: 600;
      letter-spacing: 1px;
      cursor: pointer;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
      transition: all 0.3s;
      overflow: hidden;
    }

    .btn:hover {
      transform: translateY(-5px);
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    }

    .btn:active {
      transform: translateY(2px);
    }

    .btn::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: all 0.3s;
    }

    .btn:hover::before {
      left: 100%;
      transition: 0.5s;
    }
  </style>
</head>
<body>
  <div class="background" id="background"></div>

  <div class="container">
    <div class="logo">
      <svg viewBox="0 0 24 24">
        <path d="M12,2A10,10 0 0,1 22,12A10,10 0 0,1 12,22A10,10 0 0,1 2,12A10,10 0 0,1 12,2M12,4A8,8 0 0,0 4,12C4,14.4 5,16.5 6.7,18C8.1,16.7 10,16 12,16C14,16 15.9,16.7 17.3,18C19,16.5 20,14.4 20,12A8,8 0 0,0 12,4M12,6A3,3 0 0,1 15,9A3,3 0 0,1 12,12A3,3 0 0,1 9,9A3,3 0 0,1 12,6M12,8A1,1 0 0,0 11,9A1,1 0 0,0 12,10A1,1 0 0,0 13,9A1,1 0 0,0 12,8Z" />
      </svg>
    </div>

    <h2>Connectez-vous à votre espace</h2>
    
    <form id="loginForm">
      <div class="input-group">
        <input type="tel" name="phone" id="phone" placeholder="Numéro de téléphone" required pattern="[0-9]{10}">
        <div class="input-icon">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
            <path d="M6.62,10.79C8.06,13.62 10.38,15.94 13.21,17.38L15.41,15.18C15.69,14.9 16.08,14.82 16.43,14.93C17.55,15.3 18.75,15.5 20,15.5A1,1 0 0,1 21,16.5V20A1,1 0 0,1 20,21A17,17 0 0,1 3,4A1,1 0 0,1 4,3H7.5A1,1 0 0,1 8.5,4C8.5,5.25 8.7,6.45 9.07,7.57C9.18,7.92 9.1,8.31 8.82,8.59L6.62,10.79Z" />
          </svg>
        </div>
      </div>

      <div class="input-group">
        <input type="password" name="password" id="password" placeholder="Mot de passe" required>
        <div class="input-icon">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
            <path d="M12,17A2,2 0 0,0 14,15C14,13.89 13.1,13 12,13A2,2 0 0,0 10,15A2,2 0 0,0 12,17M18,8A2,2 0 0,1 20,10V20A2,2 0 0,1 18,22H6A2,2 0 0,1 4,20V10C4,8.89 4.9,8 6,8H7V6A5,5 0 0,1 12,1A5,5 0 0,1 17,6V8H18M12,3A3,3 0 0,0 9,6V8H15V6A3,3 0 0,0 12,3Z" />
          </svg>
        </div>
      </div>

      <button type="submit" class="btn">SE CONNECTER</button>

    </form>
  </div>

  <script>
    // Fonctions SweetAlert
    function showLoading() {
      Swal.fire({
        title: 'Connexion en cours...',
        text: 'Veuillez patienter',
        allowOutsideClick: false,
        allowEscapeKey: false,
        showConfirmButton: false,
        didOpen: () => {
          Swal.showLoading();
        },
        background: 'rgba(255, 255, 255, 0.9)',
      });
    }

    function showSuccessMessage(message) {
      Swal.fire({
        icon: 'success',
        title: 'Succès',
        text: message,
        background: 'rgba(255, 255, 255, 0.9)',
        confirmButtonColor: '#0d6efd'
      }).then((result) => {
        if (result.isConfirmed) {
          // Redirection vers la page d'accueil
          window.location.href = 'index.php';
        }
      });
    }

    function showErrorMessage(message) {
      Swal.fire({
        icon: 'error',
        title: 'Erreur',
        text: message,
        background: 'rgba(255, 255, 255, 0.9)',
        confirmButtonColor: '#0d6efd'
      });
    }
    
    // Gestion du formulaire de connexion
    document.getElementById('loginForm').addEventListener('submit', async function (e) {
      e.preventDefault();

      const phone = document.getElementById('phone').value.trim();
      const password = document.getElementById('password').value.trim();

      if (!phone || !password) {
        showErrorMessage('Veuillez remplir tous les champs.');
        return;
      }

      if (!/^\d{10}$/.test(phone)) {
        showErrorMessage('Format de numéro de téléphone invalide. Entrez exactement 10 chiffres.');
        return;
      }

      const userData = { phone, password };
      const apiUrl = 'https://assurzendemo.itsmbenin.com/api/loginclient';

      try {
        showLoading();

        const response = await fetch(apiUrl, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify(userData)
        });

        if (!response.ok) {
          throw new Error(`Erreur HTTP: ${response.status}`);
        }

        const data = await response.json();

        console.log(data.Client);

        if (data.Client && data.token) {
          // ✅ Stocker le token dans localStorage
          localStorage.setItem('auth_token', data.token);

          // (Facultatif) Stocker aussi les infos utilisateur si nécessaire
          localStorage.setItem('user', JSON.stringify(data.user));

          showSuccessMessage('Connexion réussie');
          setTimeout(() => {
            window.location.href = 'index.php';
          }, 1500);
        } else {
          showErrorMessage(data.message || 'Numéro de téléphone ou mot de passe incorrect.');
        }

      } catch (error) {
        console.error('Erreur attrapée :', error);
        showErrorMessage('Une erreur est survenue. Veuillez réessayer.');
      }
    });

    
    // Création des particules pour l'arrière-plan dynamique
    const background = document.getElementById('background');
    
    function createParticles() {
      for (let i = 0; i < 100; i++) {
        const particle = document.createElement('div');
        particle.classList.add('particle');
        
        // Taille aléatoire
        const size = Math.random() * 5 + 1;
        particle.style.width = `${size}px`;
        particle.style.height = `${size}px`;
        
        // Position aléatoire
        const posX = Math.random() * 100;
        const posY = Math.random() * 100;
        particle.style.left = `${posX}%`;
        particle.style.top = `${posY}%`;
        
        // Opacité aléatoire
        particle.style.opacity = Math.random() * 0.5 + 0.2;
        
        // Animation aléatoire
        const duration = Math.random() * 20 + 10;
        const delay = Math.random() * 5;
        
        particle.style.animation = `moveParticle ${duration}s ${delay}s infinite linear`;
        
        // Style pour l'animation
        const keyframes = `
          @keyframes moveParticle {
            0% {
              transform: translate(0, 0);
            }
            50% {
              transform: translate(${Math.random() * 100 - 50}px, ${Math.random() * 100 - 50}px);
            }
            100% {
              transform: translate(0, 0);
            }
          }
        `;
        
        const style = document.createElement('style');
        style.innerHTML = keyframes;
        document.head.appendChild(style);
        
        background.appendChild(particle);
      }
    }
    
    createParticles();
    
    // Effet de focus sur les champs de saisie
    const inputs = document.querySelectorAll('input');
    inputs.forEach(input => {
      input.addEventListener('focus', () => {
        document.querySelectorAll('.input-group').forEach(group => {
          group.classList.remove('active');
        });
        input.parentElement.classList.add('active');
      });
    });
    
    // Animation au survol du bouton
    const btn = document.querySelector('.btn');
    btn.addEventListener('mousemove', (e) => {
      const btnRect = btn.getBoundingClientRect();
      const x = e.clientX - btnRect.left;
      const y = e.clientY - btnRect.top;
      
      btn.style.background = `radial-gradient(circle at ${x}px ${y}px, rgba(255, 255, 255, 0.2), transparent), #0d6efd`;
    });
    
    btn.addEventListener('mouseleave', () => {
      btn.style.background = '#0d6efd';
    });
    
    // Simulation de l'effet 3D
    document.addEventListener('mousemove', (e) => {
      const container = document.querySelector('.container');
      const xAxis = (window.innerWidth / 2 - e.pageX) / 25;
      const yAxis = (window.innerHeight / 2 - e.pageY) / 25;
      
      container.style.transform = `rotateY(${xAxis}deg) rotateX(${yAxis}deg) translateZ(0)`;
    });
    
    // Réinitialisation de la rotation lorsque la souris quitte le document
    document.addEventListener('mouseleave', () => {
      const container = document.querySelector('.container');
      container.style.transform = 'rotateY(0deg) rotateX(0deg) translateZ(0)';
    });
  </script>
</body>
</html>