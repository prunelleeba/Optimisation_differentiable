# 🧮 Optimisation Différentiable - Application Mobile

Une application mobile **Flutter** pour l'optimisation différentiable avec et sans contrainte. Permet de trouver les points critiques, les classifier et afficher les résultats détaillés.

## ✨ Fonctionnalités

- ✅ **Optimisation sans contrainte** - Trouver min/max/selle
- ✅ **Optimisation avec contrainte** - Méthode de Lagrange
- ✅ **Calcul automatique** des points critiques
- ✅ **Classification** (Minimum, Maximum, Point selle)
- ✅ **Affichage des valeurs propres** de la Hessienne
- ✅ **Interface intuitive** en Flutter
- ✅ **Distribuable** en APK

## 🚀 Démarrage Rapide

### Prérequis
- Flutter SDK >= 3.0
- Python 3.8+ (pour le backend)
- Un service cloud gratuit (Render ou Railway)

### 1️⃣ Backend (Python)
```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
```

### 2️⃣ Frontend (Flutter)
```bash
cd frontend
flutter pub get
flutter run
```

### 3️⃣ Build APK (Production)
```bash
cd frontend
flutter build apk --release
# APK disponible dans: build/app/outputs/flutter-app.apk
```

---

## 📋 Structure du Projet

```
optimisation_differentiable/
├── backend/                          # Serveur Python FastAPI
│   ├── main.py                      # Logique métier
│   ├── requirements.txt             # Dépendances
│   └── Procfile                     # Config déploiement
├── frontend/                        # App Mobile Flutter
│   ├── lib/
│   │   ├── main.dart               # Point d'entrée
│   │   ├── screens/                # Interfaces UI
│   │   │   ├── home_screen.dart
│   │   │   └── optimization_screen.dart
│   │   ├── services/               # Communication API
│   │   │   └── api_service.dart
│   │   └── models/                 # Modèles de données
│   │       └── optimization_model.dart
│   ├── android/                    # Config Android
│   ├── ios/                        # Config iOS
│   └── pubspec.yaml               # Dépendances Flutter
└── DEPLOYMENT.md                   # Guide complet de déploiement
```

---

## 💻 Exemples d'Utilisations

### Sans Contrainte

**Exemple 1: Parabole simple**
```
Fonction: x**2 + y**2
Résultat: Point critique (0, 0) → MINIMUM
```

**Exemple 2: Selle de cheval**
```
Fonction: x**2 - y**2
Résultat: Point critique (0, 0) → POINT SELLE
```

**Exemple 3: Fonctions trigonométriques**
```
Fonction: sin(x)*cos(y)
Résultat: Plusieurs points critiques
```

### Avec Contrainte

**Exemple: Minimiser x²+y² avec contrainte x+y=1**
```
Fonction: x**2 + y**2
Contrainte: x + y - 1
Résultat: Optimum sous contrainte trouvé
```

---

## 📱 Déploiement en 3 étapes

### ❌ AVANT: Serveur n'est pas actif
L'app affichera: **"Erreur: Impossible de se connecter"**

### ✅ ÉTAPE 1: Déployer le Backend
Voir [DEPLOYMENT.md](DEPLOYMENT.md) pour Render/Railway

### ✅ ÉTAPE 2: Configurer l'URL
Modifiez `frontend/lib/main.dart`:
```dart
ApiService.init('https://votre-backend-url.com');
```

### ✅ ÉTAPE 3: Build et distribuer l'APK
```bash
cd frontend
flutter build apk --release
# Donnez le fichier APK à l'enseignant!
```

---

## 🔌 API Backend

### Endpoint Principal
```
POST /optimize
Content-Type: application/json

{
  "fonction": "x**2 + y**2",
  "type_optimization": "sans_contrainte",
  "contrainte": null
}
```

**Réponse:**
```json
{
  "success": true,
  "points_critiques": [
    {
      "point": {"x": 0, "y": 0},
      "valeurs_propres": [2.0, 2.0],
      "classification": "Minimum local",
      "valeur_fonction": 0
    }
  ],
  "classification": "Minimum uniquement",
  "message": "Optimisation sans contrainte réussie",
  "details": {"nombre_points": 1}
}
```

---

## 🛠️ Technos

| Composant | Tech |
|-----------|------|
| **Backend** | Python, FastAPI, SymPy |
| **Frontend** | Flutter, Dart |
| **API** | REST HTTP |
| **Maths** | Calcul symbolique (SymPy) |
| **Deploy** | Render / Railway |

---

## 📝 Syntaxe Mathématique

Les fonctions doivent être écrites en **syntaxe Python SymPy**:

| Opération | Exemple |
|-----------|---------|
| Puissance | `x**2 + y**2` |
| Trigonométrique | `sin(x) + cos(y)` |
| Exponentielle | `exp(x*y)` |
| Racine | `sqrt(x**2 + y**2)` |
| Division | `x/2 + y/3` |

---

## ⚙️ Configuration personnalisée

### Changer l'URL du backend
Fichier: `frontend/lib/main.dart`
```dart
ApiService.init('YOUR_URL_HERE');
```

### Ajouter une nouvelle fonctionnalité
1. Modifiez `backend/main.py`
2. Ajoutez un nouvel endpoint
3. Mettez à jour `frontend/lib/services/api_service.dart`
4. Créez une nouvelle screen Flutter
5. Rebuildez l'APK

---

## 🐛 Dépannage

### "Aucun point critique trouvé"
- Vérifiez la formule mathématique
- Utilisez la bonne syntaxe: `x**2` pas `x^2`
- Exemples de formules valides dans la section Exemples

### Erreur de connexion
- Est-ce que le backend est actif?
- Vérifiez l'URL dans `main.dart`
- Vérifiez votre connexion internet

### Problème de build APK
```bash
flutter clean
flutter pub get
flutter build apk --release
```

---

## 📚 Ressources

- [Flutter Documentation](https://flutter.dev)
- [FastAPI Documentation](https://fastapi.tiangolo.com)
- [SymPy Documentation](https://docs.sympy.org)
- [Render Deployment](https://render.com)

---

## 📄 License

Ce projet est fourni libre d'utilisation pour fins éducatives.

---

## 👨‍🏫 Pour l'enseignant

L'app est prête à être donnée à vos étudiants:
1. Le backend est hébergé gratuitement
2. L'APK peut être installée sur n'importe quel téléphone Android
3. Les étudiants entrent leur fonction et obtiennent les résultats

Aucune configuration supplémentaire n'est nécessaire! 🎉
# Optimisation_differentiable
