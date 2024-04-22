import 'dart:async';
import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/analytics/dtos.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/constants.dart';
import 'package:project_june_client/providers/character_provider.dart';
import 'package:project_june_client/providers/one_link_provider.dart';
import 'package:project_june_client/widgets/common/modal/modal_description_widget.dart';
import 'package:project_june_client/widgets/common/modal/modal_widget.dart';

import '../../actions/analytics/queries.dart';
import '../../widgets/auth/KakaoLoginButton.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
      ref.read(selectedCharacterProvider.notifier).state = null;
    });
  }

  @override
  Widget build(context) {
    UserFunnelDTO funnelDTO = UserFunnelDTO(
        funnel: ref.watch(oneLinkProvider)?['media_source'] ??
            ref.watch(deepLinkProvider)?.mediaSource?.toString(),
        refCode: ref.watch(oneLinkProvider)?['af_sub1'] ??
            ref.watch(deepLinkProvider)?.afSub1?.toString());
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double totalHeight = constraints.maxHeight;
                  double targetPosition = (3 / 10) * totalHeight;

                  return Stack(
                    children: [
                      Positioned(
                        top: targetPosition,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 220,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (Platform.isIOS)
                      MutationBuilder(
                        mutation: loginAsAppleMutation(
                          onSuccess: (res, arg) async {
                            await sendUserFunnelMutation()
                                .mutate(funnelDTO)
                                .then((_) => context.go(RoutePaths.starting));
                          },
                          onError: (arg, error, callback) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ModalWidget(
                                  title: '유월의 시현이 서비스가 종료되었습니다.',
                                  description: const ModalDescriptionWidget(
                                    description: '더 이상 서비스 가입이 불가능 합니다.',
                                  ),
                                  choiceColumn: FilledButton(
                                    onPressed: () => context.pop(),
                                    child: const Text('알겠어요'),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        builder: (context, state, mutate) {
                          return FilledButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstants.black),
                            ),
                            onPressed: () => mutate(null),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.apple),
                                SizedBox(width: 8),
                                Text(
                                  'APPLE로 계속하기',
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    const SizedBox(height: 10),
                    const KakaoLoginButton(),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        context.go(RoutePaths.loginByPhone);
                      },
                      child: Text(
                        '전화번호로 계속하기',
                        style: TextStyle(color: ColorConstants.neutral),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
