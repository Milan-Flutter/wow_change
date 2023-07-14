import 'package:flutter/material.dart';

Color main_color = Color(0xffE32753);
Color s_color = Color(0xffFF85A6);
Color bg_color = Color(0xffFFE8EB);
Color s1=Color(0xff4F008C);
Color s2=Color(0xff9C2CF3);

Color font=Colors.white;
Color bg=Colors.black;

var grd=LinearGradient(
  colors: [
    s2,
    main_color,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
var b1=LinearGradient(
  colors: [
    s1,
    s2,

  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
var b4=LinearGradient(
  colors: [
    Color(0xffE32753),
    s2,

  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
var b5=LinearGradient(
  colors: [
   s2.withOpacity(.4),
    s2.withOpacity(.4),

  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
var b6=LinearGradient(
  colors: [

    s2,
    Color(0xffE32753),


  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
var b3=LinearGradient(
  colors: [
    s1,
    s2,

  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
var b2=LinearGradient(
  colors: [
    Color(0xffE32753),
    s2,

  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);