connection: "thelook"

include: "*.view.lkml"                       # include all views in this project

datagroup: datagroup2 {
  sql_trigger:  SELECT now()  ;;
  max_cache_age: "10 minutes"
}
