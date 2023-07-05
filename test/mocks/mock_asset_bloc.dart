import 'package:bloc/bloc.dart';

import 'package:rse/all.dart';

class MockBlocAsset<Event, State> extends Bloc<Event, State> {
  MockBlocAsset() : super(AssetInitial(Asset.defaultAsset()) as State);
}

class MockAssetBloc extends MockBlocAsset<AssetEvent, AssetState>
    implements AssetBloc {
  MockAssetBloc() : super();

  @override
  Asset asset = Asset.defaultAsset();

  @override
  String period = '';

  @override
  String sym = '';

  @override
  void add(AssetEvent event) {
    // TODO: implement add
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    super.addError(error, stackTrace);

    // TODO: implement addError
  }

  @override
  // TODO: implement assetService
  AssetService get assetService => throw UnimplementedError();

  @override
  Future<void> close() {
    super.close();
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  void emit(AssetState state) {
    // TODO: implement emit
  }

  @override
  void fetchAsset(String sym) {
    // TODO: implement fetchAsset
  }

  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();

  @override
  void on<E extends AssetEvent>(EventHandler<E, AssetState> handler,
      {EventTransformer<E>? transformer}) {
    // TODO: implement on
  }

  @override
  void onChange(Change<AssetState> change) {
    super.onChange(change);

    // TODO: implement onChange
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);

    // TODO: implement onError
  }

  @override
  void onEvent(AssetEvent event) {
    super.onEvent(event);

    // TODO: implement onEvent
  }

  @override
  void onTransition(Transition<AssetEvent, AssetState> transition) {
    super.onTransition(transition);

    // TODO: implement onTransition
  }

  @override
  void setPeriod(String p) {
    // TODO: implement setPeriod
  }

  @override
  // TODO: implement state
  AssetState get state => throw UnimplementedError();

  @override
  // TODO: implement stream
  Stream<AssetState> get stream =>
      Stream.fromFuture(Future.value(AssetLoaded(Asset.defaultAsset())));
}
