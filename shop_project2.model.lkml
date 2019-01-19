connection: "thelook"

include: "*.view.lkml"                       # include all views in this project

datagroup: datagroup4 {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "1 minutes"
}

datagroup: datagroup5 {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "1 minutes"
}

datagroup: datagroup6 {
  sql_trigger: SELECT 1 ;;
  max_cache_age: "1 minutes"
}
