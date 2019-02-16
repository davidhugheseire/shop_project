connection: "thelook"

# include all the views
include: "*.view"

datagroup: datagroupA {
  max_cache_age: "1 minute"
  sql_trigger: SELECT now() ;;
}

datagroup: datagroupB {
  max_cache_age: "1  minute"
  sql_trigger: SELECT 1 ;;
}

datagroup: datagroupC {
  max_cache_age: "1 minute"
  sql_trigger: SELECT 1 ;;
}





datagroup: schedule_datagroup_hourly {
  max_cache_age: "24 hours"
  sql_trigger:  SELECT FLOOR(UNIX_TIMESTAMP() / (1*60*60)) ;;
}

datagroup: schedule_datagroup_etl {
  max_cache_age: "24 hours"
  sql_trigger:    SELECT COUNT(*) FROM orders;;
}

datagroup: schedule_datagroup_etls {
  max_cache_age: "24 hours"
  sql_trigger:    SELECT max(load_date) FROM orders;;
}





explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}

explore: users_nn {}

explore: pdt_AAA {}
explore: pdt_BBB {}
explore: pdt_CCC {}
