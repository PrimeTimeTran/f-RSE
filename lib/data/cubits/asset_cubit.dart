import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';

abstract class AssetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAsset extends AssetEvent {
  final String id;

  FetchAsset(this.id);

  @override
  List<Object?> get props => [id];
}

abstract class AssetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssetInitial extends AssetState {}

class AssetLoading extends AssetState {}

class AssetLoaded extends AssetState {
  final Asset asset;

  AssetLoaded(this.asset);

  @override
  List<Object?> get props => [asset];
}

class AssetError extends AssetState {
  final String errorMessage;

  AssetError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AssetCubit extends Cubit<AssetState> {
  String period = 'live';
  List<CandleStick> current = [];
  Asset asset = Asset.defaultAsset();
  final AssetService assetService = AssetService();

  AssetCubit() : super(AssetInitial());

  Future<void> fetchAsset(String id) async {
    try {
      asset = await assetService.fetchAsset(id, period);
      current = asset.current;
      emit(AssetLoaded(asset));
    } catch (e) {
      emit(AssetError('Error fetching asset'));
    }
  }

  void setPeriod(String p) async {
    period = p;
    await fetchAsset(asset.sym);
  }
}
