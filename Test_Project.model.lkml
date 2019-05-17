connection: "thelook"

include: "*.view"







explore: orders {}
explore: users {}
explore: table3 {}


explore: test {
  from: orders
  join:  users{
  type: left_outer
  sql_on: ${test.user_id} = ${users.id} ;;
  relationship: many_to_one
}}
