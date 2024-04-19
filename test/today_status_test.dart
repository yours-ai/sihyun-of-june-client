import 'package:clock/clock.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_june_client/actions/character/models/today/character_today.dart';
import 'package:project_june_client/actions/mails/models/mail_in_list.dart';
import 'package:project_june_client/actions/mails/models/reply.dart';
import 'package:project_june_client/services.dart';
import 'package:test/test.dart';

class MockClock extends Mock implements Clock {}

void main() {
  group('오늘 내일 체크', () {
    final mockClock = MockClock();

    test('21시 전 오늘 도착', () {
      when(() => mockClock.now()).thenReturn(DateTime(2024, 1, 1, 20, 0, 0));
      withClock(mockClock, () {
        final arrivedAt = mailService.getNextMailReceiveTimeStr(
          DateTime(2024, 1, 1, 21, 0, 0),
        );
        expect(arrivedAt, '오늘 저녁 9시');
      });
    });

    test('21시 전 내일 도착 - 유저가 3시 이후 답장했을때', () {
      when(() => mockClock.now()).thenReturn(DateTime(2024, 1, 1, 20, 0, 0));
      withClock(mockClock, () {
        final arrivedAt = mailService.getNextMailReceiveTimeStr(
          DateTime(2024, 1, 2, 21, 0, 0),
        );
        expect(arrivedAt, '내일 저녁 9시');
      });
    });

    test('21시 후 내일 도착', () {
      when(() => mockClock.now()).thenReturn(DateTime(2024, 1, 1, 23, 0, 0));
      withClock(mockClock, () {
        final arrivedAt = mailService.getNextMailReceiveTimeStr(
          DateTime(2024, 1, 2, 21, 0, 0),
        );
        expect(arrivedAt, '내일 저녁 9시');
      });
    });

    test('21시 후, 다음날 아침 해당일 도착', () {
      when(() => mockClock.now()).thenReturn(DateTime(2024, 1, 2, 1, 0, 0));
      withClock(mockClock, () {
        final arrivedAt = mailService.getNextMailReceiveTimeStr(
          DateTime(2024, 1, 2, 21, 0, 0),
        );
        expect(arrivedAt, '오늘 저녁 9시');
      });
    });

    test('2일 뒤 편지가 도착한다면?', () {
      when(() => mockClock.now()).thenReturn(DateTime(2024, 1, 2, 23, 0, 0));
      withClock(mockClock, () {
        final arrivedAt = mailService.getNextMailReceiveTimeStr(
          DateTime(2024, 1, 4, 21, 0, 0),
        );
        expect(arrivedAt, '모레 저녁 9시');
      });
    });

    test('5일 뒤 편지가 도착한다면?', () {
      when(() => mockClock.now()).thenReturn(DateTime(2024, 1, 2, 23, 0, 0));
      withClock(mockClock, () {
        final arrivedAt = mailService.getNextMailReceiveTimeStr(
          DateTime(2024, 1, 7, 21, 0, 0),
        );
        expect(arrivedAt, '5일 뒤 저녁 9시');
      });
    });
  });
  group('TodayStatus', () {
    final defaultToday = CharacterToday(
      text: '태진이의 하루는 어쩌고',
      weather: 'SUNNY',
      next_mail_available_at: DateTime(2024, 1, 1, 0, 0, 0),
      is_next_mail_last: false,
      is_last_mail: false,
      is_just_replied: false,
      mail: null,
    );

    CharacterToday copyWithToday({
      String? text,
      String? weather,
      DateTime? next_mail_available_at,
      bool? is_next_mail_last,
      bool? is_last_mail,
      bool? is_just_replied,
      MailInList? mail,
    }) {
      return CharacterToday(
        text: text ?? defaultToday.text,
        weather: weather ?? defaultToday.weather,
        next_mail_available_at:
            next_mail_available_at ?? defaultToday.next_mail_available_at,
        is_next_mail_last: is_next_mail_last ?? defaultToday.is_next_mail_last,
        is_last_mail: is_last_mail ?? defaultToday.is_last_mail,
        is_just_replied: is_just_replied ?? defaultToday.is_just_replied,
        mail: mail,
      );
    }

    final defaultMail = MailInList(
      id: 1,
      assign: 2,
      available_at: DateTime(2024, 1, 1, 21, 0, 0),
      replies: [],
      day: 1,
      has_permission: false,
      is_read: false,
    );

    final defaultReply = Reply(
      id: 1,
      description: 'ㅎㅇ',
      created: DateTime(2024, 1, 1, 21, 0, 0),
      modified: DateTime(2024, 1, 1, 21, 0, 0),
    );

    MailInList copyWithMail({
      int? id,
      int? assign,
      DateTime? available_at,
      List<Reply>? replies,
      int? day,
      bool? has_permission,
      bool? is_read,
    }) {
      return MailInList(
        id: id ?? defaultMail.id,
        assign: assign ?? defaultMail.assign,
        available_at: available_at ?? defaultMail.available_at,
        replies: replies ?? defaultMail.replies,
        day: day ?? defaultMail.day,
        has_permission: has_permission ?? defaultMail.has_permission,
        is_read: is_read ?? defaultMail.is_read,
      );
    }

    test('유저가 첫 가입 후, 편지 못받았을때', () {
      final today = copyWithToday(
        next_mail_available_at: DateTime(2024, 1, 1, 21, 0, 0),
      );
      final todayStatus = characterService.checkTodayStatus(false, today);
      expect(todayStatus, HomeEnum.willBeArrivedMail);
    });

    test('유저가 첫 가입 후, 편지 받았는데 안봤을때', () {
      final today = copyWithToday(
        is_just_replied: false,
        is_last_mail: false,
        is_next_mail_last: false,
        mail: copyWithMail(
          available_at: DateTime(2024, 1, 1, 21, 0, 0),
          is_read: false,
        ),
      );
      final todayStatus = characterService.checkTodayStatus(false, today);
      expect(todayStatus, HomeEnum.arrivedNewMail);
    });

    test('유저가 마지막 편지 받았는데 안봤을때', () {
      final today = copyWithToday(
        is_just_replied: false,
        is_last_mail: true,
        is_next_mail_last: false,
        mail: copyWithMail(
          available_at: DateTime(2024, 1, 1, 21, 0, 0),
          is_read: false,
        ),
      );
      final todayStatus = characterService.checkTodayStatus(false, today);
      expect(todayStatus, HomeEnum.arrivedLastMail);
    });

    test('유저가 편지 읽고 답장 안했을때', () {
      final today = copyWithToday(
        is_just_replied: false,
        is_last_mail: false,
        is_next_mail_last: false,
        mail: copyWithMail(
          available_at: DateTime(2024, 1, 1, 21, 0, 0),
          is_read: true,
        ),
      );
      final todayStatus = characterService.checkTodayStatus(false, today);
      expect(todayStatus, HomeEnum.needReply);
    });

    test('답장 막 했을때', () {
      final today = copyWithToday(
        is_just_replied: true,
        is_last_mail: false,
        is_next_mail_last: false,
      );
      final todayStatus = characterService.checkTodayStatus(false, today);
      expect(todayStatus, HomeEnum.justReplied);
    });

    test('답장했고, 몇분지나서 다음이 마지막 편지일때', () {
      final today = copyWithToday(
        is_just_replied: false,
        is_last_mail: false,
        is_next_mail_last: true,
        next_mail_available_at: DateTime(2024, 1, 2, 21, 0, 0),
      );
      final todayStatus = characterService.checkTodayStatus(false, today);
      expect(todayStatus, HomeEnum.willBeArrivedLastMail);
    });

    test('30일 지났을때', () {
      final today = copyWithToday();
      final todayStatus = characterService.checkTodayStatus(true, today);
      expect(todayStatus, HomeEnum.thirtyDaysFinished);
    });

    test('답장 방금 했는데 mail이 null로 오지 않는다면 재귀함수 잘되는지', () {
      final today = copyWithToday(
          is_just_replied: true,
          mail: copyWithMail(
            is_read: true,
            replies: [defaultReply],
          ));
      final todayStatus = characterService.checkTodayStatus(false, today);
      expect(todayStatus, HomeEnum.justReplied);
    });
  });
}
