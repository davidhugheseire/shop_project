view: inventory_items {
  sql_table_name: demo_db.inventory_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.costs ;;
  }



  measure: cost_m {
    type: number
    sql: sum(${TABLE}.costs) ;;
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
      day_of_week,
      week_of_year,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }


  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      day_of_week,
      week_of_year,
      year
    ]
    sql: ${TABLE}.sold_at ;;
  }

  dimension_group: one_week_ago_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      day_of_week,
      week_of_year,
      year
    ]
    sql: DATE(${sold_date} - INTERVAL -7 DAY) ;;
  }





  measure: count_items {
    type: sum
   sql: IFNULL(${id},0) ;;
  }


  measure: count {
    type: count
    drill_fields: [id, products.item_name, products.id, order_items.count]
  }
}
