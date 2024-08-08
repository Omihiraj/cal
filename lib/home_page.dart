import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayValue = "";
  String calculationValue = "";
  bool isReplace = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  //prefs.clear();
                  int count = prefs.getInt("count")!;
                  List<ListTile> calHistory = [];
                  for (int i = 1; i < count; i++) {
                    print(prefs.getString("val_$i"));
                    calHistory.add(
                      ListTile(
                        title: Text(
                          "${prefs.getString("val_$i")}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        tileColor: Colors.green,
                      ),
                    );
                  }

                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(10),
                      child: ListView(children: calHistory),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.history,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              Text(
                calculationValue,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                displayValue,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      calculatorButton(buttonName: "mc"),
                      calculatorButton(buttonName: "C"),
                      calculatorButton(buttonName: "7"),
                      calculatorButton(buttonName: "4"),
                      calculatorButton(buttonName: "1"),
                      calculatorButton(buttonName: "%"),
                    ],
                  ),
                  Column(
                    children: [
                      calculatorButton(buttonName: "m+"),
                      calculatorButton(buttonName: "X"),
                      calculatorButton(buttonName: "8"),
                      calculatorButton(buttonName: "5"),
                      calculatorButton(buttonName: "2"),
                      calculatorButton(buttonName: "0"),
                    ],
                  ),
                  Column(
                    children: [
                      calculatorButton(buttonName: "m-"),
                      calculatorButton(buttonName: "/", isOperatorButton: true),
                      calculatorButton(buttonName: "9"),
                      calculatorButton(buttonName: "6"),
                      calculatorButton(buttonName: "3"),
                      calculatorButton(buttonName: "."),
                    ],
                  ),
                  Column(
                    children: [
                      calculatorButton(buttonName: "mr"),
                      calculatorButton(buttonName: "*", isOperatorButton: true),
                      calculatorButton(buttonName: "-", isOperatorButton: true),
                      calculatorButton(buttonName: "+", isOperatorButton: true),
                      calculatorButton(
                          buttonName: "=",
                          isEqualButton: true,
                          isOperatorButton: true),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }

  void checkLogic({required String buttonName}) {
    setState(() {
      if (buttonName == "C") {
        setState(() {
          displayValue = "";
          calculationValue = "";
          isReplace = false;
        });
      } else if (buttonName == "X") {
        displayValue = displayValue.substring(0, displayValue.length - 1);
      } else if (buttonName == "=") {
        if (calculationValue.endsWith("+") ||
            calculationValue.endsWith("-") ||
            calculationValue.endsWith("*") ||
            calculationValue.endsWith("/")) {
          String operatorValue = calculationValue[calculationValue.length - 1];
          num firstValue = num.parse(
              calculationValue.substring(0, calculationValue.length - 1));
          num secondValue = num.parse(displayValue);
          num? result;
          if (operatorValue == "+") {
            calculationValue = "$firstValue $operatorValue $secondValue =";
            result = firstValue + secondValue;
            displayValue = result.toString();
          } else if (operatorValue == "-") {
            calculationValue = "$firstValue $operatorValue $secondValue =";
            result = firstValue - secondValue;
            displayValue = result.toString();
          } else if (operatorValue == "*") {
            calculationValue = "$firstValue $operatorValue $secondValue =";
            result = firstValue * secondValue;
            displayValue = result.toString();
          } else if (operatorValue == "/") {
            calculationValue = "$firstValue $operatorValue $secondValue =";
            result = firstValue / secondValue;
            displayValue = result.toString();
          }
          saveData();
        }
      } else if (buttonName == "*" ||
          buttonName == "/" ||
          buttonName == "-" ||
          buttonName == "+") {
        setState(() {
          if (displayValue.isNotEmpty && calculationValue.isEmpty) {
            calculationValue = displayValue + buttonName;
          } else if (calculationValue.isNotEmpty) {
            String operatorValue =
                calculationValue[calculationValue.length - 1];
            num firstValue = num.parse(
                calculationValue.substring(0, calculationValue.length - 1));
            num secondValue = num.parse(displayValue);
            num? result;

            if (operatorValue == "+") {
              result = firstValue + secondValue;
              displayValue = result.toString();

              calculationValue = "$result $buttonName";
            } else if (operatorValue == "-") {
              result = firstValue - secondValue;
              displayValue = result.toString();
              calculationValue = "$result $buttonName";
            } else if (operatorValue == "*") {
              result = firstValue * secondValue;
              displayValue = result.toString();
              calculationValue = "$result $buttonName";
            } else if (operatorValue == "/") {
              result = firstValue / secondValue;
              displayValue = result.toString();
              calculationValue = "$result $buttonName";
            }
            isReplace = false;
          }
        });
      } else if (int.tryParse(buttonName) != null) {
        String? lastCharacterOfCalculationVal;
        if (calculationValue.isNotEmpty) {
          lastCharacterOfCalculationVal =
              calculationValue[calculationValue.length - 1];
          if (lastCharacterOfCalculationVal == "+" ||
              lastCharacterOfCalculationVal == "-" ||
              lastCharacterOfCalculationVal == "*" ||
              lastCharacterOfCalculationVal == "/") {
            if (isReplace) {
              displayValue = displayValue + buttonName;
            } else {
              displayValue = buttonName;
              isReplace = true;
            }
          } else if (calculationValue.endsWith("=")) {
            calculationValue = "";
            displayValue = buttonName;
            isReplace = false;
          }
        } else {
          displayValue = displayValue + buttonName;
        }
      }
    });
  }

  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int valueCount = 1;

    if (prefs.containsKey("count")) {
      valueCount = prefs.getInt("count")!;

      prefs.setInt("count", valueCount + 1);
    } else {
      prefs.setInt("count", 1);
    }

    prefs.setString("val_$valueCount", "$calculationValue $displayValue");
  }

  Padding calculatorButton(
      {required String buttonName,
      bool isEqualButton = false,
      bool isOperatorButton = false}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          checkLogic(buttonName: buttonName);
        },
        child: Container(
          width: 60,
          height: isEqualButton ? 128 : 60,
          decoration: BoxDecoration(
            color: isOperatorButton ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              buttonName,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
