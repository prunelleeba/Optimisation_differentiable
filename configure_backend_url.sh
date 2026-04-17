#!/bin/bash

# Script pour configurer rapidement l'URL du backend

echo ""
echo "🔧 Configuration de l'URL du backend"
echo "===================================="
echo ""

MAIN_FILE="frontend/lib/main.dart"

# Vérifier si le fichier existe
if [ ! -f "$MAIN_FILE" ]; then
    echo "❌ Fichier not found: $MAIN_FILE"
    exit 1
fi

echo "URL actuellement configurée:"
grep "ApiService.init" "$MAIN_FILE"
echo ""

echo "Entrez la nouvelle URL du backend:"
echo "Exemples:"
echo "  • Local:    http://localhost:8000"
echo "  • Render:   https://optimisation-differentiable.onrender.com"
echo "  • Railway:  https://optimisation-differentiable.railway.app"
echo ""
read -p "URL: " URL

# Vérifier que l'URL est valide
if [ -z "$URL" ]; then
    echo "❌ URL vide"
    exit 1
fi

# Remplacer dans le fichier
sed -i.bak "s|ApiService.init('[^']*')|ApiService.init('$URL')|" "$MAIN_FILE"

echo ""
echo "✅ URL mise à jour!"
echo ""
echo "Nouvelle configuration:"
grep "ApiService.init" "$MAIN_FILE"
echo ""

# Propager à tous les fichiers si nécessaire
echo "Voulez-vous rebuild l'APK? (y/n)"
read -p "> " rebuild

if [ "$rebuild" = "y" ]; then
    cd frontend
    echo "🔨 Building APK..."
    flutter build apk --release
    echo "✅ APK prête!"
    echo "📍 Localisation: frontend/build/app/outputs/flutter-app.apk"
fi

echo ""
