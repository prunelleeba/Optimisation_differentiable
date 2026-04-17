#!/bin/bash

# Script de test local rapide

echo "🧪 Test Local - Optimisation Différentiable"
echo "==========================================="
echo ""

# Vérifier les prérequis
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 n'est pas installé"
    exit 1
fi

if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 n'est pas installé"
    exit 1
fi

# Installer les dépendances backend
echo "📦 Installation des dépendances..."
cd backend
pip3 install -q -r requirements.txt
cd ..

# Lancer le backend en arrière-plan
echo "🚀 Lancement du backend (port 8000)..."
cd backend
python3 -m uvicorn main:app --quiet --host localhost --port 8000 &
BACKEND_PID=$!
cd ..

# Attendre que le serveur démarre
sleep 2

# Tester l'API
echo "🧪 Test de l'API..."
echo ""

# Test 1: Sans contrainte - Minimum simple
echo "Test 1: Optimisation sans contrainte (x^2 + y^2)"
curl -s -X POST http://localhost:8000/optimize \
  -H "Content-Type: application/json" \
  -d '{
    "fonction": "x**2 + y**2",
    "type_optimization": "sans_contrainte"
  }' | python3 -m json.tool

echo ""
echo "---"
echo ""

# Test 2: Sans contrainte - Point selle
echo "Test 2: Point selle (x^2 - y^2)"
curl -s -X POST http://localhost:8000/optimize \
  -H "Content-Type: application/json" \
  -d '{
    "fonction": "x**2 - y**2",
    "type_optimization": "sans_contrainte"
  }' | python3 -m json.tool

echo ""
echo "---"
echo ""

# Test 3: Avec contrainte
echo "Test 3: Optimisation avec contrainte"
curl -s -X POST http://localhost:8000/optimize \
  -H "Content-Type: application/json" \
  -d '{
    "fonction": "x**2 + y**2",
    "type_optimization": "avec_contrainte",
    "contrainte": "x + y - 1"
  }' | python3 -m json.tool

echo ""
echo "---"
echo ""

# Arrêter le backend
echo "🛑 Arrêt du serveur (PID: $BACKEND_PID)..."
kill $BACKEND_PID 2>/dev/null

echo ""
echo "✅ Tests terminés!"
