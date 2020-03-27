view: derived_test {
  derived_table: {
    sql: SELECT
  users.state  AS 'state',
  MIN(DATE(users.created_at )) AS 'min_date',
  sum(users.age)  AS 'total_clicks'
FROM demo_db.users  AS users

WHERE
  (users.state  IN ('Texas', 'Florida', 'New Jersey', 'Alabama', 'Colorado'))
GROUP BY 1
HAVING
  total_clicks  > 0
ORDER BY 2  DESC
LIMIT 500;;
    }



dimension: state  {
  type: string
  sql: ${TABLE}.state ;;
}


  dimension_group: min_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.min_date ;;
  }


  measure: total_clicks  {
    type: number
    sql: ${TABLE}.total_clicks ;;
  }

}
