import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'App Reciclagem',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_business_outlined),
              title: const Text('Lixo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/lixo');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: const [
            Text(
              "Bem-vindo ao projeto reciclagem!",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(" "),
            Text(
              "Desenvolvido por:",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 22),
            ),
            Text(" "),
            Text(
              "João Vitor Primieri Paludo - 182741",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20),
            ),
            Text(" "),
            Text(
              "Eduardo Bonamigo Bianchetti - 185961",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
