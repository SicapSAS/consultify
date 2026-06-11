import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportItem {
  final IconData icon;
  final String title;
  final String description;
  final String time;
  final String type;
  final Color? statusColor;

  const ReportItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    this.statusColor
  });
}

class RecentReportsList extends StatelessWidget {
  final List<ReportItem> reports;
  final String? title;

  const RecentReportsList({
    super.key,
    required this.reports,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12
            ),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.secondary,
                fontWeight: FontWeight.bold
              )
            )
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 16
          ),
          itemCount: reports.length,
          itemBuilder: (context, index) {
            return ReportSummaryCard(
              report: reports[index],
              isLast: index == reports.length - 1,
            );
          }
        )
      ]
    );
  }
}

/// Card de resumen para reportes que no son tickets (CRM, marcaciones, etc.).
class ReportSummaryCard extends StatelessWidget {
  final ReportItem report;
  final bool isLast;

  const ReportSummaryCard({
    super.key,
    required this.report,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = report.statusColor ?? AppColors.secondaryButton;

    return Container(
      margin: EdgeInsets.only(
        bottom: isLast ? 0 : 12
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(
          12
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2)
          )
        ]
      ),
      child: InkWell(
        onTap: () {
          // Aquí se puede agregar navegación o acción
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(
                    12
                  )
                ),
                child: Icon(
                  report.icon,
                  color: statusColor,
                  size: 14
                )
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      report.description,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.secondary.withValues(alpha: 0.7)
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.clock.data,
                          size: 14,
                          color: AppColors.secondary.withValues(alpha: 0.5),
                        ),
                        SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            report.time,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.secondary.withValues(alpha: 0.5),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 12),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                              child: Text(
                                report.type,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: statusColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}
