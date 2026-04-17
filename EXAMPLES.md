# 📚 Exemples de Fonctions pour Optimisation Différentiable

## 🎯 Convention d'écriture

- **Puissance**: Utilisez `**` (pas `^`)
- **Variables**: `x` et `y` uniquement
- **Fonctions**: `sin()`, `cos()`, `tan()`, `exp()`, `log()`, `sqrt()`
- **Opérateurs**: `+`, `-`, `*`, `/`

---

## ✨ Exemples par Catégorie

### 1️⃣ Fonctions Simples

#### Parabole (Minimum)
```
Fonction: x**2 + y**2
Résultat: Minimum à (0, 0), valeur = 0
```

#### Parabole Inverse (Maximum)
```
Fonction: -x**2 - y**2
Résultat: Maximum à (0, 0), valeur = 0
```

#### Hyperboloïde (Point Selle)
```
Fonction: x**2 - y**2
Résultat: Point selle à (0, 0)
```

---

### 2️⃣ Fonctions Polynomiales

#### Polynôme de degré 4
```
Fonction: x**4 + y**4 - 4*x**2 - 4*y**2
Résultat: Multiple points critiques
```

#### Surface ondulée
```
Fonction: (x**2 - 1)**2 + (y**2 - 1)**2
Résultat: Minima aux coins
```

#### Polynôme mixte
```
Fonction: x**3 - 3*x*y**2
Résultat: Point critique à l'origine (selle)
```

---

### 3️⃣ Fonctions Trigonométriques

#### Produit de sinus
```
Fonction: sin(x)*sin(y)
Résultat: Plusieurs points critiques
Déterminés par la périodicité
```

#### Somme trigonométrique
```
Fonction: cos(x) + cos(y)
Résultat: Maxima et minima périodiques
```

#### Ondes croisées
```
Fonction: sin(x)*cos(y)
Résultat: Points selle et extrêmes
```

---

### 4️⃣ Fonctions Exponentielles

#### Cloche gaussienne
```
Fonction: exp(-(x**2 + y**2))
Résultat: Maximum à (0, 0), valeur = 1
```

#### Croissance exponentielle
```
Fonction: exp(x) + exp(y)
Résultat: Pas de point critique (croissance illimitée)
```

#### Produit exponentiel
```
Fonction: x*exp(-(x**2 + y**2))
Résultat: Plusieurs points critiques
```

---

### 5️⃣ Fonctions Mixtes

#### Rosenbrock modifié
```
Fonction: (1-x)**2 + 100*(y-x**2)**2
Résultat: Minimum à (1, 1)
Défi classique d'optimisation
```

#### Somme pondérée
```
Fonction: 2*x**2 + y**2 - 4*x + 2*y
Résultat: Minimum unique
```

#### Produit polynomial-trigonométrique
```
Fonction: (x**2 + y**2)*sin(x*y)
Résultat: Point critique à l'origine
```

---

### 🔒 Optimisation AVEC Contrainte (Lagrange)

#### Minimiser x² + y² sous x + y = 1
```
Fonction: x**2 + y**2
Contrainte: x + y - 1
Résultat: Optimum à (0.5, 0.5), valeur = 0.5
```

#### Minimiser xy sous x² + y² = 1
```
Fonction: x*y
Contrainte: x**2 + y**2 - 1
Résultat: Extrêmes ±0.5
```

#### Maximiser x + y sous x² + y² = 2
```
Fonction: x + y
Contrainte: x**2 + y**2 - 2
Résultat: Maximum à x = y = 1
```

#### Minimiser coût sous production
```
Fonction: x**2 + 2*y**2
Contrainte: x + y - 10
Résultat: Optimum production
```

---

## 🎓 Cas d'Usage Éducatifs

### Analyse de Points Critiques
```
Fonction: x**3 + y**3 - 3*x*y
Résultat: Montre l'importance de analyser toutes les dérivées partielles
```

### Classification des Points Selle
```
Fonction: x**2 - y**2 + x*y
Résultat: Selle complexe pour étudier la Hessienne
```

### Optimisation Contraint
```
Fonction: 3*x + 2*y
Contrainte: x**2 + y**2 - 1
Résultat: Cas linéaire sous contrainte quadratique
```

---

## ⚠️ Pièges Communs

❌ **INCORRECTE**: `x^2 + y^2` (Utilisez ** pas ^)
✅ **CORRECTE**: `x**2 + y**2`

❌ **INCORRECTE**: `sinx` (Manquent les parenthèses)
✅ **CORRECTE**: `sin(x)`

❌ **INCORRECTE**: `2xy` (Utiliser * pour la multiplication)
✅ **CORRECTE**: `2*x*y`

❌ **INCORRECTE**: Utiliser d'autres variables comme `z` ou `t`
✅ **CORRECTE**: Utiliser uniquement `x` et `y`

---

## 🧮 Formules pour Tester

Copiez-collez ces formules directement dans l'app:

```
x**2 + y**2
x**2 - y**2
x*y
sin(x)*sin(y)
exp(-(x**2 + y**2))
x**3 + y**3 - 3*x*y
(x-1)**2 + (y-2)**2
x**4 - 2*x**2 + y**2
sin(x) + cos(y)
exp(x) - 2*x**2 - y**2
```

---

## 💡 Tips & Tricks

1. **Commencez simple**: Testez `x**2 + y**2` d'abord
2. **Vérifiez la syntaxe**: Utilisez la bonne notation Python
3. **Attendez les résultats**: Le calcul peut prendre quelques secondes
4. **Analysez**: Vérifiez si les résultats correspondent à votre intuition
5. **Expérimentez**: Modifiez les coefficients et voyez comment ça change

---

## 📖 Ressources

- [SymPy Documentation](https://docs.sympy.org/)
- [Optimisation multidimensionnelle](https://en.wikipedia.org/wiki/Optimization_(mathematics))
- [Méthode de Lagrange](https://en.wikipedia.org/wiki/Lagrange_multiplier)
