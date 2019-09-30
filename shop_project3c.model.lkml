connection: "thelook"

# include all the views
include: "*.view"
include: "*.view"
include: "*.dashboard.lookml"
include: "sql_derived_table_test.view.lkml"


# explore: user_data {
#   join: users {
#     type: left_outer
#     sql_on:
#     {% if users.age._value == '200' %}
#     ${user_data.user_id} = ${users.id}
#     {% else %}
#     ${user_data.user_id} = ${users.age}
#     {% endif %} ;;
#     relationship: many_to_one
#   }
# }

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
  always_filter: {
    filters: {
      field: id
      value: "123"
    }
  }
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
    sql_on:
    {% if users.age._value == '20' %}
    ${users.id} = ${orders.user_id}
    {% else %}
    ${users.age} = ${orders.user_id}
    {% endif %} ;;
    relationship: many_to_one
  }
}


explore: users {}
