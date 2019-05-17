  view: table4 {
    derived_table: {
      sql:
      SELECT
        id as order_id,
       ${orders.random_measure}  as table1_measure
      FROM
        orders ;;
    }

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: table1_measure {
      type: number
      sql: ${TABLE}.table1_measure ;;
    }

  }
