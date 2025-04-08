typedef Json = Map<String, dynamic>;
typedef JsonList = List<Json>;
typedef JsonResponseDecoder<T> = T Function(Json json);
typedef JsonListResponseDecoder<T> = T Function(JsonList jsonList);
