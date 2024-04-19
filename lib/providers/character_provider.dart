import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_june_client/actions/character/models/character.dart';

final activeCharacterProvider = StateProvider<Character?>((ref) => null);

final selectedCharacterProvider = StateProvider<Character?>((ref) => null);
