import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/models/all.dart';
import 'package:rse/data/services/all.dart';

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
  String assetId = '';
  String period = 'live';
  String sym = 'GOOGL';
  List<CandleStick> current = [];
  final AssetService assetService = AssetService();

  AssetCubit() : super(AssetInitial());

  Future<void> fetchAsset(String id) async {
    emit(AssetLoading());
    try {
      assetId = id;
      final a = await assetService.fetchAsset(assetId, period);
      sym = a.sym!;
      current = a.current;
      emit(AssetLoaded(a));
    } catch (e) {
      emit(AssetError('Error fetching asset'));
    }
  }

  void setPeriod(String p) async {
    period = p;
    await fetchAsset(assetId);
  }
}
