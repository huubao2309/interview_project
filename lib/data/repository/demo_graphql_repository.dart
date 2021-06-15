import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interview_project/data/service/demo_graphql_service.dart';

// class DemoGraphQLRepository {
//   DemoGraphQLRepository({required DemoGraphQLService demoGraphQLService}) : _demoGraphQLService = demoGraphQLService;
//
//   final DemoGraphQLService _demoGraphQLService;
//
//   Future<List<DemoSubscription$Subscription$Todos>> getPosts() async {
//     final c = Completer<List<DemoSubscription$Subscription$Todos>>();
//     try {
//       final results = await _demoGraphQLService.demoGraphQL();
//       if (!results.hasException) {
//         final listTodo = DemoSubscription$Subscription.fromJson(results.data).todos;
//         c.complete(listTodo);
//       } else {
//         print('Exception: ${results.exception}');
//         c.completeError(results.exception.graphqlErrors.first);
//       }
//     } catch (ex, stackTrace) {
//       print(stackTrace.toString());
//       c.completeError(ex.toString());
//     }
//
//     return c.future;
//   }
// }
