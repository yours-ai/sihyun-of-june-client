import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_june_client/actions/character/queries.dart';

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
    await getTestStatusQuery().refetch();
    final testStatusRawData = await getTestStatusQuery().result;
    if (testStatusRawData.error != null) {
      return false;
    }
    final testStatus = testStatusRawData.data?['status'];
    if (testStatus == 'NOT_STARTED') {
      getStartTestMutation(
        onSuccess: (res, arg) {
          if (!mounted) return;
          context.go('/character-test');
        },
      ).mutate(null);
      return true;
    } else if (testStatus == 'IN_PROGRESS') {
      if (!mounted) return false;
      context.go('/character-test');
      return true;
    } else if (testStatus == 'WAITING_CONFIRM') {
      if (!mounted) return false;
      context.go('/character-choice');
      return true;
    }
    return false;
  }

  Future<bool> _checkSelectionStatus() async {
    await getSelectionStatusQuery().refetch();
    final selectionStatusRawData = await getSelectionStatusQuery().result;
    if (selectionStatusRawData.error != null) {
      return false;
    }
    if (selectionStatusRawData.data == null) return false; // selection 없는 상태
    final selectionStatus =
        selectionStatusRawData.data!['character']; // selection 있는 상태
    if (selectionStatus == null) {
      // selection 시작 안한 상태
      if (!mounted) return false;
      context.go('/character-selection-deciding');
      return true;
    }
    return false;
  }

  _checkNewUserAndLand() async {
    final isNewUserRawData = await getCheckNewUserQuery().result;
    final isNewUser = isNewUserRawData.data!['is_available'];
    if (isNewUser) {
      getAllocateForNewUserMutation(
        onSuccess: (res, arg) {
          context.go('/character-selection-deciding');
        },
      ).mutate(null);
    } else {
      if (!mounted) return;
      context.go('/mails/assignment-start');
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
