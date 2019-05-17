view: table3 {
  derived_table: {
    explore_source: orders {
      column: id {
        field: orders.id
      }
      column: count {
        field: orders.count
      }
    }
  }
  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }
  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
  }

  measure: order_count {
    type: number
    sql: ${count}  ;;
  }



}
