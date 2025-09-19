import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyect_examen_mod_ll/models/news_models.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = '2d0144d7bf024e6fa8e24103c2bffa80';

class NewsServices with ChangeNotifier {
  List<Article> headlines = [];
  List<Article> business = [];
  List<Article> sports = [];
  
  // Estados de carga
  bool _isLoadingHeadlines = true;
  bool _isLoadingBusiness = true;
  bool _isLoadingSports = true;

  // Getters para estados de carga
  bool get isLoadingHeadlines => _isLoadingHeadlines;
  bool get isLoadingBusiness => _isLoadingBusiness;
  bool get isLoadingSports => _isLoadingSports;

  NewsServices() {
    getTopHeadlines();
    getBusinessNews();
    getSportsNews();
  }

  Future<void> getTopHeadlines() async {
    _isLoadingHeadlines = true;
    notifyListeners();
    
    final url = Uri.parse('$_URL_NEWS/top-headlines?country=us&apiKey=$_APIKEY');
    try {
      final resp = await http.get(url);

      if (resp.statusCode == 200) {
        final newResponse = reqResListadoFromJson(resp.body);
        headlines.clear();
        headlines.addAll(newResponse.articles);
        _isLoadingHeadlines = false;
        notifyListeners();
      } else {
        debugPrint('Error al cargar las noticias ${resp.statusCode}');
        _isLoadingHeadlines = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Excepcion al cargar las noticias $e');
      _isLoadingHeadlines = false;
      notifyListeners();
    }
  }

  Future<void> getBusinessNews() async {
    _isLoadingBusiness = true;
    notifyListeners();
    
    final url = Uri.parse('$_URL_NEWS/top-headlines?country=us&category=business&apiKey=$_APIKEY');
    try {
      final resp = await http.get(url);

      if (resp.statusCode == 200) {
        final newResponse = reqResListadoFromJson(resp.body);
        business.clear();
        business.addAll(newResponse.articles);
        _isLoadingBusiness = false;
        notifyListeners();
      } else {
        debugPrint('Error al cargar noticias de negocios ${resp.statusCode}');
        _isLoadingBusiness = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Excepcion al cargar noticias de negocios $e');
      _isLoadingBusiness = false;
      notifyListeners();
    }
  }

  Future<void> getSportsNews() async {
    _isLoadingSports = true;
    notifyListeners();
    
    final url = Uri.parse('$_URL_NEWS/top-headlines?country=us&category=sports&apiKey=$_APIKEY');
    try {
      final resp = await http.get(url);

      if (resp.statusCode == 200) {
        final newResponse = reqResListadoFromJson(resp.body);
        sports.clear();
        sports.addAll(newResponse.articles);
        _isLoadingSports = false;
        notifyListeners();
      } else {
        debugPrint('Error al cargar noticias de deportes ${resp.statusCode}');
        _isLoadingSports = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Excepcion al cargar noticias de deportes $e');
      _isLoadingSports = false;
      notifyListeners();
    }
  }

  // Métodos para refrescar cada categoría
  Future<void> refreshHeadlines() async {
    headlines.clear();
    await getTopHeadlines();
  }

  Future<void> refreshBusiness() async {
    business.clear();
    await getBusinessNews();
  }

  Future<void> refreshSports() async {
    sports.clear();
    await getSportsNews();
  }
}