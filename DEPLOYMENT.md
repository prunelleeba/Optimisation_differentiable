# Optimisation Différentiable - Guide de Déploiement

## 📱 Installation Rapide

### Backend (Python/FastAPI)

#### 1. Configuration locale (pour test)
```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

#### 2. Déploiement sur Render (GRATUIT)
1. Créez un compte sur https://render.com
2. Fork ce repo ou connectez-le à Render
3. Créez un nouveau "Web Service"
4. Sélectionnez le langage "Python"
5. Configuration:
   - **Build command**: `pip install -r backend/requirements.txt`
   - **Start command**: `cd backend && uvicorn main:app --host 0.0.0.0 --port $PORT`
6. Déployez !

#### Alternative: Déploiement sur Railway (aussi gratuit)
1. https://railway.app
2. Connectez votre repo GitHub
3. Railway détectera automatiquement Python/FastAPI
4. Déployez !

### Frontend (Flutter)

#### 1. Installation de Flutter
Si vous n'avez pas Flutter, installez-le:
```bash
# macOS/Linux
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor

# Windows: Téléchargez depuis https://flutter.dev/docs/get-started/install
```

#### 2. Préparation du projet
```bash
cd frontend
flutter pub get
```

#### 3. Configuration de l'URL du serveur
Modifiez [main.dart](frontend/lib/main.dart):
```dart
ApiService.init('https://votre-url-render.com'); // Remplacez par votre URL
```

#### 4. Build APK (Android)
```bash
flutter build apk --release
```
Le fichier APK se trouve à: `build/app/outputs/flutter-app.apk`

#### 5. Build iOS (macOS/iOS seulement)
```bash
flutter build ios --release
```

#### 6. Installation directe sur téléphone
- **Android**: `flutter install` (téléphone en mode développeur via USB)
- **iOS**: `flutter install` (Mac + XCode)

---

## 📊 Exemples d'utilisation

### Sans contrainte - Minimum simple
**Fonction**: `x**2 + y**2`
**Résultat**: Point critique (0, 0) → Minimum

### Sans contrainte - Point selle
**Fonction**: `x**2 - y**2`
**Résultat**: Point critique (0, 0) → Point selle

### Sans contrainte - Fonction trigonométrique
**Fonction**: `sin(x)*cos(y)`
**Résultat**: Plusieurs points critiques

### Avec contrainte - Lagrange
**Fonction**: `x**2 + y**2`
**Contrainte**: `x + y - 1`
**Résultat**: Optimum sous contrainte

---

## 🔧 Architecture

```
├── backend/
│   ├── main.py (Serveur FastAPI)
│   ├── requirements.txt (Dépendances Python)
│   └── Procfile (Config déploiement)
├── frontend/
│   ├── lib/
│   │   ├── main.dart (Point d'entrée)
│   │   ├── screens/ (Interfaces)
│   │   ├── services/ (Communication API)
│   │   └── models/ (Modèles de données)
│   ├── pubspec.yaml (Config Flutter)
│   └── android/, ios/ (Config natives)
```

---

## ⚡ Dépannage

### "Impossible de se connecter au serveur"
- Vérifiez que l'URL dans `main.dart` est correcte
- Vérifiez que le backend est actif
- Sur émulateur Android: `flutter install` peut nécessiter le port forwarding

### "Aucun point critique trouvé"
- Vérifiez la syntaxe mathématique: `x**2` (pas `x^2`)
- Utilisez les opérateurs Python: `sin()`, `cos()`, `exp()`, etc.
- Pour les fractions: `x/2` pas `x÷2`

### Erreur SymPy
- Vérifiez que les variables sont uniquement `x` et `y`
- La contrainte doit être une équation (pas une inégalité)

---

## 📝 Syntaxe mathématique

Les fonctions doivent être écrites en syntaxe Python/SymPy:

| Opération | Syntaxe |
|-----------|---------|
| Puissance | `x**2` |
| Sinus | `sin(x)` |
| Cosinus | `cos(y)` |
| Exponentielle | `exp(x)` |
| Racine carrée | `sqrt(x)` |
| Plus simple | Évitez parenthèses inutiles |

---

## 🚀 Mise à jour future

Pour ajouter:
1. Support multilingue
2. Graphiques 3D
3. Export des résultats
4. Historique des calculs

Modifiez le backend (FastAPI) et frontend (Flutter) indépendamment!

---

## 📧 Support
Pour les erreurs ou suggestions, vérifiez d'abord les exemples ci-dessus.
