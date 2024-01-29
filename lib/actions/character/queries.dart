import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/actions/character/dtos.dart';
import 'package:project_june_client/constants.dart';

import 'models/Character.dart';
import 'models/Question.dart';

Mutation<List<Question>, void> getStartTestMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<List<Question>, void>(
    queryFn: (void _) => startTest(),
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, List<Map<String, int>>> getSendResponseMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, List<Map<String, int>>>(
    queryFn: sendResponses,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<Map<String, dynamic>> getTestStatusQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: "test-status",
    config: QueryConfig(
      cacheDuration: CachingDuration.assignment,
    ),
    queryFn: fetchTestStatus,
    onError: onError,
  );
}

Query<Map<String, dynamic>> getPendingTestQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    config: QueryConfig(
      cacheDuration: CachingDuration.assignment,
    ),
    key: "pending-test",
    queryFn: fetchPendingTest,
    onError: onError,
  );
}

Query<List<Character>> getAllCharactersQuery({
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

Query<Character> getCharacterQuery({
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

Query<List<Character>> getRetrieveMyCharacterQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'my-character',
    queryFn: fetchMyCharacter,
    onError: onError,
  );
}

Mutation<void, int> getDenyTestChoiceMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    queryFn: denyTestChoice,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, int> getConfirmTestMutation({
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

Mutation<void, int> getReadCharacterStoryMutation({
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

Mutation<void, ReallocateDTO> getReallocateMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, ReallocateDTO>(
    queryFn: reallocate,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, String> getExtendMutation({
  refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, String>(
    refetchQueries: refetchQueries,
    queryFn: extend,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Query<Map<String, int>> getExtendCostQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'extend-cost',
    queryFn: fetchExtendCost,
    onError: onError,
  );
}

Query<Map<String, dynamic>> getCheckNewUserQuery({
  OnQuerySuccessCallback? onSuccess,
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: "check-new-user",
    queryFn: fetchIsNewUser,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, void> getAllocateForNewUserMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, void>(
    queryFn: (_) => allocateForNewUser(),
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, void> getConfirmSelectionMutation({
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

Query<Map<String, dynamic>> getSelectionStatusQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: "selection-status",
    config: QueryConfig(
      cacheDuration: CachingDuration.assignment,
    ),
    queryFn: fetchSelectionStatus,
    onError: onError,
  );
}
