import 'package:flutter/material.dart';

typedef SearchInputOnFocusCallback = void Function();
typedef SearchInputOnSubmittedCallback = void Function(String value);
typedef SearchInputTextChangedCallback = void Function(String value);

class SearchInputWidget extends StatelessWidget {
  ///回调函数
  SearchInputOnFocusCallback onTap;
  SearchInputOnSubmittedCallback onSubmitted;
  SearchInputTextChangedCallback onTextChanged;

  SearchInputWidget({this.onTap, this.onSubmitted, this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      onSubmitted: onSubmitted,
      onChanged: onTextChanged,
      autofocus: false,
      decoration: InputDecoration(
          hintText: '搜索实验室',
          filled: true,
          fillColor: Color.fromARGB(255, 240, 240, 240),
          contentPadding: EdgeInsets.only(left: 0),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black26,
          )),
    );
  }
}
