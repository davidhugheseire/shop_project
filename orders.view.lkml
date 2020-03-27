view: orders {




  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }



  dimension: created_at_dave {
    type: date
    sql: ${TABLE}.created_at ;;
  }


  dimension_group: created_at_dave {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      quarter,
      day_of_week_index,
      day_of_week,
      hour_of_day,
      week_of_year,
      year
    ]
    sql:${TABLE}.created_at;;
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

  measure: count {
    type: count

  }

  measure: random_measure {
    type: sum
    sql: round(rand() * 0.49 + 0.01, 10) * 1000  ;;
  }



  filter: status_filter {
    type: string
    suggest_dimension: status
  }


  }

#   dimension: status_satisfies_filter {
#     type: yesno
#     sql: {% condition status_filter %} ${status} {% endcondition %} ;;
#   }
#
#
#   measure: count_of_status {
#     type: count
#     drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count]
#   filters: {
#     field: status_satisfies_filter
#     value: "yes"
#   }
#   }
#
#   measure: %_percent {
#     type: number
#     sql: sum(${count_of_status}/${count}) ;;
#   }
#
#
#
#
#
# }
