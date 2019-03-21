view: sql_derived_table_test {
  derived_table: {
    sql:
        SELECT
            age
            ,city
            ,country
            ,DATE(created_at) as "date"
            ,email
            ,first_name
            ,gender
            ,id
            ,last_name
            ,state
            ,zip
          FROM demo_db.users
          WHERE
          {% condition state_filter %} state {% endcondition %}
          AND
          {% condition date_filter %} created_at {% endcondition %};;
  }

  filter: state_filter {
    type: string
  }



  filter: date_filter {
    type: date
  }



  parameter: date_parameter {
    type: unquoted
    default_value: "before 1 week ago"
    allowed_value: {value:"before 1 week ago"}
    allowed_value: {value:""}
  }






  parameter: delivered_pocs_only {
    type: unquoted
    default_value: "No"
    allowed_value: {value:"Yes"}
    allowed_value: {value:"No"}
  }




  filter: time_filter {
    type: date_time
  }


  dimension_group: created_dave {
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
    sql: ${TABLE}.created_at ;;
  }


#   parameter: delivered_pocs_only {
#     type: unquoted
#     default_value: "No"
#     allowed_value: {value:"Yes"}
#     allowed_value: {value:"No"}
#   }

  dimension: state_liquid {
    type: string
    sql: ${TABLE}.state ;;
    html:
        {% if delivered_pocs_only._parameter_value <> 'Yes' %}
            <p> <> yes!</p>
        {% elsif delivered_pocs_only._parameter_value == 'Yes' %}
            <p> Yes</p>
        {% else %}
            error
        {% endif %};;
  }






  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    html:
    {% if value  > 50 %}
          <h1> {{ value }} " is > 50"</h1>
    {% endif %}
    {{ 'young' | append: '.jpg' }};;
  }

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    html: {{ value | upcase | remove: "NEW"  }} ;;
  }
  dimension: city_without {
    type: string
    sql: ${TABLE}.city ;;
  }


  dimension: city_is_not_null {
    type: string
    sql: ${TABLE}.city ;;
    html:
        {% if value %}
          the city field is not null.
        {% endif %} ;;
  }

  dimension: zip {
    type: string
    sql: ${TABLE}.zip ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    html: {% if value contains "thomas" %}
            Hey there, Thomas!
          {% endif %} ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: gender_icon {
    type: string
    sql: ${TABLE}.gender ;;
    html: icon_url: "
          {% case sql_derived_table_test.state._value %}
          {% when "Texas" %}
          texas
          {% else %}
          not texas
          {% endcase %}";;
  }


  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }



  measure: returned_count {
    type: count_distinct
    sql: ${id} ;;
    filters: {
      field: gender
      value: "m"
    }
    link: {label: "Explore Top 20 Results" url: "{{ link }}&limit=20" }
  }








  dimension_group: created {
    type: time
    timeframes: [time, date, week, month, hour, minute]
    sql: ${TABLE}.date ;;
  }








#
#   dimension: time {
#     sql:
#     CASE
#       WHEN
#         datediff(
#                 'day',
#                 cast({% date_start created_date %} as date),
#                 cast({% date_end created_date  %} as date)
#                 ) >365
#       THEN ${created_week}
#
#       WHEN
#         datediff(
#                 'day',
#                 cast({% date_start created_date %} as date),
#                 cast({% date_end created_date  %} as date)
#                 ) >30
#       THEN ${created_date}
#
#
#       WHEN
#         datediff(
#                 'day',
#                 cast({% date_start created_date %} as date),
#                 cast({% date_end created_date  %} as date)
#                 ) >1
#       THEN ${created_hour}
#       ELSE ${created_minute}
#       END
#
#     ;;
#
#
#     }


  measure: count {
    type: count
  }




}
