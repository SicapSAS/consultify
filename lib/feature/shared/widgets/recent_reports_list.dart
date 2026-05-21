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
              horizontal: AppDimens.widthPercentage(0.04, context),
              vertical: AppDimens.heightPercentage(0.02, context)
            ),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: AppDimens.titleText(context),
                color: AppColors.secondary,
                fontWeight: FontWeight.bold
              )
            )
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.widthPercentage(0.04, context)
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
        bottom: isLast ? 0 : AppDimens.heightPercentage(0.015, context)
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(
          AppDimens.smallBorderRadius(0.02, context)
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
          padding: EdgeInsets.all(AppDimens.widthPercentage(0.04, context)),
          child: Row(
            children: [
              Container(
                width: AppDimens.widthPercentage(0.12, context),
                height: AppDimens.widthPercentage(0.12, context),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(
                    AppDimens.smallBorderRadius(0.07, context)
                  )
                ),
                child: Icon(
                  report.icon,
                  color: statusColor,
                  size: AppDimens.normalIcon(context)
                )
              ),
              SizedBox(width: AppDimens.widthPercentage(0.03, context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.title,
                      style: TextStyle(
                        fontSize: AppDimens.subtitleText(context),
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppDimens.heightPercentage(0.005, context)),
                    Text(
                      report.description,
                      style: TextStyle(
                        fontSize: AppDimens.normalText(context) * 0.9,
                        color: AppColors.secondary.withValues(alpha: 0.7)
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                    ),
                    SizedBox(height: AppDimens.heightPercentage(0.005, context)),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.clock.data,
                          size: AppDimens.tinyIcon(context),
                          color: AppColors.secondary.withValues(alpha: 0.5),
                        ),
                        SizedBox(width: AppDimens.widthPercentage(0.01, context)),
                        Flexible(
                          child: Text(
                            report.time,
                            style: TextStyle(
                              fontSize: AppDimens.tinyText(context),
                              color: AppColors.secondary.withValues(alpha: 0.5),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: AppDimens.widthPercentage(0.02, context)),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimens.widthPercentage(0.02, context),
                                vertical: AppDimens.heightPercentage(0.003, context),
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  AppDimens.smallBorderRadius(0.01, context),
                                ),
                              ),
                              child: Text(
                                report.type,
                                style: TextStyle(
                                  fontSize: AppDimens.tinyText(context) * 0.85,
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
