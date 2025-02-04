import 'package:flutter/material.dart';

class topImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 4,
                      decoration:  BoxDecoration 
    (
      color: const Color.fromARGB(255, 0, 0, 0),
      image: DecorationImage(
        image: AssetImage(),
        fit: BoxFit.fill,
      ),
    )
  ,
                      padding: const EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CAREER\n\t\t\t\t\tMODE FILTER",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 254, 254, 254),
                              fontSize: 34,
                              fontWeight: FontWeight.normal,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
  


  }}
