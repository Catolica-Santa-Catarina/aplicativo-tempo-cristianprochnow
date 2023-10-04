import 'package:geolocator/geolocator.dart';
import 'package:tempo_template/models/location.dart';

class LocationService {
  Future<Location> getCurrentLocation() async {
    await _checkLocationPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high  
    );
    
    return Location(
      latitude: position.latitude,
      longitude: position.longitude
    );
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // serviço de localização desabilitado. Não será possível continuar
      return Future.error('O serviço de localização está desabilitado.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Sem permissão para acessar a localização
        return Future.error('Sem permissão para acesso à localização');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // permissões negadas para sempre
      return Future.error(
        'A permissão para acesso a localização foi negada para sempre. '
        'Não é possível pedir permissão.'
      );
    }
  }
}