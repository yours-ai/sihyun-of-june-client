import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/auth/queries.dart';
import 'package:project_june_client/actions/character/queries.dart';
import 'package:project_june_client/constants.dart';

class AssignmentScreen extends ConsumerStatefulWidget {
  const AssignmentScreen({super.key});

  @override
  AssignmentScreenState createState() => AssignmentScreenState();
}

class AssignmentScreenState extends ConsumerState<AssignmentScreen> {
  _checkAssignmentAndLand() async {
    final hasTest = await _checkTestStatus();
    if (hasTest) return;
    final hasSelection = await _checkSelectionStatus();
    if (hasSelection) return;
    await _checkNewUserAndLand();
  }

  Future<bool> _checkTestStatus() async {
    await fetchTestStatusQuery().refetch();
    final testStatusRawData = await fetchTestStatusQuery().result;
    if (testStatusRawData.error != null) {
      return false;
    }
    final testStatus = testStatusRawData.data?['status'];
    if (testStatus == 'NOT_STARTED') {
      startTestMutation(
        onSuccess: (res, arg) {
          if (!mounted) return;
          context.go(RoutePaths.characterTest);
        },
      ).mutate(null);
      return true;
    } else if (testStatus == 'IN_PROGRESS') {
      if (!mounted) return false;
      context.go(RoutePaths.characterTest);
      return true;
    } else if (testStatus == 'WAITING_CONFIRM') {
      if (!mounted) return false;
      context.go(RoutePaths.testDeciding);
      return true;
    }
    return false;
  }

  Future<bool> _checkSelectionStatus() async {
    await fetchSelectionStatusQuery().refetch();
    final selectionStatusRawData = await fetchSelectionStatusQuery().result;
    if (selectionStatusRawData.error != null) {
      return false;
    }
    if (selectionStatusRawData.data == null) return false; // selection 없는 상태
    final selectionStatus =
        selectionStatusRawData.data!['character']; // selection 있는 상태
    if (selectionStatus == null) {
      // selection 시작 안한 상태
      if (!mounted) return false;
      context.go(RoutePaths.selectionDeciding);
      return true;
    }
    return false;
  }

  _checkNewUserAndLand() async {
    final isNewUserRawData = await fetchIsNewUserQuery().result;
    final isNewUser = isNewUserRawData.data!['is_available'];
    if (isNewUser) {
      allocateForNewUserMutation(
        onSuccess: (res, arg) {
          context.go(RoutePaths.selectionDeciding);
        },
      ).mutate(null);
    } else {
      final bool is30DaysFinished = await fetchMeQuery()
          .result
          .then((value) => value.data!.is_30days_finished);
      if (is30DaysFinished) { // 30일 지난 유저 redirect 이슈로 인해 분기
        if (!mounted) return;
        context.go(RoutePaths.all);
        context.push(RoutePaths.mailListDecideAssignmentMethod);
      } else {
        if (!mounted) return;
        context.go(RoutePaths.mailListDecideAssignmentMethod);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAssignmentAndLand();
    });
  }

  @override
  Widget build(context) {
    return const Scaffold();
  }
}
