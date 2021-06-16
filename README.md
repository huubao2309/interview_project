# INTERVIEW APP


## FRAMEWORK:

```dart
	Flutter: 2.2.1
	IDE: Android studio v4.2.1
```


## FIX RUN PROJECT WITH FLAVOR:

* If you has error:

![Error_Run](https://github.com/huubao2309/interview_project/blob/main/images/error_run.png)

* Fix it:

![Change_config](https://github.com/huubao2309/interview_project/blob/main/images/edit_config.png)

![fix_error](https://github.com/huubao2309/interview_project/blob/main/images/fix_error.png)


## FIX RENDER GRAPHQL:

* If you has error:

![error_graphql](https://github.com/huubao2309/interview_project/blob/main/images/graphql/error_graphql.png)

* Fix it with script:

```dart
	flutter pub run build_runner build
```

![run_script](https://github.com/huubao2309/interview_project/blob/main/images/graphql/run_script.png)

![run_script_success](https://github.com/huubao2309/interview_project/blob/main/images/graphql/run_script_success.png)

* Result:

![show_data_folder](https://github.com/huubao2309/interview_project/blob/main/images/graphql/show_data_folder.png)


## HOW TO CREATE A NEW FILE GRAPHQL?:

### B1: Create file at **\graphql_queries**

- With **Query**: create at **\graphql_queries\query**

- With **Mutation**: create at **\graphql_queries\mutation**

- With **Subscription**: create at **\graphql_queries\subscription**


### B2: Add **schema_mapping** at **build.yaml**

- With **Query**:

```dart
	schema_mapping:
		- schema: graphql_schema/schema.graphql
		  queries_glob: graphql_queries/query/[name_file]_query.graphql
		  output: lib/data/graphql/query/[name_file]_query_graphql.dart
```	

- With **Mutation**:

```dart
	schema_mapping:
		- schema: graphql_schema/schema.graphql
		  queries_glob: graphql_queries/mutation/[name_file]_mutation.graphql
		  output: lib/data/graphql/mutation/[name_file]_mutation_graphql.dart
```	

- With **Subscription**:

```dart
	schema_mapping:
		- schema: graphql_schema/schema.graphql
		  queries_glob: graphql_queries/subscription/[name_file]_subscription.graphql
		  output: lib/data/graphql/subscription/[name_file]_subscription_graphql.dart
```	

- **Note**: **[name_file]** should match with query at **schema.graphql**

### B3: Delete folder **lib\data\graphql**

### B4: Run script at Terminal

```dart
	flutter pub run build_runner build
```

### B5: Test file at **lib\data\graphql\**

- With **Query**: create at **lib\data\graphql\query**

- With **Mutation**: create at **lib\data\graphql\mutation**

- With **Subscription**: create at **lib\data\graphql\subscription**

### Refer:
- Refer: https://hasura.io/learn/graphql/flutter-graphql/setup/

