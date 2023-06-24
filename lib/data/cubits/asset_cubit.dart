import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rse/data/all.dart';

abstract class AssetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class AssetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssetInitial extends AssetState {
  final Asset asset;

  AssetInitial(this.asset);

  @override
  List<Object?> get props => [asset];
}

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
  late Asset asset;
  String sym = 'GOOGL';
  String period = 'live';
  final AssetService assetService = AssetService();

  AssetCubit({ required this.asset }) : super(AssetInitial(asset));

  Future<void> fetchAsset(String id) async {
    try {
      final newAsset = await assetService.fetchAsset(id, period);
      asset = newAsset;
      emit(AssetLoaded(newAsset));
    } catch (e) {
      emit(AssetError('Error fetching asset'));
    }
  }

  void setPeriod(String p) async {
    period = p;
    await fetchAsset(sym);
  }
}
