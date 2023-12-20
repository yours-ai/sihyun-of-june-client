import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:project_june_client/actions/character/actions.dart';
import 'package:project_june_client/actions/character/dtos.dart';

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
    queryFn: fetchTestStatus,
    onError: onError,
  );
}

Query<Map<String, dynamic>> getPendingTestQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: "pending-test",
    queryFn: fetchPendingTest,
    onError: onError,
  );
}

Query<List<Character>> getAllCharactersQuery({
  OnQueryErrorCallback? onError,
}) {
  return Query(
    key: 'characters',
    queryFn: fetchCharacters,
    onError: onError,
  );
}

Query<Character> getCharacterQuery({
  required int id,
  OnQueryErrorCallback? onError,
}) {
  return Query(
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

Mutation<void, denyTestChoiceDTO> getDenyTestChoiceMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, denyTestChoiceDTO>(
    queryFn: denyTestChoice,
    onSuccess: onSuccess,
    onError: onError,
  );
}

Mutation<void, int> getConfirmChoiceMutation({
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, int>(
    queryFn: confirmChoice,
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

Mutation<void, String> getRetestMutation({
  refetchQueries = const [],
  OnSuccessCallback? onSuccess,
  OnErrorCallback? onError,
}) {
  return Mutation<void, String>(
    refetchQueries: refetchQueries,
    queryFn: retest,
    onSuccess: onSuccess,
    onError: onError,
  );
}
