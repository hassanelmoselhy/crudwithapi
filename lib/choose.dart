import 'package:crud/addpost.dart';
import 'package:crud/getAllpost.dart';
import 'package:flutter/material.dart';

class Choose extends StatefulWidget {
  const Choose({super.key});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: () {  
            Navigator.push(
              context, 
                MaterialPageRoute(builder: (context) => const Getallpost ()),

            );
           }, child:  Container( 
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ), 
            child: Center(child: Text('Get All Post', 
                    
           ),
           ) , 
            )  
            , 
            ) ,
            ElevatedButton(onPressed: () {  
            Navigator.push(
              context, 
                MaterialPageRoute(builder: (context) =>  Addpost ()),

            );
           }, child:  Container( 
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ), 
            child: Center(child: Text('Add Post',
                    
           ),
           ) , 
            )  
            , 
            ) 
        ]
      ),
     ),
   ) ; 
  }
}