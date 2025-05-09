<?php session_start(); ?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta
      name="description"
      content="AssurZen - Épargnez en toute sécurité pour vos assurances et projets importants. Solution digitale fiable et intuitive."
    />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/boxicons.min.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.12/sweetalert2.min.css">

    <link rel="stylesheet" href="css/style.css" />
    <title>AssurZen - Déposit & Assurance Simplifiées</title>
  </head>

  <body data-bs-spy="scroll" data-bs-target=".navbar" data-bs-offset="70">
    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg py-3 sticky-top navbar-light bg-white">
      <div class="container">
        <a class="navbar-brand" href="#">
          <h1 class="logo">AssurZen</h1>
        </a>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
          aria-controls="navbarNav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto">
            <li class="nav-item">
              <a class="nav-link" href="#home">Accueil</a>
            </li>
          </ul>
          <?php if (isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true):?>
          <a
            href="#features"
            class="btn btn-primary ms-lg-3"
            data-bs-toggle="modal"
            data-bs-target="#firstModal"
            >Créer une assurance</a
          >
          <?php else: ?>
          <button
            class="btn btn-primary ms-lg-3"
            data-bs-toggle="modal"
            data-bs-target="#firstModal"
          >
            S'inscrire
          </button>
          <a href="connexion.php"
            class="btn btn-primary ms-lg-3"            
          >
            Se connecter
          </a>
          <?php endif; ?>
        </div>
       
      </div>
    </nav>
    <!-- //NAVBAR -->

    <!-- HERO -->
    <div class="hero vh-100 d-flex align-items-center" id="home">
      <div class="container">
        <div class="row">
          <div class="col-lg-7 mx-auto text-center">
            <h1 class="display-4 text-white">BIENVENUE SUR ASSURZEN</h1>
            <h5 class="text-white my-3 p-4">
              Enfoncez-vous dans le monde de l'assurance automobile en toute tranquillité avec 
              votre application qui vous permet de planifier le renouvellement de votre assurance. 
          </h5>
            <!-- <a href="#" class="btn me-2 btn-primary">Get Started</a>
                    <a href="#" class="btn btn-outline-light">My Portfolio</a> -->
          </div>
        </div>
      </div>
    </div>
    <!-- //HERO -->

    <!-- CARACTÉRISTIQUES -->
    <section class="row w-100 py-0 bg-light" id="features">
      <div class="col-lg-6 col-img"></div>
      <div class="col-lg-6 py-5">
        <div class="container">
          <div class="row">
            <div class="col-md-10 offset-md-1">
              <h6 class="text-primary">
                Avez-vous des difficultés pour planifier le renouvellement de
                votre assurance en cours ???
              </h6>
              <h1>Une application est donc disponible pour vous</h1>
              <p>
                <strong style="color: #000">AssurZen</strong> est une application web et mobile qui permet à un
                propriétaire automobile de planifier le renouvellement de son
                assurance par des déposits en fonction de la date de l'échéance
                de l'assurance en cours, du mode de déposit (hebdomadaire ,
                quinzaine ou par mois) et de la durée de l'assurance
                choisie(Annuelle, Semestrielle, Trimestrielle ou Mensuelle).
              </p>
              <p>
                Dans l'optique de parfaire ce projet, nous sommes en partenariat avec CIM SERVICES, une agence de AFG ASSURANCES
                qui, une fois au terme des déposits se chargera de la mise en place ou du renouvellement desdites assurances.
              </p>
              <p>
                AFG ASSURANCES offrent une gamme variée de produits de la branche IARDT dont l'assurance automobile, objet de cette application.
              </p>
              <!-- <div class="feature d-flex mt-5">
                <div class="iconbox me-3">
                  <i class="bx bxs-comment-edit"></i>
                </div>
                <div>
                  <h5>Produits Innovants</h5>
                  <p>
                    Nous proposons une gamme complète de produits d'assurance
                    adaptés à vos besoins spécifiques, qu'il s'agisse de santé,
                    d'automobile ou d'habitation.
                  </p>
                </div>
              </div>
              <div class="feature d-flex">
                <div class="iconbox me-3">
                  <i class="bx bxs-user-circle"></i>
                </div>
                <div>
                  <h5>Service Client Dédié</h5>
                  <p>
                    Notre équipe jeune et dynamique est à votre écoute pour vous
                    offrir un service personnalisé et répondre à toutes vos
                    questions.
                  </p>
                </div>
              </div>
              <div class="feature d-flex">
                <div class="iconbox me-3">
                  <i class="bx bxs-download"></i>
                </div>
                <div>
                  <h5>Gestion Facile en Ligne</h5>
                  <p>
                    Avec notre application mobile, gérez vos polices d'assurance
                    en ligne, où que vous soyez et à tout moment.
                  </p>
                </div>
              </div> -->
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- CARACTÉRISTIQUES  -->
    <section class="container" style="margin-top: -70px;">
      <h2 class="mb-5 fw-bold display-5 text-gradient">
        Les garanties automobiles de AFG ASSURANCES sont regroupées en deux packages:
      </h2>
      <h5 class="text-center mb-5  display-5 text-black">
      <span class="symbole losange">&#9670;</span>Premier package
      </h5>
      <div class="row g-5 justify-content-center">
        <!-- Avantage 1 -->
        <div class="col-md-6 col-lg-2" data-aos="zoom-in">
          <div
            class="card border-0 h-100 shadow-lg rounded-4 bg-white text-center p-2"
          >
            <div
              class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center"
              style="width: 60px; height: 60px"
            >
              <i class="bi bi-person-badge fs-3"></i>
            </div>
            <h5 class="fw-semibold">Responsabilité Civile</h5>
            
          </div>
        </div>

        <!-- Avantage 2 -->
        <div class="col-md-6 col-lg-2" data-aos="zoom-in" data-aos-delay="100">
          <div
            class="card border-0 h-100 shadow-lg rounded-4 bg-white text-center p-4"
          >
            <div
              class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center"
              style="width: 60px; height: 60px"
            >
              <i class="bi bi-people-fill fs-3"></i>
            </div>
            <h5 class="fw-semibold">Recours Tiers Incendie</h5>
            
          </div>
        </div>

        <!-- Avantage 3 -->
        <div class="col-md-6 col-lg-2" data-aos="zoom-in" data-aos-delay="200">
          <div
            class="card border-0 h-100 shadow-lg rounded-4 bg-white text-center p-4"
          >
            <div
              class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center"
              style="width: 60px; height: 60px"
            >
              <i class="bi bi-life-preserver fs-3"></i>
            </div>
            <h5 class="fw-semibold">Défense et Recours</h5>
            
          </div>
        </div>

        <!-- Avantage 4 -->
        <div class="col-md-6 col-lg-2" data-aos="zoom-in" data-aos-delay="300">
          <div
            class="card border-0 h-100 shadow-lg rounded-4 bg-white text-center p-4"
          >
            <div
              class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center"
              style="width: 60px; height: 60px"
            >
              <i class="bi bi-car-front-fill fs-3"></i>
            </div>
            <h5 class="fw-semibold">Protection Chauffeur</h5>
           
          </div>
        </div>
        <div class="col-md-6 col-lg-2" data-aos="zoom-in" data-aos-delay="300">
          <div
            class="card border-0 h-100 shadow-lg rounded-4 bg-white text-center p-4"
          >
            <div
              class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center"
              style="width: 60px; height: 60px"
            >
              <i class="bi bi-car-front-fill fs-3"></i>
            </div>
            <h5 class="fw-semibold">CEDEAO</h5>
           
          </div>
        </div>
        
      </div>
    </section>
    <section class="container" style="margin-top: -70px">
    <h5 class="text-center mb-5  display-5 text-black">
      <span class="symbole losange">&#9670;</span>Deuxième package
      </h5>
      <p class="text-center mb-5  display-5 text-black">
        Les garanties facultatives moyennant surprime
          </p>
      <div class="row g-4">
        <!-- Avantage 1 -->
        <div class="col-md-6 col-lg-3" data-aos="zoom-in">
          <div
            class="card border-0 h-100 shadow-lg rounded-4 bg-white text-center p-4"
          >
            <div
              class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center"
              style="width: 60px; height: 60px"
            >
              <i class="bi bi-shield-fill-exclamation fs-3"></i>
            </div>
            <h5 class="fw-semibold">Vol et Incendie</h5>
            
          </div>
        </div>

        <!-- Avantage 2 -->
        <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="100">
          <div
            class="card border-0 h-100 shadow-lg rounded-4 bg-white text-center p-4"
          >
            <div
              class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center"
              style="width: 60px; height: 60px"
            >
              <i class="bi bi-car-front-fill fs-3"></i>
            </div>
            <h5 class="fw-semibold">Dommages tous accidents</h5>
            
          </div>
        </div>

        <!-- Avantage 3 -->
        <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="200">
          <div
            class="card border-0 h-100 shadow-lg rounded-4 bg-white text-center p-4"
          >
            <div
              class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center"
              style="width: 60px; height: 60px"
            >
              <i class="bi bi-wind fs-3"></i>
            </div>
            <h5 class="fw-semibold">Bris de glace</h5>
            
          </div>
        </div>
        <div class="col-md-6 col-lg-3" data-aos="zoom-in" data-aos-delay="200">
          <div
            class="card border-0 h-100 shadow-lg rounded-4 bg-white text-center p-4"
          >
            <div
              class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center"
              style="width: 60px; height: 60px"
            >
              <i class="bi bi-lightning-charge-fill fs-3"></i>
            </div>
            <h5 class="fw-semibold">Dommages collision </h5>
            
          </div>
        </div>
        
      </div>
    </section>
    <!-- Section Avantages spécifiques -->
<section class="container" style="margin-bottom: -7px; margin-top: -90px">
  <div class="container">
    <div class="text-center mb-5">
      <h2 class="mb-5 fw-bold display-5 text-gradient">AFG ASSURANCES vous offre également des avantages comme:</h2>
      
    </div>
    
    <div class="row g-4">
      <!-- Assistance remorquage -->
      <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
        <div class="card h-100 border-0 shadow-lg text-center p-4 hover-shadow" style="transition: transform 0.3s ease;">
          <div class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
            <i class="bi bi-truck-flatbed fs-3"></i>
          </div>
          <h5 class="fw-semibold">Assistance remorquage</h5>
        </div>
      </div>

      <!-- Suivi clientèle -->
      <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
        <div class="card h-100 border-0 shadow-lg text-center p-4 hover-shadow" style="transition: transform 0.3s ease;">
          <div class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
            <i class="bi bi-chat-dots-fill fs-3"></i>
          </div>
          <h5 class="fw-semibold">Suivi de la clientèle</h5>
        </div>
      </div>

      <!-- Règlement diligent -->
      <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
        <div class="card h-100 border-0 shadow-lg text-center p-4 hover-shadow" style="transition: transform 0.3s ease;">
          <div class="icon-box bg-primary text-white mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
            <i class="bi bi-check2-circle fs-3"></i>
          </div>
          <h5 class="fw-semibold">Règlement diligent de vos dossiers en cas d'accident</h5>
        </div>
      </div>
    </div>
  </div>
</section>

    <div class="justify-content-center" style="margin-left:13%;">
    <div class="col-lg-10">
    <div class=" card-effect bounceInUp">
      
      <p style="color:red;text-align:center; font-size:20px;font-weight:bold;" class="justify-content-center">
      En cas de changement du tarif d'assurances en vigueur sur le marché béninois, 
      vous serez dans l'obligation de faire le complément après avoir respecter tous les déposits. </p>
    </div>
  </div>
    </div>
    
   
    <!-- ÉTAPES À SUIVRE -->
    <section id="services">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-8 mx-auto text-center">
            <h6 class="text-primary">ÉTAPES À SUIVRE</h6>
            <h1>Comment créer  votre compte ?</h1>
            <p>
              Suivez ces étapes simples pour créer votre compte afin de garantir votre protection à
              long terme.
            </p>
          </div>
        </div>
        <div class="row g-4">
  <!-- Étape 1 -->
  <div class="col-lg-4 col-sm-6">
    <div class="service card-effect bounceInUp">
      <div class="iconbox">
        <i class="bx bxs-user-detail"></i>
      </div>
      <h5 class="mt-4 mb-2">1. Remplir le formulaire</h5>
      <p>
        Indiquez vos informations personnelles comme le nom, prénom, numéro,npi et créez un mot de passe, etc.
      </p>
    </div>
  </div>

  <!-- Étape 2 -->
  <div class="col-lg-4 col-sm-6">
    <div class="service card-effect">
      <div class="iconbox">
        <i class="bx bxs-lock"></i>
      </div>
      <h5 class="mt-4 mb-2">2. Enregistrement sécurisé</h5>
      <p>
        Vos informations sont enregistrées de manière sécurisée pour vous permettre d'accéder à votre espace personnel.
      </p>
    </div>
  </div>

  <!-- Étape 3 -->
  <div class="col-lg-4 col-sm-6">
    <div class="service card-effect">
      <div class="iconbox">
        <i class="bx bxs-user-check"></i>
      </div>
      <h5 class="mt-4 mb-2">3. Compte créé</h5>
      <p>
        Votre compte est prêt ! Connectez-vous et commencez à gérer vos services en toute simplicité.
      </p>
    </div>
  </div>
</div>

      </div>
    </section>
    <!-- ÉTAPES À SUIVRE -->
    

    <!-- ----------- About Section Start --------- -->
    <section class="about-area pt-70 pb-120" data-scroll-index="2">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-6">
            <div
              class="about-image wow fadeInLeftBig"
              data-wow-duration="3s"
              data-wow-delay="0.5s"
            >
              <div class="about-shape"></div>
              <img
                src="img/about-app.png"
                alt="Aperçu de l'application mobile"
                class="app"
              />
            </div>
          </div>
          <div class="col-lg-6">
            <div
              class="about-content mt-50 wow fadeInRightBig"
              data-wow-duration="3s"
              data-wow-delay="0.5s"
            >
              <div class="section-title">
                <h1 class="title">Gérez vos paiements en toute simplicité</h1>
                <p class="text">
                  Notre application mobile vous permet de gérer vos paiements en
                  toute tranquillité. Connectez-vous en toute sécurité,
                  consultez l'historique de vos paiements et assurez-vous de
                  régler chaque montant à la date convenue. Avec une interface
                  intuitive et fluide, rester à jour avec vos finances n'a
                  jamais été aussi simple !
                </p>
              </div>
              <a href="#" class="main-btn btn me-2 btn-primary"
                >Télécharger l'Application</a
              >
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- ----------- About Section End --------- -->
    <!-- CONTACT -->
    <section id="contact">
  <div class="container">
    <div class="row mb-5">
      <div class="col-md-8 mx-auto text-center">
        <h6 class="text-primary">CONTACT</h6>
        <h1>Entrons en contact</h1>
        <p>
          N'hésitez pas à nous contacter pour toute question ou demande
          d'information. Remplissez le formulaire ci-dessous et nous vous
          répondrons dans les plus brefs délais.
        </p>
      </div>
    </div>

    <div class="row g-5">
      <!-- Colonne gauche: Adresse et numéro de l'entreprise -->
      <div class="col-md-6">
        <h4>Nos coordonnées</h4>
        <p><strong>Adresse :</strong> Cotonou, Bénin</p>
        <p><strong>Téléphone :</strong> +229 01 40 66 48 49</p>
        <p><strong>Email :</strong> enterprise@itsmbenin.com</p>
      </div>

      <!-- Colonne droite: Formulaire de contact -->
      <div class="col-md-6">
        <form action="" class="row g-3">
          <div class="col-md-12">
            <input type="text" class="form-control" placeholder="Nom complet" />
          </div>
          <div class="col-md-12">
            <input
              type="email"
              class="form-control"
              placeholder="Adresse e-mail"
            />
          </div>
          <div class="col-md-12">
            <input type="text" class="form-control" placeholder="Sujet" />
          </div>
          <div class="col-md-12">
            <textarea
              name=""
              id=""
              cols="30"
              rows="5"
              class="form-control"
              placeholder="Votre message"
            ></textarea>
          </div>
          <div class="col-md-12 d-grid">
            <button class="btn btn-primary">Envoyer</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</section>

    <!-- CONTACT -->

    <footer>
      <div class="footer-bottom py-3">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <p class="mb-0">
                © 2025 copyright Tous droits réservés | Créé par
                <a href="#" class="text-white fw-bold">ITSM-Bénin</a>
              </p>
            </div>
            <div class="col-md-6">
              <div class="social-icons">
                <a href="#"><i class="bx bxl-facebook"></i></a>
                <a href="#"><i class="bx bxl-twitter"></i></a>
                <a href="#"><i class="bx bxl-instagram-alt"></i></a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </footer>
    <div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-gradient text-white">
        <h5 class="modal-title" id="signupModalLabel">Créer un compte</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="signupForm" novalidate class="p-4">
          <div class="row">
            <!-- Nom et Prénom en colonnes -->
            <div class="col-md-6 mb-3">
              <label for="nom" class="form-label">Nom</label>
              <input type="text" class="form-control form-control-lg shadow-sm" id="nom" placeholder="Entrez votre nom" name="nom" required />
              <div id="nomError" class="invalid-feedback d-none"></div>
            </div>

            <div class="col-md-6 mb-3">
              <label for="prenom" class="form-label">Prénom</label>
              <input type="text" class="form-control form-control-lg shadow-sm" id="prenom" placeholder="Entrez votre prénom" name="prenom" required />
              <div id="prenomError" class="invalid-feedback d-none"></div>
            </div>
          </div>

          <div class="row">
            <!-- Email et Téléphone en colonnes -->
            <div class="col-md-6 mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control form-control-lg shadow-sm" id="email" placeholder="Entrez votre email" name="email" required />
              <div id="emailError" class="invalid-feedback d-none"></div>
            </div>

            <div class="col-md-6 mb-3">
              <label for="phone" class="form-label">Téléphone</label>
              <input type="text" class="form-control form-control-lg shadow-sm" id="phone" placeholder="Entrez votre téléphone" name="phone" required />
              <div id="phoneError" class="invalid-feedback d-none"></div>
            </div>
          </div>

          <div class="row">
            <!-- Genre et Date de naissance en colonnes -->
            <div class="col-md-6 mb-3">
              <label for="genre" class="form-label">Genre</label>
              <select class="form-select form-select-lg shadow-sm" id="genre" name="genre" required>
                <option value="M">Homme</option>
                <option value="F">Femme</option>
              </select>
            </div>

            <div class="col-md-6 mb-3">
              <label for="naissance" class="form-label">Date de naissance</label>
              <input type="date" class="form-control form-control-lg shadow-sm" id="naissance" name="naissance" required />
              <div id="naissanceError" class="invalid-feedback d-none"></div>
            </div>
          </div>

          <div class="row">
            <!-- Lieu et Ville en colonnes -->
            <div class="col-md-6 mb-3">
              <label for="lieu" class="form-label">Lieu</label>
              <input type="text" class="form-control form-control-lg shadow-sm" id="lieu" placeholder="Entrez votre lieu" name="lieu" required />
              <div id="lieuError" class="invalid-feedback d-none"></div>
            </div>

            <div class="col-md-6 mb-3">
              <label for="ville" class="form-label">Ville</label>
              <input type="text" class="form-control form-control-lg shadow-sm" id="ville" placeholder="Entrez votre ville" name="ville" required />
              <div id="villeError" class="invalid-feedback d-none"></div>
            </div>
          </div>

          <div class="row">
            <!-- Quartier et Mot de passe en colonnes -->
            <div class="col-md-6 mb-3">
              <label for="quartier" class="form-label">Quartier</label>
              <input type="text" class="form-control form-control-lg shadow-sm" id="quartier" placeholder="Entrez votre quartier" name="quartier" required />
              <div id="quartierError" class="invalid-feedback d-none"></div>
            </div>

            <div class="col-md-6 mb-3">
              <label for="password" class="form-label">Mot de passe</label>
              <input type="password" class="form-control form-control-lg shadow-sm" id="password" placeholder="Mot de passe" name="password" required />
              <div id="passwordError" class="invalid-feedback d-none"></div>
            </div>
          </div>

          <div class="row">
            <!-- Confirmation du mot de passe et NPI -->
            <div class="col-md-6 mb-3">
              <label for="confirmPassword" class="form-label">Confirmer le mot de passe</label>
              <input type="password" class="form-control form-control-lg shadow-sm" id="confirmPassword" placeholder="Confirmez le mot de passe" name="password_confirmation" required />
              <div id="confirmPasswordError" class="invalid-feedback d-none"></div>
            </div>

            <div class="col-md-6 mb-3">
              <label for="npi" class="form-label">NPI (Numéro de Pièce d'Identité)</label>
              <input type="text" class="form-control form-control-lg shadow-sm" id="npi" placeholder="Entrez votre NPI" name="npi" required />
              <div id="npiError" class="invalid-feedback d-none"></div>
            </div>
          </div>

          <div class="row">
            <!-- Conditions générales -->
            <div class="col-md-12 mb-3 d-flex align-items-center">
              <div class="form-check">
                <input class="form-check-input" type="checkbox" id="termsCheck" required />
                <label class="form-check-label" for="termsCheck">
                  J'accepte les <a href="#">conditions générales</a>
                </label>
                <div id="termsError" class="invalid-feedback d-none"></div>
              </div>
            </div>
          </div>

          <!-- Messages d'alerte -->
          <div id="alertContainer"></div>

          <!-- Bouton d'inscription -->
          <div class="d-grid mt-3">
            <button type="submit" name="submit" class="btn btn-primary btn-lg rounded-pill shadow">
              S'inscrire
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
    <div
      class="modal fade"
      id="firstModal"
      tabindex="-1"
      role="dialog"
      aria-labelledby="contractModalLabel"
      aria-hidden="true"
    >
      <div
        class="modal-dialog modal-lg modal-dialog-scrollable"
        role="document"
      >
        <div class="modal-content border-0 rounded-4 shadow-lg">
          <div
            class="modal-header bg-gradient text-white rounded-top-4"
            style="background: linear-gradient(135deg, #0d6efd, #6610f2)"
          >
            <h5 class="modal-title fw-bold" id="contractModalLabel">
              📄 Contrat d’adhésion
            </h5>
            <button
              type="button"
              class="btn-close btn-close-white"
              data-bs-dismiss="modal"
              aria-label="Fermer"
            ></button>
          </div>
          <div class="modal-body p-4 bg-light text-dark">
            <div class="mb-4">
              <h6 class="fw-bold text-primary">1. Introduction</h6>
              <p>
                Bienvenue sur notre plateforme de déposit pour le renouvellement
                de votre assurance. En utilisant nos services, vous acceptez les
                termes et conditions de ce contrat d’adhésion.
              </p>
            </div>

            <div class="mb-4">
              <h6 class="fw-bold text-primary">2. Objet du Contrat</h6>
              <p>
                Ce contrat définit les droits et obligations des utilisateurs et
                de la plateforme concernant la gestion des fonds déposés pour
                l’assurance des véhicules immatriculés lors de l’inscription.
              </p>
            </div>

            <div class="mb-4">
              <h6 class="fw-bold text-primary">3. Conditions d’Utilisation</h6>
              <ul>
                <li>
                  Vous devez être majeur ou disposer d’une autorisation
                  parentale.
                </li>
                <li>
                  Vous êtes responsable de la confidentialité de vos
                  identifiants.
                </li>
                <li>
                  L’assurance ne couvre que les véhicules immatriculés déclarés
                  à l’inscription.
                </li>
                <li>
                  Toute fausse déclaration peut entraîner la suspension de votre
                  compte.
                </li>
              </ul>
            </div>

            <div class="mb-4">
              <h6 class="fw-bold text-primary">4. Sécurité & Données</h6>
              <ul>
                <li>Vos données personnelles sont protégées selon la loi.</li>
                <li>
                  Aucune information n’est partagée sans votre consentement,
                  sauf obligation légale.
                </li>
              </ul>
            </div>

            <div class="mb-4">
              <h6 class="fw-bold text-primary">
                5. Engagements de la Plateforme
              </h6>
              <ul>
                <li>Gestion sécurisée des fonds et des informations.</li>
                <li>Transparence dans les services d’assurance.</li>
                <li>Support client à votre écoute.</li>
                <li>Renouvellement via AFG ou Atlantique Assurances.</li>
              </ul>
            </div>

            <div class="mb-4">
              <h6 class="fw-bold text-primary">6. Résiliation</h6>
              <ul>
                <li>
                  Résiliation possible à tout moment avec une retenue de 8% sur
                  la prime nette.
                </li>
                <li>Remboursement du solde dans un délai de 15 jours.</li>
                <li>Engagement à respecter la durée choisie (ex: 12 mois).</li>
                <li>
                  Suspension ou résiliation possible en cas de non-respect des
                  conditions.
                </li>
              </ul>
            </div>

            <div class="mb-3">
              <h6 class="fw-bold text-primary">7. Acceptation</h6>
              <p>
                En cliquant sur “Accepter et continuer”, vous confirmez avoir
                lu, compris et accepté les conditions de ce contrat.
              </p>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="checkbox"
                  id="acceptContract"
                />
                <label class="form-check-label" for="acceptContract">
                  J’ai lu et j’accepte les termes du contrat.
                </label>
              </div>
            </div>
          </div>
          <div class="modal-footer bg-white border-0">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Fermer
            </button>
            <button
              type="button"
              class="btn btn-primary"
              id="goToSecondModal"
              disabled
            >
              Accepter et continuer
            </button>
          </div>
        </div>
      </div>
    </div>

    <div
      class="modal fade"
      id="signupModal2"
      tabindex="-1"
      aria-labelledby="signupModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 rounded-4 shadow-lg">
          <div class="modal-header bg-primary text-white rounded-top-4">
            <h5 class="modal-title fw-bold" id="signupModalLabel">
              🚗 Souscrire à une assurance auto
            </h5>
            <button
              type="button"
              class="btn-close btn-close-white"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body bg-light">
            <form action="logout.php" method="POST">
              <div class="row g-4">
                <!-- Type de voiture -->
                <div class="col-md-6">
                  <label class="form-label fw-semibold" for="type_voiture">
                    <i class="bi bi-car-front-fill me-1 text-primary"></i> Type
                    de voiture
                  </label>
                  <input
                    type="text"
                    class="form-control shadow-sm"
                    id="type_voiture"
                    name="type_voiture"
                    required
                  />
                </div>

                <!-- Carburant -->
                <div class="col-md-6">
                  <label class="form-label fw-semibold" for="carburant">
                    <i class="bi bi-fuel-pump-fill me-1 text-success"></i> Type
                    de carburant
                  </label>
                  <input
                    type="text"
                    class="form-control shadow-sm"
                    id="carburant"
                    name="carburant"
                    required
                  />
                </div>

                <!-- Puissance -->
                <div class="col-md-6">
                  <label class="form-label fw-semibold" for="puissance">
                    <i class="bi bi-speedometer2 me-1 text-warning"></i>
                    Puissance
                  </label>
                  <input
                    type="text"
                    class="form-control shadow-sm"
                    id="puissance"
                    name="puissance"
                    required
                  />
                </div>

                <!-- Durée -->
                <div class="col-md-6">
                  <label
                    class="form-label fw-bold text-primary mb-3"
                    for="duree"
                  >
                    <i class="bi bi-hourglass-split me-2 text-danger"></i>
                    <span class="h5">Durée de l'assurance</span>
                  </label>
                  <select
                    class="form-select shadow-lg border-0 rounded-3 py-3 px-4"
                    name="duree"
                    id="duree"
                    required
                  >
                    <option value="" disabled selected>
                      Sélectionnez une durée
                    </option>
                    <option value="1MOIS">1 MOIS</option>
                    <option value="2MOIS">2 MOIS</option>
                    <option value="3MOIS">3 MOIS</option>
                    <option value="6MOIS">6 MOIS</option>
                    <option value="1ANS">1 AN</option>
                  </select>
                </div>

                <!-- Immatriculation -->
                <div class="col-md-6">
                  <label class="form-label fw-semibold" for="immatricule">
                    <i class="bi bi-123 me-1 text-secondary"></i>
                    Immatriculation
                  </label>
                  <input
                    type="text"
                    class="form-control shadow-sm"
                    id="immatricule"
                    name="immatricule"
                    required
                  />
                </div>

                <!-- Année fiscale -->
                <div class="col-md-6">
                  <label class="form-label fw-semibold" for="anneeFiscal">
                    <i class="bi bi-calendar3 me-1 text-info"></i> Année Fiscale
                  </label>
                  <input
                    type="number"
                    class="form-control shadow-sm"
                    id="anneeFiscal"
                    name="anneeFiscal"
                    required
                  />
                </div>

                <!-- Échéance -->
                <div class="col-md-6">
                  <label class="form-label fw-semibold" for="echeance">
                    <i class="bi bi-calendar-event-fill me-1 text-primary"></i>
                    Date d’échéance
                  </label>
                  <input
                    type="date"
                    class="form-control shadow-sm"
                    id="echeance"
                    name="echeance"
                    required
                  />
                </div>

                <!-- Méthode d'épargne -->
                <div class="col-md-6">
                  <label class="form-label fw-semibold" for="method_epargne">
                    <i class="bi bi-wallet2 me-1 text-success"></i> Méthode
                    d’épargne
                  </label>
                  <select
                    class="form-select shadow-lg border-0 rounded-3 py-3 px-4"
                    name="method_epargne"
                    id="method_epargne"
                    required
                  >
                    <option value="" disabled selected>
                      Sélectionnez une durée
                    </option>
                    <option value="Hebdomadaire">Hebdomadaire</option>
                    <option value="Quinzaine">Quinzaine</option>
                    <option value="Mensuelle">Mensuelle</option>
                  </select>
                </div>

                <!-- Montant -->
                <div class="col-md-6">
                  <label class="form-label fw-semibold" for="montant">
                    <i class="bi bi-cash-coin me-1 text-warning"></i> Montant à
                    épargner
                  </label>
                  <input
                    type="text"
                    class="form-control shadow-sm"
                    id="montant"
                    name="montant"
                    required
                  />
                </div>
              </div>

              <!-- Bouton -->
              <div class="text-center mt-4">
                <button
                  type="submit"
                  name="submit"
                  class="btn bg-primary btn-lg btn-gradient text-white px-5 py-2 fw-semibold"
                >
                  🚀 Créer mon assurance
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>


    <script src="js/bootstrap.bundle.min.js"></script>
   <script>
    document.addEventListener("DOMContentLoaded", function () {
  const form = document.getElementById("signupForm");

  // Récupération des éléments du formulaire
  const nom = document.getElementById("nom");
  const prenom = document.getElementById("prenom");
  const email = document.getElementById("email");
  const phone = document.getElementById("phone");
  const genre = document.getElementById("genre");
  const naissance = document.getElementById("naissance");
  const lieu = document.getElementById("lieu");
  const ville = document.getElementById("ville");
  const quartier = document.getElementById("quartier");
  const password = document.getElementById("password");
  const confirmPassword = document.getElementById("confirmPassword");
  const npi = document.getElementById("npi");
  const termsCheck = document.getElementById("termsCheck");

  // Récupération des éléments d'erreur
  const nomError = document.getElementById("nomError");
  const prenomError = document.getElementById("prenomError");
  const emailError = document.getElementById("emailError");
  const phoneError = document.getElementById("phoneError");
  const naissanceError = document.getElementById("naissanceError");
  const lieuError = document.getElementById("lieuError");
  const villeError = document.getElementById("villeError");
  const quartierError = document.getElementById("quartierError");
  const passwordError = document.getElementById("passwordError");
  const confirmPasswordError = document.getElementById("confirmPasswordError");
  const npiError = document.getElementById("npiError");
  const termsError = document.getElementById("termsError");

  // Fonction pour afficher les erreurs
  function showError(input, errorElement, message) {
    errorElement.textContent = message;
    errorElement.classList.remove("d-none");
    input.classList.add("is-invalid");
  }

  // Fonction pour masquer les erreurs
  function hideError(input, errorElement) {
    errorElement.classList.add("d-none");
    input.classList.remove("is-invalid");
  }

  // Calculer la date minimale (18 ans dans le passé) pour la date de naissance
  function setMaxDate() {
    const today = new Date();
    const minAge = 18;
    const maxYear = today.getFullYear() - minAge;
    const maxMonth = String(today.getMonth() + 1).padStart(2, '0');
    const maxDay = String(today.getDate()).padStart(2, '0');
    const maxDate = `${maxYear}-${maxMonth}-${maxDay}`;
    
    // Définir la date maximale pouvant être sélectionnée
    naissance.setAttribute("max", maxDate);
  }
  
  // Appliquer la contrainte dès le chargement
  setMaxDate();

  // Validation en temps réel
  nom.addEventListener("input", () => {
    if (nom.value.trim().length < 2) {
      showError(nom, nomError, "Le nom doit contenir au moins 2 caractères.");
    } else {
      hideError(nom, nomError);
    }
  });

  prenom.addEventListener("input", () => {
    if (prenom.value.trim().length < 2) {
      showError(prenom, prenomError, "Le prénom doit contenir au moins 2 caractères.");
    } else {
      hideError(prenom, prenomError);
    }
  });

  email.addEventListener("input", () => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email.value.trim())) {
      showError(email, emailError, "Entrez un email valide.");
    } else {
      hideError(email, emailError);
    }
  });

  phone.addEventListener("input", () => {
    const phoneRegex = /^\+?[0-9]{8,15}$/;
    if (!phoneRegex.test(phone.value.trim())) {
      showError(phone, phoneError, "Entrez un numéro de téléphone valide.");
    } else {
      hideError(phone, phoneError);
    }
  });

  naissance.addEventListener("input", () => {
    const birthDate = new Date(naissance.value);
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    
    // Ajuster l'âge si l'anniversaire n'est pas encore passé cette année
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    
    // Vérifier si l'utilisateur a au moins 18 ans
    if (age < 18) {
      showError(naissance, naissanceError, "Vous devez avoir au moins 18 ans pour vous inscrire.");
    } else {
      hideError(naissance, naissanceError);
    }
  });

  lieu.addEventListener("input", () => {
    if (lieu.value.trim().length < 2) {
      showError(lieu, lieuError, "Le lieu doit contenir au moins 2 caractères.");
    } else {
      hideError(lieu, lieuError);
    }
  });

  ville.addEventListener("input", () => {
    if (ville.value.trim().length < 2) {
      showError(ville, villeError, "La ville doit contenir au moins 2 caractères.");
    } else {
      hideError(ville, villeError);
    }
  });

  quartier.addEventListener("input", () => {
    if (quartier.value.trim().length < 2) {
      showError(quartier, quartierError, "Le quartier doit contenir au moins 2 caractères.");
    } else {
      hideError(quartier, quartierError);
    }
  });

  password.addEventListener("input", () => {
    if (password.value.length < 8) {
      showError(password, passwordError, "Le mot de passe doit contenir au moins 8 caractères.");
    } else {
      hideError(password, passwordError);
    }
  });

  confirmPassword.addEventListener("input", () => {
    if (confirmPassword.value !== password.value) {
      showError(confirmPassword, confirmPasswordError, "Les mots de passe ne correspondent pas.");
    } else {
      hideError(confirmPassword, confirmPasswordError);
    }
  });

  npi.addEventListener("input", () => {
    if (npi.value.trim().length < 5) {
      showError(npi, npiError, "Le numéro de pièce d'identité doit contenir au moins 5 caractères.");
    } else {
      hideError(npi, npiError);
    }
  });

  // Fonctions pour gérer les alertes avec SweetAlert2
  function showLoading() {
    Swal.fire({
      title: 'Traitement en cours...',
      html: "Veuillez patienter pendant l'inscription",
      timerProgressBar: true,
      didOpen: () => {
        Swal.showLoading();
      },
      allowOutsideClick: false,
      allowEscapeKey: false,
      allowEnterKey: false
    });
    
    // Désactiver le bouton de soumission pendant le chargement
    form.querySelector("button[type=submit]").disabled = true;
  }
  
  function showSuccessMessage(message) {
    Swal.fire({
      icon: 'success',
      title: 'Félicitations!',
      text: message,
      confirmButtonColor: '#4e73df',
      confirmButtonText: 'Super!',
      timer: 3000,
      timerProgressBar: true
    }).then((result) => {
      // Redirection après fermeture de l'alerte
      window.location.href = "connexion.php"; // Page de confirmation
    });
  }
  
  function showErrorMessage(message) {
    Swal.fire({
      icon: 'error',
      title: 'Oops...',
      text: message,
      confirmButtonColor: '#d33',
      confirmButtonText: 'Réessayer'
    });
    
    // Réactiver le bouton de soumission
    form.querySelector("button[type=submit]").disabled = false;
  }

  // Validation au moment de l'envoi du formulaire
  form.addEventListener("submit", function (event) {
    // Empêcher la soumission traditionnelle du formulaire
    event.preventDefault();
    
    let isValid = true;

    // Validation nom
    if (nom.value.trim().length < 2) {
      showError(nom, nomError, "Le nom doit contenir au moins 2 caractères.");
      isValid = false;
    }

    // Validation prénom
    if (prenom.value.trim().length < 2) {
      showError(prenom, prenomError, "Le prénom doit contenir au moins 2 caractères.");
      isValid = false;
    }

    // Validation email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email.value.trim())) {
      showError(email, emailError, "Entrez un email valide.");
      isValid = false;
    }

    // Validation téléphone
    const phoneRegex = /^\+?[0-9]{8,15}$/;
    if (!phoneRegex.test(phone.value.trim())) {
      showError(phone, phoneError, "Entrez un numéro de téléphone valide.");
      isValid = false;
    }

    // Validation date de naissance
    const birthDate = new Date(naissance.value);
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    
    // Ajuster l'âge si l'anniversaire n'est pas encore passé cette année
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    
    // Vérifier si l'utilisateur a au moins 18 ans
    if (age < 18) {
      showError(naissance, naissanceError, "Vous devez avoir au moins 18 ans pour vous inscrire.");
      isValid = false;
    }

    // Validation lieu
    if (lieu.value.trim().length < 2) {
      showError(lieu, lieuError, "Le lieu doit contenir au moins 2 caractères.");
      isValid = false;
    }

    // Validation ville
    if (ville.value.trim().length < 2) {
      showError(ville, villeError, "La ville doit contenir au moins 2 caractères.");
      isValid = false;
    }

    // Validation quartier
    if (quartier.value.trim().length < 2) {
      showError(quartier, quartierError, "Le quartier doit contenir au moins 2 caractères.");
      isValid = false;
    }

    // Validation mot de passe
    if (password.value.length < 8) {
      showError(password, passwordError, "Le mot de passe doit contenir au moins 8 caractères.");
      isValid = false;
    }

    // Validation confirmation mot de passe
    if (confirmPassword.value !== password.value) {
      showError(confirmPassword, confirmPasswordError, "Les mots de passe ne correspondent pas.");
      isValid = false;
    }

    // Validation NPI
    if (npi.value.trim().length < 5) {
      showError(npi, npiError, "Le numéro de pièce d'identité doit contenir au moins 5 caractères.");
      isValid = false;
    }

    // Validation conditions générales
    if (!termsCheck.checked) {
      showError(termsCheck, termsError, "Vous devez accepter les conditions.");
      isValid = false;
    } else {
      hideError(termsCheck, termsError);
    }

    // S'il y a des erreurs, afficher une notification
    if (!isValid) {
      Swal.fire({
        icon: 'warning',
        title: 'Formulaire incomplet',
        text: 'Veuillez corriger les erreurs avant de soumettre le formulaire.',
        confirmButtonColor: '#f6c23e',
        confirmButtonText: 'Compris'
      });
      return;
    }

    // Si toutes les validations sont OK, envoyer les données à l'API
    if (isValid) {
      // Récupérer toutes les données du formulaire
      const formData = new FormData(form);
      const userData = {};
      
      // Convertir FormData en objet JavaScript
      formData.forEach((value, key) => {
        userData[key] = value;
      });
      // Ajouter l'user_id fixe (1) aux données
  userData.user_id = 3;
  userData.bgcolor = "#FD3100"
      // URL de votre API
      const apiUrl = "https://assurzendemo.itsmbenin.com/api/addclient"; // Remplacez par l'URL réelle de votre API
      
      // Afficher l'indicateur de chargement avec SweetAlert
      showLoading();
      
      // Envoyer les données à l'API
      fetch(apiUrl, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
          // Ajoutez ici d'autres en-têtes si nécessaire (ex: clé d'API)
          // "Authorization": "Bearer YOUR_API_KEY"
        },
        body: JSON.stringify(userData)
      })
      .then(response => {
        if (!response.ok) {
          throw new Error(`Erreur HTTP: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        // Traitement en cas de succès
        console.log("Inscription réussie:", data);
        
        // Afficher le message de succès avec SweetAlert
        showSuccessMessage("Votre inscription a été effectuée avec succès!");
      })
      .catch(error => {
        // Traitement en cas d'erreur
        console.error("Erreur lors de l'inscription:", error);
        showErrorMessage("Une erreur est survenue lors de l'inscription. Veuillez réessayer.");
      });
    }
  });
});
   </script>
    <!-- AOS JS -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
      AOS.init();
    </script>
    <script>
      const checkbox = document.getElementById("acceptContract");
      const continueBtn = document.getElementById("goToSecondModal");

      checkbox.addEventListener("change", () => {
        continueBtn.disabled = !checkbox.checked;
      });

      continueBtn.addEventListener("click", function () {
        const firstModal = bootstrap.Modal.getInstance(
          document.getElementById("firstModal")
        );
        firstModal.hide();

        const secondModal = new bootstrap.Modal(
          document.getElementById("signupModal")
        );
        secondModal.show();
      });
    </script>
  
</script>

    <!-- Ajoutez ces lignes dans la section <head> de votre HTML -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.12/sweetalert2.all.min.js"></script>
  </body>
</html>
