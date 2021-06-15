import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:interview_project/common/define_field.dart';
import 'package:interview_project/common/define_service_api.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';

class GraphQLService {
  GraphQLService._internal();

  static String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYW9zYXRuaGFuMTcxOTIzQGdtYWlsLmNvbSIsIm5hbWUiOiJiYW9zYXRuaGFuMTcxOTIzIiwiaWF0IjoxNjA2OTYxMDU4LjM0MiwiaXNzIjoiaHR0cHM6Ly9oYXN1cmEuaW8vbGVhcm4vIiwiaHR0cHM6Ly9oYXN1cmEuaW8vand0L2NsYWltcyI6eyJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6ImJhb3NhdG5oYW4xNzE5MjNAZ21haWwuY29tIiwieC1oYXN1cmEtZGVmYXVsdC1yb2xlIjoidXNlciIsIngtaGFzdXJhLXJvbGUiOiJ1c2VyIn0sImV4cCI6MTYwNzA0NzQ1OH0.fFCmJqvIm3900pmaQWfmIKB36cBWsG74HoNFWkDUJhs';

  static final HttpLink httpLink = HttpLink(graphQLServiceUrl);

  static final AuthLink authLink = AuthLink(getToken: () async {
    _token = await SPref.instance.get(SPrefCache.KEY_ACCESS_TOKEN);
    if (_token.toString().isNotEmpty) {
      return 'Bearer $_token';
    }
    return _token;
  });

  static Map<String, dynamic> getHeaderAuthorizationMap() {
    return <String, dynamic>{
      'headers': {AUTHORIZATION_FIELD: 'Bearer $_token'},
    };
  }

  static final WebSocketLink webSocketLink = WebSocketLink(
    webSocketGraphQLUrl,
    config: const SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initialPayload: getHeaderAuthorizationMap,
    ),
  );

  static final Link link = authLink.concat(httpLink).concat(webSocketLink);

  static final ValueNotifier<GraphQLClient> _graphQL = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    ),
  );

  static final instance = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: link,
      defaultPolicies: DefaultPolicies(
        watchQuery: Policies(
          fetch: FetchPolicy.noCache,
        ),
        query: Policies(
          fetch: FetchPolicy.noCache,
        ),
        mutate: Policies(
          fetch: FetchPolicy.noCache,
        ),
      ),
    ),
  );

  ValueNotifier<GraphQLClient> get graphQL => _graphQL;
}
