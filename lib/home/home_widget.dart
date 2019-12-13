import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:kisan_hub/bloc/home_screen_bloc.dart';
import 'package:kisan_hub/config/app_config.dart';
import 'package:kisan_hub/model/get_activity_status.dart';
import 'package:kisan_hub/model/status.dart';
import 'package:kisan_hub/provider/bloc_provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.homeScreenTitle),
      ),
      body: Builder(
        builder: (context) => StreamBuilder<ActivityStatus>(
          stream: _homeScreenBloc.activityStream,
          builder: (context, snapshot) {
            if (snapshot.data != null &&
                snapshot.data.status == Status.started) {
              _isLoading = true;
            }
            if (snapshot.data != null &&
                snapshot.data.status == Status.completed) {
              _isLoading = false;
            }
            return VisibilityDetector(
              key: const Key('home_screen'),
              onVisibilityChanged: (VisibilityInfo visibilityInfo) {
                if (visibilityInfo.visibleFraction == 1.0) {
                  _homeScreenBloc.getActivities();
                }
              },
              child: ModalProgressHUD(
                  key: Key('loading_view'),
                  inAsyncCall: _isLoading,
                  child: snapshot.data != null &&
                          snapshot.data.activities != null
                      ? ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.activities['total'],
                          itemBuilder: (BuildContext context, int index) {
                            var item =
                                snapshot.data.activities['activities'][index];
                            return Card(
                              child: ListTile(
                                leading: Image.network(item['wakeUpImage']),
                                trailing:
                                    Image.network(item['totalStepsImage']),
                                title: Text(
                                  item['activity_id'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: RichText(
                                  text: TextSpan(
                                    text: item['date'],
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(text: ' | '),
                                      WidgetSpan(
                                        child: Icon(Icons.alarm, size: 14),
                                      ),
                                      TextSpan(
                                        text: item['wakeUp'],
                                      ),
                                      TextSpan(text: ' | '),
                                      WidgetSpan(
                                        child: Icon(Icons.directions_walk,
                                            size: 14),
                                      ),
                                      TextSpan(text: item['totalSteps']),
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              ),
                            );
                          })
                      : Container()),
            );
          },
        ),
      ),
    );
  }
}
