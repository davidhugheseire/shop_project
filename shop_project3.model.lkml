connection: "thelook"

include: "*.view.lkml"

datagroup: datagroup7 {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "1 minutes"
}

datagroup: datagroup8 {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "1 minutes"
}

datagroup: datagroup9 {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "1 minutes"
}
