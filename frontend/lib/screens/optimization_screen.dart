import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/optimization_model.dart';

class OptimizationScreen extends StatefulWidget {
  const OptimizationScreen({Key? key}) : super(key: key);

  @override
  State<OptimizationScreen> createState() => _OptimizationScreenState();
}

class _OptimizationScreenState extends State<OptimizationScreen> {
  late TextEditingController _fonctionController;
  late TextEditingController _contrainteController;
  String _typeOptimization = 'sans_contrainte';
  bool _isLoading = false;
  OptimizationResponse? _response;

  @override
  void initState() {
    super.initState();
    _fonctionController = TextEditingController();
    _contrainteController = TextEditingController();
  }

  @override
  void dispose() {
    _fonctionController.dispose();
    _contrainteController.dispose();
    super.dispose();
  }

  Future<void> _handleOptimize() async {
    if (_fonctionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer une fonction')),
      );
      return;
    }

    if (_typeOptimization == 'avec_contrainte' &&
        _contrainteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer une contrainte')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.optimize(
        fonction: _fonctionController.text,
        typeOptimization: _typeOptimization,
        contrainte: _typeOptimization == 'avec_contrainte'
            ? _contrainteController.text
            : null,
      );

      setState(() {
        _response = response;
        _isLoading = false;
      });

      if (!response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Optimisation'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type d'optimisation
            const Text(
              'Type d\'optimisation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Sans contrainte'),
                    value: 'sans_contrainte',
                    groupValue: _typeOptimization,
                    onChanged: (value) {
                      setState(() {
                        _typeOptimization = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Avec contrainte'),
                    value: 'avec_contrainte',
                    groupValue: _typeOptimization,
                    onChanged: (value) {
                      setState(() {
                        _typeOptimization = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Fonction
            const Text(
              'Fonction à optimiser',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _fonctionController,
              decoration: InputDecoration(
                hintText: 'Ex: x**2 + y**2',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              minLines: 2,
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            const Text(
              'Exemples:\n• x**2 + y**2 - 4*x*y\n• sin(x)*cos(y)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),

            // Contrainte (visible only if avec_contrainte)
            if (_typeOptimization == 'avec_contrainte') ...[
              const Text(
                'Contrainte',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _contrainteController,
                decoration: InputDecoration(
                  hintText: 'Ex: x + y - 1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
                minLines: 2,
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              const Text(
                'Exemples:\n• x + y - 1 = 0\n• x**2 + y**2 - 4',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Bouton
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleOptimize,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Optimiser',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 30),

            // Résultats
            if (_response != null) ...[
              _buildResultsSection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _response!.success ? Colors.green.shade50 : Colors.red.shade50,
            border: Border.all(
              color: _response!.success ? Colors.green : Colors.red,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                _response!.success ? Icons.check_circle : Icons.error,
                color: _response!.success ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(_response!.message),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (_response!.success) ...[
          const Text(
            'Classification',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _response!.classification,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Points critiques',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          if (_response!.pointsCritiques.isEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Aucun point critique trouvé'),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _response!.pointsCritiques.length,
              itemBuilder: (context, index) {
                final point = _response!.pointsCritiques[index];
                return _buildPointCard(point, index);
              },
            ),
        ],
      ],
    );
  }

  Widget _buildPointCard(PointCritique point, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Point critique ${index + 1}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              'Coordonnées',
              'x: ${_formatValue(point.point['x'])}, y: ${_formatValue(point.point['y'])}',
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              'Classification',
              point.classification,
              color: _getClassificationColor(point.classification),
            ),
            const SizedBox(height: 8),
            if (point.valeursPropes.isNotEmpty)
              _buildInfoRow(
                'Valeurs propres',
                point.valeursPropes.map((e) => e.toStringAsFixed(3)).join(', '),
              ),
            const SizedBox(height: 8),
            _buildInfoRow(
              'Valeur fonction',
              _formatValue(point.valeurFonction),
            ),
            if (point.multiplicateurLagrange != null) ...[
              const SizedBox(height: 8),
              _buildInfoRow(
                'Multiplicateur λ',
                _formatValue(point.multiplicateurLagrange),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: TextStyle(
            color: color || Colors.grey.shade700,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  String _formatValue(dynamic value) {
    if (value is double) {
      return value.toStringAsFixed(4);
    } else if (value is int) {
      return value.toString();
    } else if (value is String) {
      return value;
    }
    return value.toString();
  }

  Color _getClassificationColor(String classification) {
    if (classification.contains('Minimum')) {
      return Colors.green;
    } else if (classification.contains('Maximum')) {
      return Colors.orange;
    } else if (classification.contains('selle')) {
      return Colors.purple;
    }
    return Colors.grey;
  }
}
