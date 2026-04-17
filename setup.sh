#!/bin/bash

# Script d'aide pour le déploiement rapide

set -e

echo "🚀 Optimisation Différentiable - Assistant de Déploiement"
echo "======================================================"
echo ""

# Vérifier si on est dans le bon répertoire
if [ ! -f "README.md" ]; then
    echo "❌ Erreur: Lancez ce script depuis la racine du projet"
    exit 1
fi

# Menu
echo "Que voulez-vous faire?"
echo "1) Configurer et lancer le backend (local)"
echo "2) Configurer Flutter"
echo "3) Build APK (release)"
echo "4) Installer sur téléphone (debug)"
echo "5) Afficher l'URL du backend déployé"
echo ""
read -p "Choisissez (1-5): " choice

case $choice in
    1)
        echo "📦 Configuration du backend..."
        cd backend
        if [ ! -d "venv" ]; then
            python3 -m venv venv
            source venv/bin/activate
        else
            source venv/bin/activate
        fi
        pip install -r requirements.txt
        echo ""
        echo "✅ Backend prêt!"
        echo "🚀 Lancement..."
        uvicorn main:app --reload --host 0.0.0.0 --port 8000
        ;;
    2)
        echo "🎨 Configuration de Flutter..."
        cd frontend
        flutter pub get
        echo "✅ Flutter configuré!"
        echo ""
        echo "⚠️  IMPORTANT: Mettez à jour l'URL du serveur dans lib/main.dart"
        echo "Ligne: ApiService.init('YOUR_URL_HERE');"
        ;;
    3)
        echo "📦 Build APK (cela peut prendre 2-3 minutes)..."
        cd frontend
        flutter build apk --release
        echo ""
        echo "✅ APK créée!"
        echo "📍 Localisation: frontend/build/app/outputs/flutter-app.apk"
        echo ""
        echo "Vous pouvez maintenant donner ce fichier à l'enseignant!"
        ;;
    4)
        echo "📱 Installation sur téléphone..."
        echo "Assurez-vous que:"
        echo "  - Un téléphone est connecté en USB"
        echo "  - Le mode développeur est activé"
        echo "  - USB Debugging est activé"
        echo ""
        read -p "Appuyez sur Entrée pour continuer..."
        cd frontend
        flutter install
        ;;
    5)
        echo ""
        echo "📌 URL du Backend Déployé:"
        echo "======================================"
        echo ""
        echo "Pour Render:"
        echo "  https://optimisation-differentiable.onrender.com"
        echo ""
        echo "Pour Railway:"
        echo "  Dépend de votre configuration"
        echo ""
        echo "Mettez à jour dans: frontend/lib/main.dart"
        echo ""
        ;;
    *)
        echo "❌ Choix invalide"
        exit 1
        ;;
esac

echo ""
echo "✨ Terminé!"
