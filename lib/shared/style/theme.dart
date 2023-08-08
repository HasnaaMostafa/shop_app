import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
              primarySwatch: Colors.purple,
              floatingActionButtonTheme:
              const FloatingActionButtonThemeData(
                  backgroundColor: Colors.purple
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20,
                  iconTheme: IconThemeData(
                    color: Colors.purple,

                  ),
                  titleTextStyle:TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ) ,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.purple,
                      statusBarIconBrightness: Brightness.light
                  )

              ),
              bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.purple,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
                elevation: 30.0,
              ),
              textTheme: const TextTheme(
                bodySmall: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ) ,
              ),
               fontFamily: "Jannah",

            );

ThemeData darkTheme = ThemeData(
              scaffoldBackgroundColor: HexColor("212121"),
              primarySwatch: Colors.purple,
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor:HexColor("212121") ,
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor("212121"),
                elevation: 0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,

                ),
                iconTheme: const IconThemeData(
                    color: Colors.white
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.purple,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.purple,
                elevation: 30.0,
                unselectedItemColor: Colors.grey,
                backgroundColor: HexColor("212121"),
              ),
              textTheme: const TextTheme(
                bodySmall: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ) ,
              ),
               fontFamily: "Jannah"
            );

