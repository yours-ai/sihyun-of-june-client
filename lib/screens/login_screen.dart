import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';

import '../actions/characters/queries.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        child: QueryBuilder(
          query: getlistCharactersQuery(),
          builder: (context, state) {
            if (state.status == QueryStatus.loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.status == QueryStatus.error) {
              return Center(child: Text(state.error.toString()));
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.data?.first.toJson().toString() ?? 'Login'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
