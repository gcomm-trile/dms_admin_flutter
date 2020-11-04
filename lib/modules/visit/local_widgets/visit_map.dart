// // Copyright 2019 The Chromium Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:dms_admin/modules/visit/visit_detail_controller.dart';
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
    return GoogleMap(
      key: _key,
      initialZoom: 18,
      initialPosition: GeoCoord(controller.visit.locationCheckinLat,
          controller.visit.locationCheckinLong), // Los Angeles, CA
      mapType: MapType.roadmap,
      markers: [
        Marker(
          GeoCoord(controller.visit.locationCheckinLat,
              controller.visit.locationCheckinLong),
          icon: assetCheckin,
          label: 'Check in',
        ),
        Marker(
          GeoCoord(controller.visit.locationCheckoutLat,
              controller.visit.locationCheckoutLong),
          icon: assetCheckOut,
          label: 'Check out',
        ),
        Marker(
          GeoCoord(controller.visit.store.gpsLatitude,
              controller.visit.store.gpsLongitude),
          icon: assetStore,
          label: 'Cửa hàng',
        )
      ].toSet(),
      interactive: true,

      // onTap: (coord) => _scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text(coord?.toString()),
      //   duration: const Duration(seconds: 2),
      // )),
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
