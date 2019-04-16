view: bla {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


  measure: count {
    type: count
    drill_fields: [age, id]
  }

  dimension: age {
    type: string
    sql: ${TABLE}.age ;;
  }

}
