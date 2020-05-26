import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:yorglass_ik/models/reward.dart';
import 'package:yorglass_ik/models/user-reward.dart';
import 'package:yorglass_ik/pages/reward_detail.dart';
import 'package:yorglass_ik/repositories/reward-repository.dart';
import 'package:yorglass_ik/widgets/reward-cards3.dart';

class RewardSliderTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RewardRepository.instance.getRewards(type: "43c917d1-5262-4a4f-8085-d863084eceda"),
      builder: (BuildContext context, AsyncSnapshot<List<Reward>> snapshot) {
        if (snapshot.hasData) {
          return Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: FutureBuilder(
                  future: snapshot.data[index].image64.future,
                  builder: (BuildContext context, AsyncSnapshot<Uint8List> _snapshot) {
                    if (snapshot.hasData) {
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          final provider = Provider.of<UserReward>(context);
                          return ChangeNotifierProvider.value(
                            value: provider,
                            child: RewardDetail(
                              reward: snapshot.data[index],
                            ),
                          );
                        })),
                        child: RewardCards3(
                          reward: snapshot.data[index],
                        ),
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
            itemCount: snapshot.data.length,
            itemWidth: 200,
            pagination: new SwiperPagination(builder: SwiperPagination.rect),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
