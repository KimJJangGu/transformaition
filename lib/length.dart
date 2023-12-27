import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LengthConverter extends StatefulWidget {
  const LengthConverter({super.key});

  @override
  _LengthConverterState createState() => _LengthConverterState();
}

class _LengthConverterState extends State<LengthConverter> {
  TextEditingController lengthController = TextEditingController();
  double length = 0;
  String fromUnit = "mm";
  final List<String> _transResult = [];

  final List<String> units = ["mm", "cm", "m", "km", "in", "ft", "yd", "mile"];

  @override
  void dispose() {
    lengthController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 초기 화면에서 결과창을 전시
    convertLength();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('길이 변환'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: lengthController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      length = double.tryParse(value) ?? 0;
                      // 숫자를 입력 할 때 결과 값이 전시되게 하기
                      convertLength();
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
                            convertLength();
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
                  padding: EdgeInsets.all(8.0),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 230,
                  child: ListView(
                    children: _transResult.map((result) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 결과 값 오른쪽으로 이동
                          Text(
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            (result),
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                          ),
                          // 구분선 용도 밑 줄 추가, 밑줄 간격, 색상
                          const Divider(height: 4, color: Colors.black12),
                        ],
                      );
                    }).toList(),
                  ),
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
          Expanded(
            child: Image.asset(
              'assets/body_back/ladder.png',
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }

  void convertLength() {
    _transResult.clear();
    // 숫자를 입력하지 않았을 때에는 단위만 표시
    if (length == 0) {
      _transResult.addAll(units.map((unit) => unit));
    } else {
      for (String toUnit in units) {
        double resultValue = length;
        resultValue = convertToMeter(resultValue, fromUnit);
        resultValue = convertFromMeter(resultValue, toUnit);
        _transResult.add('${formatNumber(resultValue)} $toUnit');
      }
    }
  }

  String formatNumber(double resultNum) {
    // 천 단위마다 쉼표 추가하기
    return NumberFormat('###,###').format(resultNum);
  }

  void resetValues() {
    setState(() {
      lengthController.clear();
      length = 0;
      _transResult.clear();
    });
    // 결과 창을 계속 남아있게 하기
    convertLength();
  }
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
