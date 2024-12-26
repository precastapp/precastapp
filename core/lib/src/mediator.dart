import 'package:medartor/medartor.dart';

typedef Request<TResponse> = IRequest<TResponse>;

typedef RequestHandler<TRequest extends IRequest<TResponse>, TResponse>
    = IRequestHandler<TRequest, TResponse>;

typedef Mediator<T> = Medartor<T>;

final mediator = Mediator();