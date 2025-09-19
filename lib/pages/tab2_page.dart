import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_examen_mod_ll/services/new_services.dart';
import 'package:proyect_examen_mod_ll/widgets/lista_noticias.dart';

class Tab2Page extends StatefulWidget {
  const Tab2Page({super.key});

  @override
  State<Tab2Page> createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    final newsService = Provider.of<NewsServices>(context);
    final businessNews = newsService.business;
    final isLoading = newsService.isLoadingBusiness;

    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de negocios'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              newsService.refreshBusiness();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => newsService.refreshBusiness(),
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Cargando noticias de negocios...'),
                  ],
                ),
              )
            : businessNews.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No se encontraron noticias',
                          style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => newsService.refreshBusiness(),
                          child: Text('Reintentar'),
                        ),
                      ],
                    ),
                  )
                : ListaNoticias(businessNews),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}