connection: "thelook"

# include all the views
include: "*.view"
include: "*.view"




explore: order_items {
  join: orders {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.order_id} = ${orders.id} ;;
  }
  join: buyers {
    from: users
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.id} = ${buyers.id} ;;
    fields: [-age, -zip]
  }
  join: sellers {
    from: users
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.id} = ${sellers.id} ;;
    fields: [-age, -zip]
  }
}
