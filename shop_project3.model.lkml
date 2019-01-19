connection: "thelook"

include: "*.view.lkml"

datagroup: datagroupA {
  max_cache_age: "12 hours"
  sql_trigger: SELECT 1 ;;
}

datagroup: datagroupB {
  max_cache_age: "12 hours"
  sql_trigger: SELECT 1 ;;
}

datagroup: datagroupC {
  max_cache_age: "12 hours"
  sql_trigger: SELECT 1 ;;
}
