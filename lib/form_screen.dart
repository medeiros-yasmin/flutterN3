import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Clínica Veterinária"),
      ),
      body: new ListView(
        children: <Widget>[
          Image.asset('assets/imagens/pet_hospital.png'),
          new ListTile(
            title: new Text("Bem vindo!"),
          ),
          new ListTile(
            title: new RaisedButton(
                child: new Text("Iniciar".toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pushNamed(TabsPage.routeName);
                }),
          ),
        ],
      ),
    );
  }
}

class TabsPage extends StatefulWidget {
  static String routeName = "/tabsPage";

  @override
  _TabsPageState createState() => new _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          bottom: new TabBar(
            tabs: [
              new Tab(icon: new Icon(Icons.pets), text: "Cadastrar"),
              new Tab(icon: new Icon(Icons.view_list), text: "Listar"),
              new Tab(icon: new Icon(Icons.info_outline), text: "Sobre"),
            ],
          ),
          title: new Text('Voltar'),
        ),
        body: new TabBarView(
          children: [
            new CadastrarTab(
              scaffoldKey: _scaffoldKey,
            ),
            new TransitTab(
              scaffoldKey: _scaffoldKey,
            ),
            new TabSobre(
              scaffoldKey: _scaffoldKey,
            ),
          ],
        ),
      ),
    );
  }
}

/// Cars
class CadastrarTab extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  CadastrarTab({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _CadastrarTabState createState() => new _CadastrarTabState();
}

class _CadastrarTabState extends State<CadastrarTab> {
  bool _enabled = false;

  String _name;
  bool _isAdulto = false;
  String _nomePet;
  int valorG1;
  int valorF = 0;
  int valorM = 1;

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: 'Proprietário'),
          maxLength: 10,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Nome obrigatório';
            }
            return null;
          },
          onSaved: (String value) {
            _name = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Nome do pet'),
          maxLength: 10,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Nome do pet obrigatório';
            }
            return null;
          },
          onSaved: (String value) {
            _nomePet = value;
          },
        ),
        Text('Animal idoso'),
        Checkbox(
          value: _isAdulto,
          onChanged: (bool value) {
            setState(() {
              _isAdulto = value;
            });
          },
        ),
        Text("Sexo feminino"),
        Radio(
            value: valorF,
            groupValue: valorG1,
            onChanged: (int value) {
              setState(() {
                valorG1 = value;
              });
            }),
        Text("Sexo masculino"),
        Radio(
            value: valorM,
            groupValue: valorG1,
            onChanged: (int value) {
              setState(() {
                valorG1 = value;
              });
            }),
        RaisedButton(
          onPressed: () {
            final snackBar = SnackBar(
              content: Text('Dados cadastrados!'),
              action: SnackBarAction(
                label: 'Desfazer',
                onPressed: () {
// código para desfazer a ação!
                },
              ),
            );
// Encontra o Scaffold na árvore de widgets
// e o usa para exibir o SnackBar!
            Scaffold.of(context).showSnackBar(snackBar);
          },
          child: Text('SALVAR'),
        ),
      ],
    );
  }
}

/// Listar
class TransitTab extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  TransitTab({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _TransitTabState createState() => new _TransitTabState();
}

class _TransitTabState extends State<TransitTab> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return new ListView(
      shrinkWrap: true,
      children: <Widget>[
        new SwitchListTile(
            title: new Text("Enable Transit Route"),
            value: _enabled,
            onChanged: (bool value) {
              setState(() {
                _enabled = value;
              });

              if (value) {
                var snackbar =
                    new SnackBar(content: new Text("Transit enabled"));
                widget.scaffoldKey.currentState.showSnackBar(snackbar);
              }
            }),
            
              PetLayout(),
             
      ],
    );
  }
}

//Sobre

class TabSobre extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  TabSobre({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _TabSobre createState() => new _TabSobre();
}

class _TabSobre extends State<TabSobre> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return new ListView(
      
      children: <Widget>[
        new Container(
          child: Text('A aplicação propõe permitir o cadastro de pets, bem como a listagem destes. No cadastro, é possível definir se o pet cadastrado é idoso, o que, automaticamente, o classifica como um paciente que requer certo cuidado no(s) tratamento(s).',
          textAlign:TextAlign.center),
        ),
       
      ],
    );
  }
}

class PetLayout extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return _myListView(context);
      }
    }

   
    Widget _myListView(BuildContext context) {

      List nomeProprietarios = ['Pedro', 'Alex', 'Sofia'];

      final nomePet = ['Bethoven', 'Okami', 'Brutos'];

      return ListView.builder(
        itemCount: nomeProprietarios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(nomeProprietarios[index]),
            //subtitle: Text(nomePet[index]),
             //trailing: Icon(Icons.keyboard_arrow_right),
          );
        },
      );
      
    }

    void imprimeNomeDosTutores()async{
      String tutores = await obtemNomeDosPets();
      print(tutores);
    }

    Future<String> obtemNomeDosPets(){
      String pets = " ";
      Future.delayed(Duration(seconds: 3));
    }
