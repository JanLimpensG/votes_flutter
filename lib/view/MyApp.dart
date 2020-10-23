import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {

  List<String> lista = ['nombre 1', 'nombre 2', 'nombre 3'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voting App',
      home: new Scaffold(
        appBar: AppBar(
          title: Text(
            'Vote For a Project',
            style: GoogleFonts.pacifico(),
          ),

        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Project').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return Text('Loading...');
            if(snapshot.data.documents.length == 0)
            {
              return Center(
                child: Text('No Documents'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot data = snapshot.data.documents[index];
                return ListTile(
                  title: Text(
                    data['project_name'],
                  ),
                  subtitle: Text(
                    data['author'],
                  ),
                  trailing: Text(
                    data['votes'].toString(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}