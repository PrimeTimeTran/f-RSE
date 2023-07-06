import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rse/all.dart';

class MockAssetService extends Mock implements AssetService {
  @override
  Future<Asset> fetchAsset(String sym, String period) async {
    return super.noSuchMethod(
      Invocation.method(#fetchAsset, [sym, period]),
      returnValue: Future.value(Asset.defaultAsset()),
      returnValueForMissingStub: Future.value(Asset.defaultAsset()),
    );
  }
}

void main() {
  group('AssetBloc', () {
    late AssetBloc bloc;
    late MockAssetService mockAssetService;

    setUp(() {
      mockAssetService = MockAssetService();
      bloc = AssetBloc(
          asset: Asset.defaultAsset(), assetService: mockAssetService);
    });

    test('AssetBloc initialization', () {
      final asset = Asset.defaultAsset();
      final bloc = AssetBloc(asset: asset, assetService: mockAssetService);
      expect(bloc.state, AssetInitial(asset));
    });

    test('AssetBloc service to not be null', () {
      // Expect a value to not be null
      expect(bloc.assetService, isNotNull);
    });

    test('AssetInitialized event', () {
      final newAsset = Asset.defaultAsset();

      bloc.add(AssetInitialized(newAsset));

      expectLater(
        bloc.stream,
        emitsInOrder([
          AssetLoaded(newAsset),
        ]),
      );
    });

    test('AssetErrored event', () {
      bloc.add(AssetErrored());

      expectLater(
        bloc.stream,
        emitsInOrder([
          AssetError('Error'),
        ]),
      );
    });

    test('fetchAsset success', () async {
      final newAsset = Asset.defaultAsset();
      when(mockAssetService.fetchAsset('GOOGL', 'live'))
          .thenAnswer((_) async => newAsset);

      bloc.fetchAsset('GOOGL');

      await expectLater(
        bloc.stream,
        emitsInOrder([
          AssetLoaded(newAsset),
        ]),
      );
    });
  });
}
