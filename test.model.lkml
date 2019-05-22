connection: "thelook"

# include all the views
include: "*.view"
include: "*.view"




explore: order_items {
  join: orders {
    view_label: "This is Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.order_id} = ${orders.id} ;;
  }
  join: buyers {
    view_label: "This is Buyers"
    from: users
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.id} = ${buyers.id} ;;
    fields: [-age, -zip]
  }
  join: sellers {
    view_label: "This is Sellers"
    from: users
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.id} = ${sellers.id} ;;
    fields: [-age, -zip]
  }
}
