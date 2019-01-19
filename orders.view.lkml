view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }


#   measure: dave_test {
#     type: string
#     sql: case when ${cpc_prod_group_name}='%MMA and Savings%' and ${Deposits_pixelflags.Savings_MMA_Engagementrate}>=(3.6*0.95)   then '4'
#               when ${cpc_prod_group_name}='%MMA and Savings%' and ${Deposits_pixelflags.Savings_MMA_Engagementrate}>=(03.6*0.55)  then '3'
#               when ${cpc_prod_group_name}='%MMA and Savings%' and ${Deposits_pixelflags.Savings_MMA_Engagementrate}>=(3.6*0.25)   then '2'
#               when ${cpc_prod_group_name}='%CDs%'             and ${Deposits_pixelflags.CD_EngagementRate}>=(2.15*0.95)           then '4'
#               when ${cpc_prod_group_name}='%CDs%'             and ${Deposits_pixelflags.CD_EngagementRate}>=(2.15*0.58)           then '3'
#               when ${cpc_prod_group_name}='%CDs%'             and ${Deposits_pixelflags.CD_EngagementRate}>=(2.15*0.28)           then '2'
#               when ${cpc_prod_group_name}='%Mortgages%'       and ${cpl_engagement_rate}>=(13.7*1.15)                             then '4'
#               when ${cpc_prod_group_name}='%Mortgages%'       and ${cpl_engagement_rate}>=(13.7*0.8)                              then '3'
#               when ${cpc_prod_group_name}='%Mortgages%'       and ${cpl_engagement_rate}>=(13.7*0.5)                              then '2'
#               when ${cpc_prod_group_name}='%MMA and Savings%'                                                                     then '1'
#               when ${cpc_prod_group_name}='%CDs%'                                                                                 then '1'
#               when ${cpc_prod_group_name}='%Mortgages%'                                                                           then '1'
#               else Null End  ;;}









  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
  }
}
