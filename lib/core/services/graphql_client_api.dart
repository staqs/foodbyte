import 'package:flutter/material.dart';
import 'package:flutter_foodybite/core/services/apiservice.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLClientAPI extends APIService {
  static HttpLink httpLink = HttpLink(
    uri: "https://foododeringsystem.herokuapp.com/admin/api",
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  static GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }

  @override
  void logSomething() {
    // TODO: implement logSomething
  }
}
