part of styles;

class DefaultBtnStyles {

  static const buttonTheme = ButtonThemeData(
    disabledColor: Color.fromRGBO(202, 212, 248, 1),
  );

  static final textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.only(left: 3, right: 3)),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashFactory: NoSplash.splashFactory,
    ),
  );

  static final elevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.maxFinite)),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(const EdgeInsets.only(top: 13, bottom: 13)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(23))),
      )
  );

}