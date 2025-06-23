import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'models/game_item.dart';

class ApiService {
  final Dio _dio;
  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://www.mmobomb.com/api1',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

  /// Fetches a list of games from the MMOBomb API.
  Future<List<GameItem>> getListGames() async {
    try {
      log('Sending request to: /games');
      final response = await _dio.get('/games');
      log('Response status: ${response.statusCode}');
      log('Response data type: ${response.data.runtimeType}');

      if (response.statusCode == 200 && response.data is List) {
        log('Successfully received ${(response.data as List).length} games');
        return (response.data as List)
            .map((json) => GameItem.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Unexpected response: status=${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException: ${e.type} - ${e.message}');
      if (e.response != null) {
        log('Response data: ${e.response!.data}');
        log('Response status: ${e.response!.statusCode}');
      }
      throw Exception('Failed to fetch games: ${e.message}');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Error fetching games: $e');
    }
  }

  /// Fetches games filtered by platform.
  Future<List<GameItem>> getGamesByPlatform(String platform) async {
    try {
      log('Sending request to: /games?platform=$platform');
      final response = await _dio.get(
        '/games',
        queryParameters: {'platform': platform},
      );
      log('Response status: ${response.statusCode}');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => GameItem.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Unexpected response: status=${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException: ${e.type} - ${e.message}');
      throw Exception('Failed to fetch games by platform: ${e.message}');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Error fetching games by platform: $e');
    }
  }

  /// Fetches games filtered by category.
  Future<List<GameItem>> getGamesByCategory(String category) async {
    try {
      log('Sending request to: /games?category=$category');
      final response = await _dio.get(
        '/games',
        queryParameters: {'category': category},
      );
      log('Response status: ${response.statusCode}');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => GameItem.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Unexpected response: status=${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException: ${e.type} - ${e.message}');
      throw Exception('Failed to fetch games by category: ${e.message}');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Error fetching games by category: $e');
    }
  }

  /// Fetches games sorted by the specified criterion.
  Future<List<GameItem>> getGamesSortedBy(String sortBy) async {
    try {
      log('Sending request to: /games?sort-by=$sortBy');
      final response = await _dio.get(
        '/games',
        queryParameters: {'sort-by': sortBy},
      );
      log('Response status: ${response.statusCode}');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => GameItem.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Unexpected response: status=${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException: ${e.type} - ${e.message}');
      throw Exception('Failed to fetch sorted games: ${e.message}');
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('Error fetching sorted games: $e');
    }
  }

  /// Closes the Dio instance to free resources.
  void dispose() {
    _dio.close(force: true);
  }
}
