connection: "thelook"

include: "*.view.lkml"                       # include all views in this project
include: "ndt_test.view.lkml"
include: "order_items.view.lkml"


# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

datagroup: datagroupA {
  max_cache_age: "1 minute"
  sql_trigger: SELECT NOW() ;;
}

explore: PDT_sql_derived_table {
  #sql_always_where: {% condition sql_derived_table_test.time_filter %} ${created_time} {% endcondition %} ;;

  }

explore: users {
}


# explore: ndt_test {}
#explore: order_items {}

explore: derived_test{}


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





explore: orders {
  always_filter: {
    filters: {
      field: created_at_dave
      value: "this year"
    }
}}









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





#explore: schema_migrations {}
