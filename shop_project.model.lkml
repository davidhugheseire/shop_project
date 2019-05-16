connection: "thelook"

# include all the views
include: "*.view"
include: "*.view"
include: "*.dashboard.lookml"

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


explore: bla {}


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
  sql_always_where: (orders.created_at ) >= ((DATE_ADD(TIMESTAMP(DATE_FORMAT(CURDATE(),'%Y-%m-01')),INTERVAL -6 month)))
                AND (orders.created_at ) < ((DATE_ADD(DATE_ADD(TIMESTAMP(DATE_FORMAT(CURDATE(),'%Y-%m-01')),INTERVAL -6 month),INTERVAL 6 month))) ;;
#   join: users {
#     type: left_outer
#     sql_on: ${orders.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
}

# explore: products {
#   sql_always_where:
#   {% if delivered_pocs_only._parameter_value <> 'Yes' %}
#   ${brand} = '  555 Turnpike'
#   {% elsif delivered_pocs_only._parameter_value == 'Yes' %}
#   ${brand} = '7 Diamonds'
#   {% else %}
#   error
#   {% endif %};;
# }

explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  access_filter: {
    field: users.id
    user_attribute: storeid
  }

}
explore: users_nn {}
explore: extended_users_male {

}
