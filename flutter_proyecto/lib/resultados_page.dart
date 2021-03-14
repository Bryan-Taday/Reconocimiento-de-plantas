import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultadosPage extends StatefulWidget {
  final String email;
  ResultadosPage({Key key, @required this.email}) : super(key: key);
  @override
  _ResultadosPageState createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  final List<Map<dynamic, dynamic>> lists = [];
  final ScrollController _scrollController = new ScrollController();
  CollectionReference resultados;

  @override
  void initState() {
    this.resultados = FirebaseFirestore.instance.collection('Usuarios').doc(widget.email).collection('results');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Reconocimiento de plantas',
              style: TextStyle(fontSize: 25),
            ),
            _createInfoFirestore(),
            //_createInfoDatabaseRealtime(),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            this.resultados = FirebaseFirestore.instance
                .collection('Usuarios')
                .doc(email)
                .collection('results');
          });
        },
        child: Icon(Icons.refresh),
      ),*/
    );
  }

  Widget _createInfoFirestore() {
    return Container(
      child: FutureBuilder(
          future: resultados.get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              lists.clear();
              snapshot.data.docs.forEach((element) {
                lists.add(element.data());
              });
              return new ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: lists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _cards(lists[index]);
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }

  Widget _cards(listResult) {
    final card = Container(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(listResult['imagen']),
            placeholder: AssetImage('assets/images/loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          Container(
              padding: EdgeInsets.all(10.0), child: Text(listResult['nombre']))
        ],
      ),
    );
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 10.0))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: card,
      ),
    );
  }
}
