import 'dart:convert';

import 'package:backtix_app/src/data/models/event/event_model.dart';
import 'package:backtix_app/src/data/models/event/event_query.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'event_service.g.dart';

@RestApi()
abstract class EventService {
  factory EventService(Dio dio, {String? baseUrl}) = _EventService;

  @GET('events')
  Future<HttpResponse<List<EventModel>>> getPublishedEvents(
    @Queries() EventQuery? query,
  );

  @GET('events/nearby')
  Future<HttpResponse<List<EventModel>>> getNearbyPublishedEvents([
    @Query('count') int? count,
    @Query('distance') int? distance,
  ]);

  @GET('events/{id}')
  Future<HttpResponse<EventModel>> getPublishedEventDetail(
    @Path('id') String id,
  );

  @GET('events/my')
  Future<HttpResponse<List<EventModel>>> getMyEvents(
    @Queries() EventQuery? query,
  );

  @GET('events/my/{id}')
  Future<HttpResponse<EventModel>> getMyEventDetail(
    @Path('id') String id,
  );

  @POST('events')
  @MultiPart()
  Future<HttpResponse<EventModel>> createNewEvent({
    @Part(name: 'event') required List<MultipartFile> eventImageFiles,
    @Part(name: 'ticket') required List<MultipartFile> ticketImageFiles,
    @Part() required String name,
    @Part() required String description,
    @Part() required String date,
    @Part() String? endDate,
    @Part() required String location,
    @Part() double? latitude,
    @Part() double? longitude,
    @Part() required List<String> categories,
    @Part() required List<String> imageDescriptions,
    @Part() required List<Map<String, dynamic>> tickets,
  });
}
