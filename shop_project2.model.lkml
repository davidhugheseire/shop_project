connection: "thelook"

include: "*.view.lkml"                       # include all views in this project

datagroup: datagroup1 {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "1 minutes"
}

datagroup: datagroup2 {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "1 minutes"
}

datagroup: datagroup3 {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "1 minutes"
}
