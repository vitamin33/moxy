import 'package:moxy/data/models/response/dashboard_response.dart';

class AdsReport {
  String spend;
  String spendInUah;
  String reach;
  String cpm;
  String ctr;
  String cpc;

  AdsReport({
    required this.spend,
    required this.spendInUah,
    required this.reach,
    required this.cpm,
    required this.cpc,
    required this.ctr,
  });

  factory AdsReport.defaultReport() {
    return AdsReport(
      spend: '0',
      spendInUah: '0',
      reach: '0',
      cpm: '0',
      ctr: '0',
      cpc: '0',
    );
  }

  factory AdsReport.fromResponse(AdsReportResponse dto) {
    return AdsReport(
      spend: dto.spend,
      spendInUah: dto.spendInUah,
      reach: dto.reach,
      cpm: dto.cpm,
      ctr: dto.ctr,
      cpc: dto.cpc,
    );
  }
}
