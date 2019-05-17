connection: "thelook"

# include all the views
include: "*.view"
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

datagroup: schedule_hourly {
  max_cache_age: "24 hours"
  sql_trigger:  SELECT FLOOR(UNIX_TIMESTAMP() / (1*60*60)) ;;
}

datagroup: schedule_row_change {
  max_cache_age: "24 hours"
  sql_trigger:    SELECT COUNT(*) FROM orders;;
}

datagroup: schedule_date_change {
  max_cache_age: "24 hours"
  sql_trigger:    SELECT max(created_at) FROM orders;;
}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
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


explore: users {
  access_filter: {
    field: users.id
    user_attribute: storeid
  }
}
explore: orders {}
explore: extended_users_male {}
explore: schema_migrations {}
