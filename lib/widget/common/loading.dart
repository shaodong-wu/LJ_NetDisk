import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_loading/m_loading.dart';

class CustomLoading extends StatelessWidget {

  /// Loading 大小
  final double size;

  /// 内圈大小
  final double strokeWidth;

  const CustomLoading({
    Key? key,
    this.size = 20.0,
    this.strokeWidth = 5
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Ring2InsideLoading(
        strokeWidth: strokeWidth,
        color: const Color.fromRGBO(253, 83, 118, 1),
        backgroundColor: Colors.blue,
      ),
    );
  }}