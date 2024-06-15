import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  Color myColor = Colors.transparent;
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController mainResultController = TextEditingController();
  String bmiCategory = '';

  void calculateBMI(String weight, String height) {
    var weightDouble = double.tryParse(weight) ?? 0.0;
    var heightDouble = double.tryParse(height) ?? 0.0;

    if (weightDouble <= 0 || heightDouble <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid weight and height values.'),
        ),
      );
      return;
    }

    var result = weightDouble / ((heightDouble / 100) * (heightDouble / 100));

    setState(() {
      mainResultController.text = result.toStringAsFixed(2);
      if (result < 18.5) {
        myColor = const Color(0xFF87B1D9);
        bmiCategory = "Underweight";
      } else if (result >= 18.5 && result <= 24.9) {
        myColor = const Color(0xFF3DD365);
        bmiCategory = "Normal";
      } else if (result >= 25 && result <= 29.9) {
        myColor = const Color(0xFFEEE133);
        bmiCategory = "Overweight";
      } else if (result >= 30 && result <= 34.9) {
        myColor = const Color(0xFFFD802E);
        bmiCategory = "Obese";
      } else if (result >= 35) {
        myColor = const Color(0xFFF95353);
        bmiCategory = "Extreme";
      }
    });
  }

  void clearFields() {
    setState(() {
      ageController.clear();
      weightController.clear();
      heightController.clear();
      mainResultController.clear();
      myColor = Colors.transparent;
      bmiCategory = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Text(
                "BMI CALCULATOR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8805FF),
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: width * 0.5,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextField(
                  controller: ageController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your Age ",
                  ),
                ),
              ),
              Container(
                width: width * 0.5,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextField(
                  controller: weightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your weight (kg)",
                  ),
                ),
              ),
              Container(
                width: width * 0.5,
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextField(
                  controller: heightController,
                  autofocus: false,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your height (cm)",
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (mainResultController.text.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(-100, 0),
                      child: Container(
                        height: 200, // Fixed height to display all the information without scrolling
                        width: width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Age: ${ageController.text}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Height: ${heightController.text} cm',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Weight: ${weightController.text} kg',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'BMI: ${mainResultController.text}',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: myColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Icon(
                            bmiCategory == "Underweight" ? Icons.arrow_downward :
                            bmiCategory == "Normal" ? Icons.arrow_forward :
                            bmiCategory == "Overweight" ? Icons.arrow_upward :
                            bmiCategory == "Obese" ? Icons.arrow_forward :
                            Icons.warning,
                            size: 50,
                            color: Colors.white
                          ),
                        ),
                        Text(bmiCategory, style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: width * 0.2,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (ageController.text.isNotEmpty &&
                            weightController.text.isNotEmpty &&
                            heightController.text.isNotEmpty) {
                          calculateBMI(weightController.text, heightController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill all the fields.'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF0038FF)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.2,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: clearFields,
                      child: Text(
                        "Clear",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFF87B1D9),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Icon(Icons.arrow_downward, size: 40, color: Colors.white),
                      ),
                      Text("Underweight", style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3DD365),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Icon(Icons.arrow_forward, size: 40, color: Colors.white),
                      ),
                      Text("Normal", style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEE133),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Icon(Icons.arrow_upward, size: 40, color: Colors.white),
                      ),
                      Text("Overweight", style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFD802E),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Icon(Icons.arrow_forward, size: 40, color: Colors.white),
                      ),
                      Text("Obese", style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF95353),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Icon(Icons.warning, size: 40, color: Colors.white),
                      ),
                      Text("Extreme", style: TextStyle(fontSize: 15)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BMICalculator(),
  ));
}
