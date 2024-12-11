# lonewolfcast_app
# Créer un dossier pour Flutter
mkdir ~/development
cd ~/development

# Télécharger le SDK Flutter
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz

# Extraire l'archive
tar xf flutter_linux_3.24.5-stable.tar.xz

# Ouvrir le fichier de configuration du shell
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc

# Recharger le shell
source ~/.bashrc

# Vérifier l'installation 
flutter doctor

# Installer les outils de développement essentiels
sudo apt-get update
sudo apt-get install -y \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    liblzma-dev


# Créer le projet Flutter dans lonewolfcast_app
flutter create lonewolfcast_app

# Aller dans le dossier du projet
cd lonewolfcast_app

# Installer CHROME pour un projet WEB
sudo apt-get update
sudo apt-get install -y chromium-browser

# Configurer l'exécutable chrome
export CHROME_EXECUTABLE=/usr/bin/chromium-browser

# lancer le projet
flutter run -d web-server

#  pubspec.yaml - ajout des dépendances essentielles et installation 
flutter pub get


# installation firebase 
npm install -g firebase-tools
dart pub global activate flutterfire_cli
firebase login

echo $HOME/.pub-cache/bin/flutterfire
export PATH="$PATH":"$HOME/.pub-cache/bin"
flutterfire configure