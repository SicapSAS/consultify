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
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.02
            ),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: size.width * 0.03,
                color: AppColors.secondary,
                fontWeight: FontWeight.bold
              )
            )
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04
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
    final size = MediaQuery.of(context).size;
    final statusColor = report.statusColor ?? AppColors.secondaryButton;

    return Container(
      margin: EdgeInsets.only(
        bottom: isLast ? 0 : size.height * 0.015
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(
          size.width * 0.02
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
          padding: EdgeInsets.all(size.width * 0.04),
          child: Row(
            children: [
              Container(
                width: size.width * 0.12,
                height: size.width * 0.12,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(
                    size.width * 0.07
                  )
                ),
                child: Icon(
                  report.icon,
                  color: statusColor,
                  size: size.width * 0.08
                )
              ),
              SizedBox(width: size.width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.title,
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: size.height * 0.005),
                    Text(
                      report.description,
                      style: TextStyle(
                        fontSize: size.width * 0.03 * 0.9,
                        color: AppColors.secondary.withValues(alpha: 0.7)
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                    ),
                    SizedBox(height: size.height * 0.005),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.clock.data,
                          size: size.width * 0.08,
                          color: AppColors.secondary.withValues(alpha: 0.5),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Flexible(
                          child: Text(
                            report.time,
                            style: TextStyle(
                              fontSize: size.width * 0.03,
                              color: AppColors.secondary.withValues(alpha: 0.5),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.003,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  size.width * 0.01,
                                ),
                              ),
                              child: Text(
                                report.type,
                                style: TextStyle(
                                  fontSize: size.width * 0.03 * 0.85,
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
