from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import sympy as sy
from typing import List, Dict, Any
import traceback

app = FastAPI()

# Configuration CORS pour accepter les requêtes de n'importe où
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class OptimizationRequest(BaseModel):
    fonction: str
    type_optimization: str  # "sans_contrainte" ou "avec_contrainte"
    contrainte: str = None  # optionnel, pour "avec_contrainte"

class OptimizationResponse(BaseModel):
    success: bool
    points_critiques: List[Dict[str, Any]] = []
    classification: str = ""
    message: str = ""
    details: Dict[str, Any] = {}

def optimisation_sans_contrainte(fonction_str: str) -> OptimizationResponse:
    """Optimisation sans contrainte"""
    try:
        x, y = sy.symbols('x y', real=True)
        
        # Parser la fonction
        f = sy.sympify(fonction_str)
        
        # Calculer le gradient
        grad_x = sy.diff(f, x)
        grad_y = sy.diff(f, y)
        grad = [grad_x, grad_y]
        
        # Trouver les points critiques
        pcr = sy.solve(grad, (x, y))
        
        if not pcr:
            return OptimizationResponse(
                success=False,
                message="Aucun point critique trouvé"
            )
        
        # Calculer la matrice Hessienne
        H = sy.hessian(f, (x, y))
        
        # Analyser chaque point critique
        details = []
        classifications = []
        
        if not isinstance(pcr, list):
            pcr = [pcr]
        
        for point in pcr:
            if isinstance(point, tuple):
                x_val, y_val = point
            else:
                x_val = point
                y_val = None
            
            # Évaluer la Hessienne au point critique
            H_point = H.subs({x: x_val, y: y_val}) if y_val else H
            
            # Calculer les valeurs propres
            eigenvalues = list(H_point.eigenvals().keys())
            
            # Classer le point critique
            if len(eigenvalues) >= 2:
                eig1, eig2 = eigenvalues[0], eigenvalues[1]
                
                # Conversion en float pour comparaison
                try:
                    eig1_float = float(eig1)
                    eig2_float = float(eig2)
                except:
                    eig1_float = eig1
                    eig2_float = eig2
                
                # Classification
                if eig1_float > 0 and eig2_float > 0:
                    classification = "Minimum local"
                    classifications.append("Minimum")
                elif eig1_float < 0 and eig2_float < 0:
                    classification = "Maximum local"
                    classifications.append("Maximum")
                else:
                    classification = "Point selle"
                    classifications.append("Point selle")
            else:
                classification = "Indéterminé"
                classifications.append("Indéterminé")
            
            # Évaluer la fonction au point
            f_value = f.subs({x: x_val, y: y_val}) if y_val else f.subs({x: x_val})
            
            detail = {
                "point": {"x": float(x_val) if x_val.is_number else str(x_val),
                         "y": float(y_val) if y_val and y_val.is_number else str(y_val) if y_val else None},
                "valeurs_propres": [float(e) if e.is_number else str(e) for e in eigenvalues],
                "classification": classification,
                "valeur_fonction": float(f_value) if f_value.is_number else str(f_value)
            }
            details.append(detail)
        
        # Résumé général
        has_minimum = "Minimum" in classifications
        has_maximum = "Maximum" in classifications
        
        if has_minimum and has_maximum:
            general_classification = "Minimum et Maximum"
        elif has_minimum:
            general_classification = "Minimum uniquement"
        elif has_maximum:
            general_classification = "Maximum uniquement"
        else:
            general_classification = "Points selle ou indéterminés"
        
        return OptimizationResponse(
            success=True,
            points_critiques=details,
            classification=general_classification,
            message="Optimisation sans contrainte réussie",
            details={"nombre_points": len(details)}
        )
    
    except Exception as e:
        return OptimizationResponse(
            success=False,
            message=f"Erreur: {str(e)}"
        )

def optimisation_avec_contrainte(fonction_str: str, contrainte_str: str) -> OptimizationResponse:
    """Optimisation avec contrainte (Lagrange)"""
    try:
        x, y, lam = sy.symbols('x y lam', real=True)
        
        # Parser la fonction objectif et la contrainte
        h = sy.sympify(fonction_str)
        t = sy.sympify(contrainte_str)
        
        # Lagrangien
        k = h + lam * t
        
        # Équations du Lagrangien
        eq1 = sy.diff(k, x)
        eq2 = sy.diff(k, y)
        eq3 = t
        
        # Résoudre le système
        solution = sy.solve([eq1, eq2, eq3], [x, y, lam], dict=True)
        
        if not solution:
            return OptimizationResponse(
                success=False,
                message="Aucune solution trouvée pour le système d'équations"
            )
        
        details = []
        
        for sol in solution:
            x_val = sol.get(x, 0)
            y_val = sol.get(y, 0)
            lam_val = sol.get(lam, 0)
            
            # Évaluer la fonction objectif
            h_val = h.subs({x: x_val, y: y_val})
            h_val = sy.simplify(h_val)
            
            detail = {
                "point": {
                    "x": float(x_val) if x_val.is_number else str(x_val),
                    "y": float(y_val) if y_val.is_number else str(y_val)
                },
                "multiplicateur_lagrange": float(lam_val) if lam_val.is_number else str(lam_val),
                "valeur_fonction": float(h_val) if h_val.is_number else str(h_val)
            }
            details.append(detail)
        
        return OptimizationResponse(
            success=True,
            points_critiques=details,
            classification="Optimum sous contrainte trouvé",
            message="Optimisation avec contrainte réussie",
            details={"nombre_solutions": len(details)}
        )
    
    except Exception as e:
        return OptimizationResponse(
            success=False,
            message=f"Erreur: {str(e)}"
        )

@app.post("/optimize", response_model=OptimizationResponse)
async def optimize(request: OptimizationRequest):
    """Endpoint principal pour l'optimisation"""
    
    if request.type_optimization == "sans_contrainte":
        return optimisation_sans_contrainte(request.fonction)
    
    elif request.type_optimization == "avec_contrainte":
        if not request.contrainte:
            return OptimizationResponse(
                success=False,
                message="Contrainte requise pour l'optimisation avec contrainte"
            )
        return optimisation_avec_contrainte(request.fonction, request.contrainte)
    
    else:
        return OptimizationResponse(
            success=False,
            message="Type d'optimisation invalide"
        )

@app.get("/health")
async def health():
    """Vérifier que le serveur est actif"""
    return {"status": "ok"}
