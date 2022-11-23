import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Color greyColor = Colors.grey.shade300;
  Color textColor = Colors.grey.shade600;
  Color blueColor = Colors.blue.shade300;
  Color whiteColor = Colors.white;
  Color warningColor = Colors.grey.shade300;

  TextEditingController weightInput = TextEditingController();
  TextEditingController heightInput = TextEditingController();

  double result = 0;
  double weight = 0;
  double height = 0;
  String bmiResult = '';

  bool isEmpty = true;
  bool isPressed1 = false;
  bool isPressed2 = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){

    //for button press
    double blurRad1 = isPressed1 ? 10.0 : 20.0;
    double blurRad2 = isPressed2 ? 10.0 : 20.0;
    Offset spaceDistance1 = isPressed1 ? const Offset(3, 3) : const Offset(-5, -5);
    Offset spaceDistance2= isPressed2 ? const Offset(3, 3) : const Offset(-5, -5);

    //for constant box shadow
    double blurRad3 = 10.0;
    Offset spaceDistance3 = const Offset(3, 3);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: greyColor,
        appBar: AppBar(
          title: Text(
            'BMI Calculator',
            style: TextStyle(fontWeight: FontWeight.bold,color: textColor),
          ),
          centerTitle: true,
          backgroundColor: greyColor,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              //Result
              Container(
                  padding: const EdgeInsets.all(25.0),
                  width: double.maxFinite,
                  height: 150,
                  decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: blurRad3,
                          offset: spaceDistance3,
                          color: Colors.grey,
                        ),
                        BoxShadow(
                          blurRadius: blurRad3,
                          offset: -spaceDistance3,
                          color: Colors.white,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            result != 0 ? result.toStringAsFixed(1) : '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          Text(
                            bmiResult,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.circle,
                        color: warningColor,
                      ),
                    ],
                  )),
              const SizedBox(height: 30,),

              //TextField for Weight Input
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: blurRad3,
                      offset: spaceDistance3,
                      color: Colors.grey,
                    ),
                    BoxShadow(
                      blurRadius: blurRad3,
                      offset: -spaceDistance3,
                      color: Colors.white,
                    ),
                  ],
                ),
                child: TextField(
                  style: TextStyle(color: textColor, fontSize: 24),
                  controller: weightInput,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Weight in KG',
                    hintStyle: const TextStyle(color: Colors.grey),
                    labelText: 'Enter Your Weight',
                    labelStyle: TextStyle(color: textColor),
                    border: InputBorder.none,
                    suffix: Text(
                      'KG',
                      style: TextStyle(fontSize: 16,color: textColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),

              //TextField for Height Input
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
                decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: blurRad3,
                        offset: spaceDistance3,
                        color: Colors.grey,
                      ),
                      BoxShadow(
                        blurRadius: blurRad3,
                        offset: -spaceDistance3,
                        color: Colors.white,
                      ),
                    ]),
                child: TextField(
                  style: TextStyle(color: textColor, fontSize: 24),
                  controller: heightInput,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Height in Meters',
                    hintStyle: const TextStyle(color: Colors.grey),
                    labelText: 'Enter Your Height',
                    labelStyle: TextStyle(color: textColor),
                    border: InputBorder.none,
                    suffix: Text(
                      'Meters',
                      style: TextStyle(fontSize: 16,color: textColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              //Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Reset Button
                  Listener(
                    onPointerUp: (_) {
                      weightInput.clear();
                      heightInput.clear();
                      setState(() {
                        isPressed1 = true;
                        result = 0;
                        bmiResult = '';
                        warningColor = Colors.grey.shade300;
                      });
                    },
                    onPointerDown: (_){
                      setState(() {
                        isPressed1 = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: blurRad1,
                              offset: spaceDistance1,
                              color: Colors.grey,
                            ),
                            BoxShadow(
                              blurRadius: blurRad1,
                              offset: -spaceDistance1,
                              color: Colors.white,
                            ),
                          ]),
                      child: Center(
                          child: Text(
                        'Reset',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),

                  //Calculate Button
                  Listener(
                    onPointerUp: (_) {
                      setState(() {
                        isPressed2 = true;
                        if (weightInput.text.isNotEmpty) {
                          weight = double.parse(weightInput.text);
                          height = double.parse(heightInput.text);
                          result = (weight / (height * height));
                          if (result < 18.5) {
                            bmiResult = 'Underweight';
                            warningColor = Colors.yellow;
                          } else if (result < 25) {
                            bmiResult = 'Healthy Weight';
                            warningColor = Colors.green;
                          } else if (result < 30) {
                            bmiResult = 'Overweight';
                            warningColor = Colors.orange;
                          } else {
                            bmiResult = 'Obese';
                            warningColor = Colors.red;
                          }
                        } else {
                          bmiResult = 'No Data 😑';
                        }
                      });
                    },
                    onPointerDown: (_){
                      setState(() {
                        isPressed2 = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: blurRad2,
                              offset: spaceDistance2,
                              color: Colors.grey,
                            ),
                            BoxShadow(
                              blurRadius: blurRad2,
                              offset: -spaceDistance2,
                              color: Colors.white,
                            ),
                          ]),
                      child: Center(
                          child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
