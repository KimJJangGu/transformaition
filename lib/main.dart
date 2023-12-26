import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '단위 변환기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LengthConverter(),
    );
  }
}

class LengthConverter extends StatefulWidget {
  const LengthConverter({super.key});

  @override
  _LengthConverterState createState() => _LengthConverterState();
}

class _LengthConverterState extends State<LengthConverter> {
  TextEditingController lengthController = TextEditingController();
  double length = 0;
  String result = "";
  String fromUnit = "mm";
  String toUnit = "mm";

  final List<String> units = ["mm", "cm", "m", "km", "in", "ft", "yd", "mile"];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    lengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('길이 변환'),
      ),
      body: Column(
        children: [
          Image.asset('assets/body_back/abstract.jpg', fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                TextField(
                  controller: lengthController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      length = double.tryParse(value) ?? 0;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: '길이 입력',
                    hintText: '길이를 입력하세요',
                  ),
                  style: const TextStyle(fontSize: 20),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: fromUnit,
                        onChanged: (value) {
                          setState(() {
                            fromUnit = value!;
                          });
                        },
                        items: units.map<DropdownMenuItem<String>>((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(
                              unit,
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: toUnit,
                        onChanged: (value) {
                          setState(() {
                            toUnit = value!;
                          });
                        },
                        items: units.map<DropdownMenuItem<String>>((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(
                              unit,
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                ElevatedButton(
                  onPressed: () {
                    convertLength();
                  },
                  child: const Text('변환', style: TextStyle(fontSize: 16)),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Text(
                  '결과: $result',
                  style: const TextStyle(fontSize: 16),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      resetValues();
                    },
                    child: const Text('초기화', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void convertLength() {
    double resultValue = length;
    // Convert to meters first
    resultValue = convertToMeter(resultValue, fromUnit);
    // Convert from meters to the target unit
    resultValue = convertFromMeter(resultValue, toUnit);

    setState(() {
      result = '$resultValue $toUnit';
    });
  }

  void resetValues() {
    // 초기화 버튼 누르면 입력, 출력한 값 초기화
    setState(() {
      lengthController.clear();
      length = 0;
      result = "";
      fromUnit = "mm";
      toUnit = "mm";
    });
  }

  double convertToMeter(double value, String unit) {
    switch (unit) {
      case "mm":
        return value / 1000;
      case "cm":
        return value / 100;
      case "m":
        return value;
      case "km":
        return value * 1000;
      case "in":
        return value * 0.0254;
      case "ft":
        return value * 0.3048;
      case "yd":
        return value * 0.9144;
      case "mile":
        return value * 1609.34;
      default:
        return value;
    }
  }

  double convertFromMeter(double value, String unit) {
    switch (unit) {
      case "mm":
        return value * 1000;
      case "cm":
        return value * 100;
      case "m":
        return value;
      case "km":
        return value / 1000;
      case "in":
        return value / 0.0254;
      case "ft":
        return value / 0.3048;
      case "yd":
        return value / 0.9144;
      case "mile":
        return value / 1609.34;
      default:
        return value;
    }
  }
}
