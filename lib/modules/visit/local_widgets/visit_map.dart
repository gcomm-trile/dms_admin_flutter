// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:html';

import 'package:dms_admin/modules/visit/visit_detail_controller.dart';
import 'package:dms_admin/components/loading.dart';
import 'package:dms_admin/share/load_status.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'package:flutter_google_maps/flutter_google_maps.dart';

class VisitMap extends StatelessWidget {
  VisitMap() : super();

  @override
  Widget build(BuildContext context) {
    return const PlacePolylineBody();
  }
}

class PlacePolylineBody extends StatefulWidget {
  const PlacePolylineBody();

  @override
  State<StatefulWidget> createState() => PlacePolylineBodyState();
}

class PlacePolylineBodyState extends State<PlacePolylineBody> {
  PlacePolylineBodyState();

  final _key = GlobalKey<GoogleMapStateBase>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build map');
    return Scaffold(body: GetX<VisitDetailController>(builder: (controller) {
      return controller.isLoading.value == LoadStatus.success
          ? Container(
              padding: EdgeInsets.only(top: 10),
              
              child: Stack(
                children: [
                  GoogleMap(
                    key: _key,
                    initialZoom: 17,
                    initialPosition: GeoCoord(
                        controller.data.value.locationCheckinLat,
                        controller
                            .data.value.locationCheckinLong), // Los Angeles, CA
                    mapType: MapType.roadmap,
                    markers: [
                      Marker(
                        GeoCoord(controller.data.value.locationCheckinLat,
                            controller.data.value.locationCheckinLong),
                        icon: 'assets/images/marker_tim.png',
                      ),
                      Marker(
                        GeoCoord(controller.data.value.locationCheckoutLat,
                            controller.data.value.locationCheckoutLong),
                        icon: 'assets/images/marker_do.png',
                      ),
                      Marker(
                        GeoCoord(controller.data.value.gpsLatitude,
                            controller.data.value.gpsLongitude),
                        icon: 'assets/images/marker_xanhla.png',
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
                  ),
                  Positioned(
                      left: 2.0,
                      bottom: 2.0,
                      child: Container(
                        color: Colors.grey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/marker_tim.png',
                                ),
                                Text('Check in')
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/marker_do.png',
                                ),
                                Text('Check out')
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/marker_xanhla.png',
                                ),
                                Text('Cửa hàng')
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          : LoadingControl();
    }));
  }

  TextStyle _textStyleFilter = new TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
  double widthFilter = 80.0;

  void drawMap() {}

  Widget get _buildGoogleMap {
    return GoogleMap(
      key: _key,
      initialZoom: 13,
      initialPosition:
          GeoCoord(10.8077946924, 106.6221338057), // Los Angeles, CA
      mapType: MapType.roadmap,

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
        fullscreenControl: true,
        zoomControl: true,
      ),
    );
  }
}
