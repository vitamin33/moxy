import 'package:moxy/domain/copyable.dart';

class DashboardState implements Copyable<DashboardState> {
  final String totalBalance;
  final String totalProduct;

  DashboardState({
    required this.totalBalance,
    required this.totalProduct,
  });

  static defaultDashboardState() {
    return DashboardState(
      totalBalance:'0',
      totalProduct: '12', 
    );
  }

  @override
  DashboardState copyWith({
    String? totalBalance,
    String? totalProduct
  }) {
    return DashboardState(
      totalBalance :this.totalBalance ,
      totalProduct :this.totalProduct
    );
  }
}
