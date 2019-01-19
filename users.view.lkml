view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }



  measure: is_over40 {
    type: yesno
    sql:${age} > 40 ;;
  }


measure: L90BD_LOL_CNT {
sql: (${TABLE}.age) ;;
type: sum
}








###############################################################################
  dimension: cpc_prod_group_name{
    view_label: "Product Detail"
    label: "cpc_product_group name"
    hidden: yes
    type: string
    sql: ${TABLE}.state  ;;
    drill_fields: [zip]}



  dimension: vertical_prod_group {
    label: "Vertical Product Group"
    view_label: "Product Detail"
    #description: "Vertical Group drill down level 1 (Auto, CDs, Checking, Home Equity, MMA and Savings, Mortgages, Personal Loans)"
    drill_fields: [vertical_prod_group, zip]
    sql: CASE WHEN ${cpc_prod_group_name} like '%Maine%' THEN 'CDs'
              WHEN ${cpc_prod_group_name} like '%New York%' THEN 'MMA and Savings'
              ELSE ${cpc_prod_group_name}
              END;;
  }


  measure: dave_test2 {
    type: number
    sql:      case
              when ${vertical_prod_group}='MMA and Savings'      then 1
              when ${vertical_prod_group}='CDs'                  then 2
              when ${vertical_prod_group}='Mortgages'            then 3
              else Null End  ;;}


  ###############################################################################



  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
