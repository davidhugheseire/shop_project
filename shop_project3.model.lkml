connection: "thelook"

include: "*.view.lkml"

datagroup: datagroup1 {
  max_cache_age: "12 hours"
  sql_trigger: SELECT now() ;;
}

datagroup: datagroup2 {
  max_cache_age: "12 hours"
  sql_trigger: SELECT 1 ;;
}

datagroup: datagroup3 {
  max_cache_age: "12 hours"
  sql_trigger: SELECT 1 ;;
}
