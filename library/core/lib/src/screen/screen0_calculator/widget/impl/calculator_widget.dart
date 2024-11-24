import 'package:core/src/app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:local_hero/local_hero.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:simple_animations/simple_animations.dart';

import 'button_area_widget.dart';
import 'button_values.dart';
import 'calculator_button.dart';
import 'calculator_buttons.dart';

class CalculatorWidget extends StatefulWidget {
  final VoidCallback onPressNext;
  const CalculatorWidget({super.key, required this.onPressNext});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String input = '';
  String output = '';
  List<String> calculationHistory = [];
  CalculatorButtonsMode screenMode = CalculatorButtonsMode.usual;

  void onButtonClick(String context, BuildContext buildContext) {
    if (context == "C") {
      input = '';
      output = '';
    } else if (context == "()") {
      // Toggle between "(" and ")"
      if (input.endsWith("(")) {
        input = "${input.substring(0, input.length - 1)})";
      } else if (input.endsWith(")")) {
        input = "${input.substring(0, input.length - 1)}(";
      } else {
        if (input.isNotEmpty && !RegExp(r'[0-9.]$').hasMatch(input)) {
          input += "(";
        } else {
          input += ")";
        }
      }
    } else if (context == "=") {
      // Check if parentheses are balanced before evaluating the expression
      if (areParenthesesBalanced(input)) {
        try {
          var userInput = input;

          // Handle percentage operation first
          userInput = userInput.replaceAllMapped(
            RegExp(r'(\d+(?:\.\d+)?)\s*%\s*(\+|\-|\*|\/|$)'),
            (match) {
              var value = double.parse(match.group(1)!);
              var operator = match.group(2) ?? '';
              return (value / 100).toString() + operator;
            },
          );

          // Updated logic for handling negative numbers
          userInput = userInput.replaceAllMapped(
            RegExp(r'(?<=\d)\s*(-)\s*(?=\d)'),
            (match) => match.group(0)!.contains('-') ? '-' : '+',
          );

          // Ensure that "÷" is replaced with "/" and "×" is replaced with "*"
          userInput = userInput.replaceAll('÷', '/');
          userInput = userInput.replaceAll('×', '*');

          // Check if the input exceeds 15 digits
          if (getDigitCount(userInput) > 15) {
            // Display a pop-up notifying the user
            showDigitLimitExceededDialog(buildContext);
            return;
          }

          Parser p = Parser();
          Expression expression = p.parse(userInput);
          ContextModel cm = ContextModel();
          var finalValue = expression.evaluate(EvaluationType.REAL, cm);
          output = formatNumber(finalValue.toString());

          if (output == "934") {
            Future.delayed(const Duration(milliseconds: 300), () {
              setState(() {
                if (screenMode == CalculatorButtonsMode.usual) {
                  Di.audioPlayer.play();
                  screenMode = CalculatorButtonsMode.magic;
                } else {
                  screenMode = CalculatorButtonsMode.usual;
                }
              });
            });
          } else if (output == "111") {
            Future.delayed(const Duration(milliseconds: 300), () {
              Di.routeMediator.goRewards();
            });
          }

          // Format the input with periods as thousands separators
          input = formatNumber(userInput);

          // Add the expression to the calculation history
          calculationHistory.add("$input = $output");
        } catch (e) {
          // Handle parsing or evaluation errors
          output = 'Error';
          input = '';
        }
      } else {
        // Handle the case when parentheses are not balanced
        output = 'Error';
        input = '';
      }
    } else if (context == "+/-") {
      // ... (existing code)
    } else if (context == "%") {
      // Handle percentage button
      if (input.isNotEmpty && RegExp(r'[0-9.]$').hasMatch(input)) {
        input += "%";
      }
    } else {
      // Handle numeric input
      if (context == "." && input.contains(".")) {
        // Prevent entering multiple decimal points
        return;
      }

      if (context == "÷") {
        // Handle division symbol
        input += "÷";
      } else if (context == "×") {
        // Handle multiplication symbol
        input += "×";
      } else {
        // Avoid replacing special characters

        // Check if adding the new character will exceed 15 digits
        if (getDigitCount(input + context) > 15) {
          // Display a pop-up notifying the user
          showDigitLimitExceededDialog(buildContext);
          return;
        }

        input += context;
      }
    }

    setState(() {});
  }

  int getDigitCount(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '').length;
  }

  void showDigitLimitExceededDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Digit Limit Exceeded"),
          content: const Text("You can input numbers with a maximum of 15 digits."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.black, // Set button text color to black
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String getLastNumber(String input) {
    var reversedInput = input.split('').reversed.join();
    var match = RegExp(r'^[0-9.,]+$').firstMatch(reversedInput);
    return match?.group(0)?.split('').reversed.join('') ?? '';
  }

  // Inside _CalculatorScreenState class
  String formatNumber(String numberString) {
    // Replace "/" with "÷" and "*" with "×"
    var formattedNumber = numberString.replaceAll('/', '÷').replaceAll('*', '×');

    // Check if the number is an integer
    if (formattedNumber.contains('.') && double.tryParse(formattedNumber)! % 1 == 0) {
      // Remove decimal part for integers
      formattedNumber = formattedNumber.replaceAll(RegExp(r'\.0$'), '');
    }

    return formattedNumber;
  }

  bool areParenthesesBalanced(String input) {
    int count = 0;
    for (var char in input.runes) {
      if (String.fromCharCode(char) == '(') {
        count++;
      } else if (String.fromCharCode(char) == ')') {
        count--;
      }
      if (count < 0) {
        return false; // Mismatched closing parenthesis
      }
    }
    return count == 0; // Parentheses are balanced if count is zero
  }

  bool isMagicMode() {
    return screenMode != CalculatorButtonsMode.usual;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: !isMagicMode()
              ? Container(
                  width: screenSize.width * 0.9,
                  margin: const EdgeInsets.only(top: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0XFFF4EAE0),
                  ),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        reverse: true,
                        child: Container(
                          width: screenSize.width * 0.9,
                          padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.bottomRight,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.bottomRight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0XFFF4EAE0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: screenSize.width * 0.9,
                                      height: 35,
                                      child: Text(
                                        input,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    if (output != "934")
                                      SizedBox(
                                        width: screenSize.width * 0.9,
                                        child: Text(
                                          output,
                                          style: const TextStyle(
                                            fontSize: 50,
                                            height: 0.9,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isMagicMode())
                        if (output == "934")
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 42),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const LocalHero(
                                  tag: "r9",
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 50,
                                        height: 0.9,
                                        color: Colors.black,
                                        decoration: null,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      child: Text(
                                        "9",
                                      ),
                                    ),
                                  ),
                                ),
                                const LocalHero(
                                  tag: "r3",
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 50,
                                        height: 0.9,
                                        color: Colors.black,
                                        decoration: null,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      child: Text(
                                        "3",
                                      ),
                                    ),
                                  ),
                                ),
                                const LocalHero(
                                  tag: "r4",
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 50,
                                        height: 0.9,
                                        color: Colors.black,
                                        decoration: null,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      child: Text(
                                        "4",
                                      ),
                                    ),
                                  ),
                                ),
                                LocalHero(
                                  tag: "line",
                                  child: Container(color: Colors.black, width: 0, height: 0),
                                ),
                              ],
                            ),
                          ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        left: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (!isMagicMode())
                              LocalHero(
                                tag: "history",
                                child: ElevatedButton(
                                  onPressed: () {
                                    showHistoryDialog(context);
                                  },
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all(const CircleBorder()),
                                    padding: WidgetStateProperty.all(
                                        const EdgeInsets.only(left: 5, right: 8, top: 7, bottom: 5)),
                                    backgroundColor: WidgetStateProperty.all(Colors.white70), // <-- Button color
                                    foregroundColor: WidgetStateProperty.all(Colors.black),
                                    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                      if (states.contains(WidgetState.pressed))
                                        return Colors.black12; // <-- Splash color
                                    }),
                                  ),
                                  child: const Icon(Icons.history),
                                ),
                              ),
                            if (isMagicMode()) Container(),
                            // TextButton(
                            //     onPressed: () {
                            //       setState(() {
                            //         if (screenMode == CalculatorButtonsMode.usual) {
                            //           screenMode = CalculatorButtonsMode.magic1Part;
                            //         } else {
                            //           screenMode = CalculatorButtonsMode.usual;
                            //         }
                            //         if (isMagicMode()) {
                            //           Future.delayed(const Duration(milliseconds: 1500), () {
                            //             ezAnimation.start();
                            //             setState(() {
                            //               screenMode = CalculatorButtonsMode.magic2Part;
                            //             });
                            //           });
                            //         }
                            //       });
                            //     },
                            //     child: const Text('Move')),
                            if (isMagicMode()) Container(),
                            if (!isMagicMode())
                              LocalHero(
                                tag: "delete",
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (input.isNotEmpty) {
                                      input = input.substring(0, input.length - 1);
                                      setState(() {});
                                    }
                                  },
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all(const CircleBorder()),
                                    padding: WidgetStateProperty.all(
                                        const EdgeInsets.only(left: 5, right: 8, top: 7, bottom: 5)),
                                    backgroundColor: WidgetStateProperty.all(Colors.white70), // <-- Button color
                                    foregroundColor: WidgetStateProperty.all(Colors.black),
                                    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                      if (states.contains(WidgetState.pressed)) {
                                        return Colors.black12; // <-- Splash color
                                      }
                                    }),
                                  ),
                                  child: const Icon(Icons.backspace_outlined),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ))
              : PlayAnimationBuilder<Movie>(
                  duration: const Duration(seconds: 3),
                  tween: MovieTween()
                    ..scene(begin: const Duration(milliseconds: 0), end: const Duration(milliseconds: 1000))
                        .tween('width', Tween(begin: 150.0, end: 500.0))
                    ..scene(begin: const Duration(milliseconds: 0), end: const Duration(seconds: 3))
                        .tween('alpha', Tween<double>(begin: 250, end: 0))
                    ..scene(begin: const Duration(milliseconds: 0), end: const Duration(seconds: 3)).tween(
                        'color',
                        ColorTween(
                            begin: const Color(0XFFF4EAE0), end: const Color(0XFFF4EAE0))), //Colors.transparent)),
                  builder: (context, value, _) {
                    return Container(
                        width: screenSize.width * 0.9,
                        margin: const EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0XFFF4EAE0).withAlpha(value.get('alpha').toInt()),
                        ));
                  }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CalculatorButtons(
            onPressNext: widget.onPressNext,
            width: screenSize.width,
            height: (screenSize.width * 5 / 4.19),
            mode: screenMode,
            children: [
              ...ButtonArea1.values.map(
                (e) => ButtonAreaWidget(
                  area: e,
                  child: LocalHero(
                    tag: 'btn_${e.text}',
                    key: ValueKey('btn_${e.text}'),
                    child: SizedBox(
                      width: isMagicMode() ? screenSize.width / 5 : screenSize.width / 4.19,
                      height: isMagicMode() ? screenSize.width / 5 : screenSize.width / 4.19,
                      child: CalculatorButton(
                        text: e.text,
                        color: e.color,
                        textColor: e.textColor,
                        isMagicMode: isMagicMode(),
                        onButtonClick: onButtonClick,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            alignment: Alignment.center,
            child: const Text("Calculation History", style: TextStyle(fontSize: 20)),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: calculationHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(calculationHistory[index]),
                );
              },
            ),
          ),
          backgroundColor: const Color(0xFFF4F6F0), // Set background color
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFCB935F).withOpacity(0.83), // Set the container color
                    borderRadius: BorderRadius.circular(20), // Set border radius
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Clear history
                      setState(() {
                        calculationHistory.clear();
                      });
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black, // Set button text color
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Clear History"),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFCB935F).withOpacity(0.83), // Set the container color
                    borderRadius: BorderRadius.circular(20), // Set border radius
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black, // Set button text color
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Close"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class ScrollViewWithHeight extends StatelessWidget {
  final Widget? child;

  const ScrollViewWithHeight({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: child,
        ),
      );
    });
  }
}
