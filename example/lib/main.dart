import 'package:custom_text_field_with_drop_down/custom_text_field_with_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import the Get package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Custom Text Field and Dropdown"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 30),

              /// text filed with fill color and without border color
              CustomTextFieldWithDropDown(
                controller: _controller,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter confirm password",
                prefixIcon: Icons.person_3_outlined,
                showObscure: false,
              ),

              SizedBox(height: 30),

              /// text filed with fill color and without border color
              CustomTextFieldWithDropDown(
                iconColor: Colors.red,
                suffixIcon: Icon(Icons.insert_emoticon_sharp),
                controller: _controller,
                fillColor: Colors.cyan,
                borderColor: Colors.transparent,
                hintText: "Enter confirm password",
                prefixIcon: Icons.person_3_outlined,
                showObscure: false,
              ),

              SizedBox(height: 30),

              /// text filed with fill color
              CustomTextFieldWithDropDown(
                controller: _controller,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.green,
                hintText: "Enter confirm password",
                showObscure: true,
              ),

              SizedBox(height: 30),

              /// read only text filed and max line also the border radius
              CustomTextFieldWithDropDown(
                borderRadius: 1.0,
                maxLines: 4,
                readOnly: true,
                controller: _controller,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.green,
                hintText: "Enter confirm password",
                showObscure: false,
              ),
              SizedBox(height: 30),
              CustomTextFieldWithDropDown(
                fillGradient: LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                controller: _controller,
                borderColor: Colors.green,
                hintText: "Enter confirm password",
                showObscure: false,
              ),
              SizedBox(height: 30),
              CustomTextFieldWithDropDown(
                controller: _controller,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter your search",
                showObscure: false,
                dropdownShow: true,
                dropdownItems: [
                  "Apple",
                  "Banana",
                  "Cherry",
                  "Date",
                  "Grapes",
                ], // Static items
              ),
            ],
          ),
        ),
      ),
    );
  }
}
