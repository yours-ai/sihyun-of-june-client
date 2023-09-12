import 'dart:ui';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';

import '../widgets/profile_widget.dart';

class CharacterChoiceScreen extends StatefulWidget {
  const CharacterChoiceScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CharacterChoiceScreen();
  }
}

class _CharacterChoiceScreen extends State<CharacterChoiceScreen> {
  @override
  Widget build(context) {
    return QueryBuilder(
      query: getPendingTestQuery(),
      builder: (context, state) {
        print(state.data);
        if (state.status == 'loading') {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        };
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.background,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.only(left: 23),
                child: Icon(
                  PhosphorIcons.arrow_left,
                  color: ColorConstants.black,
                  size: 32,
                ),
              ),
            ),
          ),
          body: state.data != null ? SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    children: [
                      ProfileWidget(
                          Name: state.data!.name,
                          Age: (state.data!.age.toString()),
                          MBTI: state.data!.MBTI,
                          Description:
                              state.data!.description,
                          ImagePath: state.data!.image),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 36.0),
                            child: Text(
                              '다른 상대도\n살펴볼까요?',
                              style: TextStyle(
                                color: ColorConstants.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          GridView.count(
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1.0,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.go('/othercharacter');
                                },
                                child: ClipRRect(
                                  child: Image.asset(
                                    'assets/images/ryusihyun_profile.png',
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              ClipRRect(
                                child: Image.asset(
                                  'assets/images/ryusihyun_profile.png',
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              ClipRRect(
                                child: Image.asset(
                                  'assets/images/ryusihyun_profile.png',
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              ClipRRect(
                                child: Image.asset(
                                  'assets/images/ryusihyun_profile.png',
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              ClipRRect(
                                child: Image.asset(
                                  'assets/images/ryusihyun_profile.png',
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              ClipRRect(
                                child: Image.asset(
                                  'assets/images/ryusihyun_profile.png',
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 36,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 28.0, right: 28.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            context.go('/select');
                          },
                          child: Text('친구에게 자랑하기')),
                      SizedBox(
                        height: 10,
                      ),
                      FilledButton(
                          onPressed: () {
                            context.go('/select');
                          },
                          child: Text('다음')),
                    ],
                  ),
                ),
              ],
            ),
          ):Container(),
        );
      },
    );
  }
}
