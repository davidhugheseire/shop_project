connection: "thelook"

include: "*.view.lkml"

datagroup: datagroup3 {
  sql_trigger:  SELECT now()  ;;
  max_cache_age: "20 minutes"
}
