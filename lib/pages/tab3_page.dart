import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_examen_mod_ll/services/new_services.dart';
import 'package:proyect_examen_mod_ll/widgets/lista_noticias.dart';

class Tab3Page extends StatefulWidget {
  const Tab3Page({super.key});

  @override
  State<Tab3Page> createState() => _Tab3PageState();
}

class _Tab3PageState extends State<Tab3Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    final newsService = Provider.of<NewsServices>(context);
    final sportsNews = newsService.sports;
    final isLoading = newsService.isLoadingSports;

    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias deportivas'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              newsService.refreshSports();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => newsService.refreshSports(),
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Cargando noticias de deportes...'),
                  ],
                ),
              )
            : sportsNews.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sports_soccer, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No se encontraron noticias deportivas',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => newsService.refreshSports(),
                          child: Text('Reintentar'),
                        ),
                      ],
                    ),
                  )
                : ListaNoticias(sportsNews),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}