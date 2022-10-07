import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:equatable/equatable.dart';

class Leads extends Equatable {
  final int id;
  final String name;
  final bool active;
  final int partner_id;
  final DateTime date_action_last;
  final String email_from;
  final String website;
  final int team_id;
  final String email_cc;
  final String description;
  final DateTime create_date;
  final DateTime write_date;
  final String contact_name;
  final String partner_name;
  final bool opt_out;
  final String type;
  final int priority;
  final DateTime date_closed;
  final int stage_id;
  final int user_id;
  final String referred;
  final DateTime date_open;
  final double day_open;
  final double day_close;
  final DateTime date_last_stage_update;
  final DateTime date_conversion;
  final int message_bounce;
  final double probability;
  final double planned_revenue;
  final DateTime date_deadline;
  final int color;
  final String street;
  final String street2;
  final String zip;
  final String city;
  final int state_id;
  final int country_id;
  final String phone;
  final String mobile;
  final String function;
  final int title;
  final int company_id;
  final int lost_reason;
  final int campaign_id;
  final int source_id;
  final int medium_id;
  final DateTime message_last_post;
  final DateTime activity_date_deadline;
  final int create_uid;
  final int write_uid;

  const Leads(
    this.active,
    this.partner_id,
    this.date_action_last,
    this.email_from,
    this.website,
    this.team_id,
    this.email_cc,
    this.description,
    this.create_date,
    this.write_date,
    this.contact_name,
    this.partner_name,
    this.opt_out,
    this.type,
    this.priority,
    this.date_closed,
    this.stage_id,
    this.user_id,
    this.referred,
    this.date_open,
    this.day_open,
    this.day_close,
    this.date_last_stage_update,
    this.date_conversion,
    this.message_bounce,
    this.probability,
    this.planned_revenue,
    this.date_deadline,
    this.color,
    this.street,
    this.street2,
    this.zip,
    this.city,
    this.state_id,
    this.country_id,
    this.phone,
    this.mobile,
    this.function,
    this.title,
    this.company_id,
    this.lost_reason,
    this.campaign_id,
    this.source_id,
    this.medium_id,
    this.message_last_post,
    this.activity_date_deadline,
    this.create_uid,
    this.write_uid, {
    required this.id,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
