import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/utils/platform_utils.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/License/model/license_response/license_data.dart';
import 'package:smarthealth_hcp/Features/License/view_model/license_view_model.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';

class LicenseScreen extends StatefulWidget {
  const LicenseScreen({super.key});

  @override
  State<LicenseScreen> createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  late LicenseViewModel licenseViewModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    licenseViewModel = context.read<LicenseViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadLicenses();
    });
  }

  Future<void> _loadLicenses() async {
    setState(() => isLoading = true);
    await licenseViewModel.getLicenses();
    if (mounted) {
      if (licenseViewModel.userError.success != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: themeBlueColor,
            content: Text(
              licenseViewModel.userError.message.toString(),
              style: appTextStyle.copyWith(color: Colors.white),
            ),
          ),
        );
      }
      setState(() => isLoading = false);
    }
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'active':
        return greenColor;
      case 'expired':
        return redColor;
      case 'suspended':
        return orangeColor;
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    final l10n = AppLocalizations.of(context)!;
    switch (status) {
      case 'active':
        return l10n.license_active;
      case 'expired':
        return l10n.license_expired;
      case 'suspended':
        return l10n.license_suspended;
      case 'cancelled':
        return l10n.license_cancelled;
      default:
        return status ?? '';
    }
  }

  Color _getDaysColor(int? days) {
    if (days == null) return Colors.grey;
    if (days > 30) return greenColor;
    if (days > 7) return orangeColor;
    return redColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.licenses,
          style: appTextStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: PlatformUtils.isAndroid
                  ? const CircularProgressIndicator(color: themeBlueColor)
                  : const CupertinoActivityIndicator(
                      radius: 18, color: themeBlueColor),
            )
          : RefreshIndicator(
              onRefresh: _loadLicenses,
              color: themeBlueColor,
              child: licenseViewModel.licensesData.isEmpty
                  ? ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.license_no_licenses,
                            style: appTextStyle.copyWith(
                              fontSize: 16,
                              color: grey,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: licenseViewModel.licensesData.length,
                      itemBuilder: (context, index) {
                        return _buildLicenseCard(
                            licenseViewModel.licensesData[index]);
                      },
                    ),
            ),
    );
  }

  Widget _buildLicenseCard(LicenseData license) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project name and status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    license.projectName ?? '',
                    style: appTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(license.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getStatusColor(license.status),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _getStatusText(license.status),
                    style: appTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(license.status),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Plan name
            if (license.planName != null)
              Text(
                '${l10n.license_plan}: ${license.planName}',
                style: appTextStyle.copyWith(
                  fontSize: 14,
                  color: grey,
                ),
              ),
            const SizedBox(height: 12),

            // Expiry info
            if (license.endsAt != null)
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: grey),
                  const SizedBox(width: 6),
                  Text(
                    '${l10n.license_expires_on}: ${license.endsAt}',
                    style: appTextStyle.copyWith(fontSize: 13, color: grey),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color:
                          _getDaysColor(license.daysRemaining).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${license.daysRemaining ?? 0} ${l10n.license_days_remaining}',
                      style: appTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getDaysColor(license.daysRemaining),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),

            // Auto renew
            if (license.autoRenew != null)
              Row(
                children: [
                  Icon(
                    license.autoRenew == true
                        ? Icons.autorenew
                        : Icons.sync_disabled,
                    size: 16,
                    color: license.autoRenew == true ? greenColor : grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${l10n.license_auto_renew}: ${license.autoRenew == true ? l10n.yes : l10n.no}',
                    style: appTextStyle.copyWith(fontSize: 13, color: grey),
                  ),
                ],
              ),

            const Divider(height: 24),

            // Usage bars
            _buildUsageBar(
              l10n.license_patients,
              license.currentPatients ?? 0,
              license.maxPatients,
            ),
            const SizedBox(height: 8),
            _buildUsageBar(
              l10n.license_doctors,
              license.currentDoctors ?? 0,
              license.maxDoctors,
            ),
            const SizedBox(height: 8),
            _buildUsageBar(
              l10n.license_voucher_services,
              license.currentVouchers ?? 0,
              license.maxVoucherServices,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageBar(String label, int current, int? max) {
    final l10n = AppLocalizations.of(context)!;
    final isUnlimited = max == null || max == 0;
    final progress = isUnlimited ? 0.0 : (current / max).clamp(0.0, 1.0);
    final progressColor = progress > 0.9
        ? redColor
        : progress > 0.7
            ? orangeColor
            : themeBlueColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: appTextStyle.copyWith(fontSize: 12, color: grey),
            ),
            Text(
              isUnlimited
                  ? '$current / ${l10n.license_unlimited}'
                  : '$current ${l10n.license_of} $max',
              style: appTextStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: isUnlimited ? 0.0 : progress,
            backgroundColor: lightGreyColor,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
