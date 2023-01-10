import 'package:flutter/material.dart';

Image logoWidget(String   imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    height: 240,
    width: 240,
    color: Colors.white,
  );
}

  Widget buildTextField(String hintText,TextEditingController controller,Widget prefixIcon,bool Ispassword){
    return Center(
      child: SizedBox(
        width: 300,
        height: 45,
        child: TextField(
          style: TextStyle(
          ),
          cursorColor: Colors.black87,
          enableSuggestions: !Ispassword,
          obscureText: Ispassword,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 2),
              label: Text(hintText),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(fontFamily: "Montserrat"),
              filled: true,
              fillColor: Color(0xffdfecea).withOpacity(0.5),
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(style: BorderStyle.none,width: 0)
              )
          ),
        ),
      ),
    );
  }


