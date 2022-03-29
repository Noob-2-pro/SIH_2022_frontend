import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:sih_2022_sahaye/Screens/admin/op_modal.dart';
import 'package:sih_2022_sahaye/Screens/admin/view_op_details.dart';
import 'package:sih_2022_sahaye/constants.dart';
import '../../widgets/custom_appbar.dart';
import 'get_op_data_service.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  LatLng latlong = LatLng(28.680834, 77.256590);

  Future<List<Opmodal>> getOpDataLoc() async {
    return await OPLocData().getOPLocation(data: {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cutomAppBar(context: context, isLoggedIn: true),
      body: Center(
        child: FutureBuilder(
            future: getOpDataLoc(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading....');
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else {
                    List<Marker> generateMarker() {
                      List<Marker> marker = [];
                      for (var location in snapshot.data as List) {
                        String imagePath = "assets/images/loc_yellow.png";

                        if (location.availability == "Available") {
                          imagePath = "assets/images/loc_grey.png";
                        } else if (location.availability == "Not Available") {
                          imagePath = "assets/images/loc_green.png";
                        } else if (location.availability == "Working") {
                          imagePath = "assets/images/loc_yellow.png";
                        }

                        marker.add(
                          Marker(
                            width: 80.0.w,
                            height: 85.0.h,
                            point: LatLng(
                              location.latitude == null ? 80.0 : double.parse(location.latitude!),
                              location.longitude == null ? 40 : double.parse(location.longitude!),
                            ),
                            builder: (context) => Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colorpalette.lightpink,
                                            content: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(location.firstName!),
                                                  Text(
                                                    location.operatorId!.substring(0, 5),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                          return OpDetails(userId: location.operatorId.toString());
                                                        }));
                                                      },
                                                      child: const Center(
                                                        child: Text("View Detials"),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Image.asset(
                                    imagePath,
                                  ),
                                ),
                                Flexible(
                                    child: Container(
                                  color: Colorpalette.lightpink,
                                  child: Text(
                                    "${location.firstName}",
                                    style: TextStyle(fontSize: 12.w),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        );
                      }
                      return marker;
                    }

                    return Stack(
                      children: [
                        FlutterMap(
                          options: MapOptions(
                            center: latlong,
                            zoom: 12.0,
                          ),
                          layers: [
                            TileLayerOptions(
                              urlTemplate:
                                  "https://api.mapbox.com/styles/v1/ritikjainx/cl1bh52pe000514nx4ddjni6m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicml0aWtqYWlueCIsImEiOiJjbDExNGlyMTUycXhkM2lwa200cnpzenc3In0.gwpB_kHIbYzPI2MhnkvFVA",
                              additionalOptions: {
                                'accessToken': MAPBOX_ACCESS_TOKEN,
                                'id': 'mapbox.streets',
                              },
                            ),
                            MarkerLayerOptions(
                              markers: generateMarker(),
                            ),
                          ],
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 210.h,
                              width: 150.w,
                              child: Flexible(
                                child: Card(
                                  color: Colorpalette.lightpink,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Image.asset("assets/images/loc_green.png"),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text("Available"),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Image.asset("assets/images/loc_yellow.png"),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Working",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Image.asset("assets/images/loc_grey.png"),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Flexible(child: Text("Not Available")),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    );
                  }
              }
            }),
      ),
    );
  }
}
