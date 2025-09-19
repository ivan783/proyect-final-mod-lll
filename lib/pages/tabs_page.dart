import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_examen_mod_ll/pages/tab1_page.dart';
import 'package:proyect_examen_mod_ll/pages/tab2_page.dart';
import 'package:proyect_examen_mod_ll/pages/tab3_page.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({super.key});

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (index) => navegacionModel.paginaActual = index,
      type: BottomNavigationBarType.fixed, // Para mostrar más de 2 pestañas
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.whatshot),
          label: 'Top'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_soccer),
          label: 'Sports'
        ),
      ]
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({super.key});

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Tab2Page(),
        Tab3Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => this._paginaActual;
  PageController get pageController => this._pageController;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    this._pageController.animateToPage(
      valor,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}