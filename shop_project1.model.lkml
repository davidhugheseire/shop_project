connection: "thelook"

include: "*.view.lkml"                       # include all views in this project

datagroup: datagroupA {
  max_cache_age: "1 minute"
  sql_trigger: SELECT now() ;;
}

datagroup: datagroupB {
  max_cache_age: "12 hours"
  sql_trigger: SELECT 1 ;;
}

datagroup: datagroupC {
  max_cache_age: "12 hours"
  sql_trigger: SELECT 1 ;;
}
