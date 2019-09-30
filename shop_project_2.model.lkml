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
  sql_trigger: SELECT 1 ;;
}

explore: sql_derived_table_test {
  #sql_always_where: {% condition sql_derived_table_test.time_filter %} ${created_time} {% endcondition %} ;;

  }




explore: ndt_test {}
explore: order_items {

}
