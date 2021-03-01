import 'package:dms_admin/modules/visit/new/visit_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

class VisitMap extends GetView<VisitDetailController> {
  const VisitMap({Key key}) : super(key: key);
  final assetCheckin = 'assets/images/marker_tim.png';
  final assetCheckOut = 'assets/images/marker_do.png';
  final assetStore = 'assets/images/marker_xanhla.png';
  @override
  Widget build(BuildContext context) {
    print('build map');
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: googleMapSection(),
    );
  }

  iconHelperSection(String asset, String title) {
    return Row(
      children: [
        Image.asset(
          asset,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 9),
        )
      ],
    );
  }

  googleMapSection() {
    var _key = GlobalKey<GoogleMapStateBase>();
    print(controller.result.value.storeGpsLatitude);
    print(controller.result.value.storeGpsLongitude);
    return GoogleMap(
      key: _key,
      initialZoom: 18,
      initialPosition: GeoCoord(controller.result.value.locationCheckinLat,
          controller.result.value.locationCheckinLong), // Los Angeles, CA
      mapType: MapType.roadmap,
      markers: [
        Marker(
          GeoCoord(controller.result.value.locationCheckinLat,
              controller.result.value.locationCheckinLong),
          icon: assetCheckin,
          label: 'Check in',
        ),
        Marker(
          GeoCoord(controller.result.value.locationCheckoutLat,
              controller.result.value.locationCheckoutLong),
          icon: assetCheckOut,
          label: 'Check out',
        ),
        Marker(
          GeoCoord(controller.result.value.storeGpsLatitude,
              controller.result.value.storeGpsLongitude),
          icon: assetStore,
          label: 'Cửa hàng',
        )
      ].toSet(),
      interactive: true,

      mobilePreferences: const MobileMapPreferences(
        trafficEnabled: true,
        zoomControlsEnabled: false,
      ),
      webPreferences: WebMapPreferences(
        fullscreenControl: false,
        zoomControl: true,
      ),
    );
  }
}
