import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayValue = "";

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
                height: 150,
              ),
              const Text(
                "125*20",
                style: TextStyle(color: Colors.white, fontSize: 20),
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
                      calculatorButton(buttonName: ","),
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

  Padding calculatorButton(
      {required String buttonName,
      bool isEqualButton = false,
      bool isOperatorButton = false}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          setState(() {
            displayValue = displayValue + buttonName;
          });
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
