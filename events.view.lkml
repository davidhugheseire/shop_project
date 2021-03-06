view: events {
  sql_table_name: demo_db.events ;;

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

  dimension: type_id {
    type: number
    sql: ${TABLE}.type_id ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: value_amt {
    type: string
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id]
  }

  measure: ontime_count{
  type: count
  drill_fields: [id, users.first_name, users.last_name, users.id]
}

measure: percent_ontime {
  type: number
  sql: 100.0 * ${count}/NULLIF(${count},0) ;;
  value_format: "#.00\%"
}

measure: ontime_facts {
  type: number
  sql: ${percent_ontime} ;;
  html: |
  <div style="width:100%; text-align: right;">
  Ontime Count: {{ ontime_count._linked_value }}
  <br/>
  Percent Ontime: {{ percent_ontime._linked_value }}
  </div> ;;
}

}
