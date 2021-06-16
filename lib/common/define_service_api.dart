// Get Config App
import 'package:global_configuration/global_configuration.dart';

import 'common.dart';

GlobalConfiguration config = GlobalConfiguration();
final String graphQLAuthUrl = config.getValue(GraphQLAuthUrl);
final String graphQLServiceUrl = config.getValue(GraphQLServiceUrl);
final String webSocketGraphQLUrl = config.getValue(WebSocketGraphQLUrl);
final String mediaApiEnvironment = config.getValue(MediaApiEnvironment);
final String defaultLanguageCode = config.getValue(DefaultLanguageCode);
final String discordWebHooksUrl = config.getValue(DiscordWebHooksUrl);

// Define API
const URN_API_LOGIN = 'login/';
const URN_API_SIGN_UP = 'signup/';
