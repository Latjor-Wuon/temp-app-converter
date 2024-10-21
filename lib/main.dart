import 'package:flutter/material.dart';

void main() {
  runApp(const TempConverterApp());
}

class TempConverterApp extends StatelessWidget {
  const TempConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TempConverterScreen(),
    );
  }
}

class TempConverterScreen extends StatefulWidget {
  const TempConverterScreen({super.key});

  @override
  _TempConverterScreenState createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  String _conversionType = 'F to C';
  double? _inputValue;
  double? _convertedValue;

  // Marking _history as final because the list reference doesn't change
  final List<String> _history = [];

  final TextEditingController _controller = TextEditingController();

  void _convertTemperature() {
    if (_inputValue != null) {
      double result;
      if (_conversionType == 'F to C') {
        result = (_inputValue! - 32) * 5 / 9;
      } else {
        result = _inputValue! * 9 / 5 + 32;
      }
      setState(() {
        _convertedValue = double.parse(result.toStringAsFixed(2));
        _history.add('$_conversionType: ${_inputValue!.toStringAsFixed(1)} => $_convertedValue');
      });
    }
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Temperature',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _inputValue = double.tryParse(value);
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'F to C',
                      groupValue: _conversionType,
                      onChanged: (value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                    const Text('Fahrenheit to Celsius'),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: 'C to F',
                      groupValue: _conversionType,
                      onChanged: (value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                    const Text('Celsius to Fahrenheit'),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _convertTemperature,
                  child: const Text('Convert'),
                ),
                const SizedBox(height: 20),
                if (_convertedValue != null)
                  Text(
                    'Converted Value: $_convertedValue',
                    style: const TextStyle(fontSize: 20),
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Conversion History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_history[index]),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _clearHistory,
                  child: const Text('Clear History'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}