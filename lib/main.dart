import 'package:advande_apkstatmangement/provider/news_provider.dart';
import 'package:advande_apkstatmangement/provider/theme_provider.dart';
import 'package:advande_apkstatmangement/screens/news_screen.dart';
import 'package:advande_apkstatmangement/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
 const MyApp({super.key});


  @override
  Widget build(BuildContext context){
    return  MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (context)=>ThemeProvider()),
    ChangeNotifierProvider(create: (_) => NewsProvider()), 
    ],
    child: Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      themeMode: themeProvider.themeMode, // ✅ clean

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      home: SplashScreen(),
    );
  },
),
    );
    
     
  }
}