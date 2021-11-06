import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_on_the_air_notifier.dart';
import 'package:ditonton/presentation/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TVOnTheAirPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-on-the-air';

  @override
  _TVOnTheAirPageState createState() => _TVOnTheAirPageState();
}

class _TVOnTheAirPageState extends State<TVOnTheAirPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TVOnTheAirNotifier>(context, listen: false)
            .fetchTVOnTheAir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV On The Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TVOnTheAirNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvs[index];
                  return CustomCard(tv.id, tv.isMovie, tv.name, tv.overview,
                      tv.posterPath, 0);
                },
                itemCount: data.tvs.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
