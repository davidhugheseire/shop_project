view: ndt_test {
    derived_table: {
      explore_source: order_items {
        column: id {}
        column: inventory_item_id {}
        column: order_id {}
        column: returned_date {}
        column: sale_price {}
      }
    }
    dimension: id {
      primary_key: yes
      type: number
    }
    dimension: inventory_item_id {
      type: number
    }
    dimension: order_id {
      type: number
    }
    dimension: returned_date {
      type: date
    }
    measure: sale_price {
      type: sum
      sql: table.sale_price ;;
    }
    measure: count {
      type: count
    }
  }
