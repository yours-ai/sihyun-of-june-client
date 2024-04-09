import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/actions/character/dtos.dart';
import 'package:project_june_client/constants.dart';

import 'models/Character.dart';
import 'models/Question.dart';

Mutation<List<Question>, void> startTestMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<List<Question>, void>(
    queryFn: (void _) => startTest(),
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, List<Map<String, int>>> sendTestResponseMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, List<Map<String, int>>>(
    queryFn: sendTestResponses,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<Map<String, dynamic>> fetchTestStatusQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'test-status',
    config: QueryConfig(
      cacheDuration: CachingDuration.assignment,
    ),
    queryFn: fetchTestStatus,
    onError: onError,
  );
}

Query<Map<String, dynamic>> fetchPendingTestQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    config: QueryConfig(
      cacheDuration: CachingDuration.assignment,
    ),
    key: 'pending-test',
    queryFn: fetchPendingTest,
    onError: onError,
  );
}

Query<List<Character>> fetchAllCharactersQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    config: QueryConfig(
      cacheDuration: CachingDuration.character,
    ),
    key: 'characters',
    queryFn: fetchAllCharacters,
    onError: onError,
  );
}

Query<Character> fetchCharacterByIdQuery({
  required int id,
  OnQueryErrorCallback? onError,
}) {
  return Query(
    config: QueryConfig(
      cacheDuration: CachingDuration.character,
    ),
    key: 'character/${id.toString()}',
    queryFn: () => fetchCharacterById(id),
    onError: onError,
  );
}

Query<List<Character>> fetchMyCharactersQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'my-character',
    queryFn: fetchMyCharacters,
    onError: onError,
  );
}

Mutation<void, int> confirmTestMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    refetchQueries: ['my-character'],
    queryFn: confirmTest,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, int> readCharacterStoryMutation({
  refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    refetchQueries: refetchQueries,
    queryFn: readCharacterStory,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, ReallocateDTO> reallocateCharacterMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, ReallocateDTO>(
    queryFn: reallocateCharacter,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, String> extendCharacterMutation({
  refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, String>(
    refetchQueries: refetchQueries,
    queryFn: extendCharacter,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<Map<String, int>> fetchExtendCostQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'extend-cost',
    queryFn: fetchExtendCost,
    onError: onError,
  );
}

Query<Map<String, dynamic>> fetchIsNewUserQuery({
  OnQuerySuccessCallback? onSuccess,
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'check-new-user',
    queryFn: fetchIsNewUser,
    onSuccess: onSuccess,
    onError: onError,
    config: QueryConfig(
      cacheDuration: CachingDuration.newUser,
    ),
  );
}

Mutation<void, void> allocateForNewUserMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    queryFn: (_) => allocateForNewUser(),
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, void> confirmSelectionMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
  required int selectionId,
  required int characterId,
}) {
  return Mutation<void, void>(
    refetchQueries: ['my-character'],
    queryFn: (_) => confirmSelection(selectionId, characterId),
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<Map<String, dynamic>> fetchSelectionStatusQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'selection-status',
    config: QueryConfig(
      cacheDuration: CachingDuration.assignment,
    ),
    queryFn: fetchSelectionStatus,
    onError: onError,
  );
}
