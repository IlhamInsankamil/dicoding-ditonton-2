import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/bloc/mv_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TVDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;

  TVDetailPage({required this.id});

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(GetDetail(widget.id));
      context.read<TvRecommendationBloc>().add(GetRecommendation(widget.id));
      context.read<MvWatchlistStatusBloc>().add(GetWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            return SafeArea(
              child: DetailContent(
                state.result,
              ),
            );
          } else if (state is TvDetailError) {
            return Text(state.message);
          } else {
            return Text('Failed');
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVDetail tv;

  DetailContent(this.tv);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: BlocBuilder<MvWatchlistStatusBloc,
                            MvWatchlistStatusState>(
                          builder: (context, state) {
                            var isAddedWatchlist = state.isAddedToWatchlist;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tv.name,
                                  style: kHeading5,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    String msg = '';

                                    if (!isAddedWatchlist) {
                                      await BlocProvider.of<
                                                  MvWatchlistOperationBloc>(
                                              context,
                                              listen: false)
                                          .saveWatchlistTV
                                          .execute(tv);

                                      msg = 'Added to Watchlist';
                                    } else {
                                      await BlocProvider.of<
                                                  MvWatchlistOperationBloc>(
                                              context,
                                              listen: false)
                                          .removeWatchlistTV
                                          .execute(tv);

                                      msg = 'Removed from Watchlist';
                                    }

                                    context
                                        .read<MvWatchlistStatusBloc>()
                                        .add(GetWatchlistStatus(tv.id));
                                    context
                                        .read<MvWatchlistBloc>()
                                        .add(LoadWatchlist());

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(msg),
                                      duration:
                                          const Duration(milliseconds: 500),
                                    ));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedWatchlist
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                ),
                                Text(
                                  _showGenres(tv.genres),
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: tv.voteAverage / 2,
                                      itemCount: 5,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                      itemSize: 24,
                                    ),
                                    Text('${tv.voteAverage}')
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Overview',
                                  style: kHeading6,
                                ),
                                Text(
                                  tv.overview,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Season',
                                  style: kHeading6,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  height: 100.0,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: tv.seasons
                                        .map((x) => CustomCardWidget(
                                              season: x,
                                              tvId: tv.id,
                                            ))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Recommendations',
                                  style: kHeading6,
                                ),
                                BlocBuilder<TvRecommendationBloc,
                                    TvRecommendationState>(
                                  builder: (context, state) {
                                    if (state is TvRecommendationLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state
                                        is TvRecommendationHasData) {
                                      final recommendations = state.result;
                                      return Container(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final tv = recommendations[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                    context,
                                                    TVDetailPage.ROUTE_NAME,
                                                    arguments: tv.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: recommendations.length,
                                        ),
                                      );
                                    } else if (state is TvRecommendationError) {
                                      return Expanded(
                                        child: Center(
                                          child: Text(state.message),
                                        ),
                                      );
                                    } else {
                                      return Expanded(
                                        child: Container(),
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
