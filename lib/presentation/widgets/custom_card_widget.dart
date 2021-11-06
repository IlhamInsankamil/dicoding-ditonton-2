import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/presentation/pages/tv_episodes_page.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final Season season;
  final int tvId;

  CustomCardWidget({required this.season, required this.tvId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, TVEpisodesPage.ROUTE_NAME, arguments: {
            'tvId': tvId,
            'seasonNumber': season.seasonNumber,
            'seasonName': season.name
          });
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text(
                  season.name != null ? season.name! : 'TBD',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Text(
                  'Premiered on ${season.airDate ?? '-'}',
                  // != null ? '${season.airDate!.year}-${season.airDate!.month}-${season.airDate!.day}' : '-'}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Text(
                  '${season.episodeCount != null ? season.episodeCount : '-'} Episodes',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
