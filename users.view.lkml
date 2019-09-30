view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }


  measure: count {
    type: count
    drill_fields: [age, id]
  }


#   measure: total_outstanding_principal_USD {
#     type: sum_distinct
#     description: "Sums total outstanding principal for set of leases, in USD"
#     sql: ${principal_ar_balance_USD};;
#     value_format: "$#,##0,\" K\""
#     drill_fields: [detail*]
#   }




  measure: table2_measure {
    type: sum
    sql: round(rand() * 0.49 + 0.01, 10) * 1000  ;;
    #value_format: "usd_0"
  }

    measure: total_outstanding_principal_USD {
    type: sum_distinct
    description: "Sums total outstanding principal for set of leases, in USD"
    sql: ${age};;
    value_format: "$#,##0,\" K\""
    drill_fields: [detail*]
  }

  measure: sale_2018_per {
    label: "% Sales LY"
    type: number
    sql: ${TABLE}.age ;;
    html: {{ value | times: 2 | round : 0 }};;

    }

  measure: sale_2018_per_no_liquid {
    label: "% Sales LY_no liquid"
    type: number
    sql: ${TABLE}.age ;;

  }


measure: count_all {
  type: count
}



  dimension: long_age {
    type: number
    sql: CONCAT("123456789101234", ${TABLE}.age );;
  }


  dimension: origination_proc_fee {
    type: number
    value_format_name: usd_0
    sql: ${age};;
  }





  measure: duration_count {
    type: sum
    sql: case when ${age} <= '{% parameter duration %}'
      THEN 1
      ELSE null
      END ;;
  }

  parameter: duration {
    type: number
  }






  measure: count_ages {
    type: count
    filters: {
      field: age
      value: "-28"
    } filters: {
      field: age
      value: "-25"
    }
}


  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################
  dimension: state_no_liquid{
    type: string
    sql: ${TABLE}.state ;;
  }


  parameter: liquid_filter_test {
    type: unquoted
    allowed_value: { label: "Upercase" value: "upcase" }
    allowed_value: { label: "Size" value: "size" }
    allowed_value: { label: "append" value: "append" }
    allowed_value: { label: "replace" value: "replace" }
    allowed_value: { label: "slice last 3" value: "slice" }
  }

  parameter: liquid_filter_test1 {
    type: string
    allowed_value: { label: "Upercase" value: "upcase" }
    allowed_value: { label: "Size" value: "size" }
  }

  parameter: liquid_filter_test2 {
    type: number
    allowed_value: { label: "less than 600" value: "< 600" }
    allowed_value: { label: "greater than 1000" value: "> 1000" }
  }

  dimension: state_liquid {
    type: string
    sql: ${TABLE}.state ;;
    html:
        {% if liquid_filter_test._parameter_value == 'upcase' %}
            <p> {{ value | upcase }}</p>
        {% elsif liquid_filter_test._parameter_value == 'size' %}
            <p> {{ value }} has {{ value | size }} letters!</p>
        {% elsif liquid_filter_test._parameter_value == 'append' %}
            <p> {{ value | append:'.com' }} </p>
        {% elsif liquid_filter_test._parameter_value == 'replace' %}
            <p> {{ value | replace:'a','XXX' }} </p>
        {% elsif liquid_filter_test._parameter_value == 'slice' %}
            <p> {{ value | slice: -3, 3 }}</p>
        {% else %}
            error
        {% endif %};;
  }


    ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################

  measure: random_number_2 {
    type: sum
    sql: round(rand() * 0.49 + 0.01, 10) ;;
  }



  dimension:spend {
    type: string
    sql:"Content spend ";;
  }



  parameter: liquid_number_test {
    type: unquoted
    allowed_value: { label: "ceil" value: "ceil" }
    allowed_value: { label: "floor" value: "floor" }
    allowed_value: { label: "round" value: "round" }
    allowed_value: { label: "divide by 3" value: "divide" }
    allowed_value: { label: "multiply by age" value: "multiply" }
  }

  measure: number_liquid {
    type: number
    sql: ${TABLE}.age ;;
    html:
        {% if liquid_number_test._parameter_value == 'ceil' %}
            <p>{{ users.random_number_2._value | ceil }}</p>
        {% elsif liquid_number_test._parameter_value == 'floor' %}
            <p>{{ users.random_number_2._value | floor }}</p>
        {% elsif liquid_number_test._parameter_value == 'round' %}
            <p>{{ users.random_number_2._value | round }}</p>
        {% elsif liquid_number_test._parameter_value == 'divide' %}
            <p>{{ users.random_number_2._value | divided_by:3 }}</p>
        {% elsif liquid_number_test._parameter_value == 'multiply' %}
            <p>{{ users.random_number_2._value | times: users.age._value }}</p>
        {% else %}
            error
        {% endif %};;
  }

  parameter: liquid_number_test_1 {
    type: number
    default_value: "10"
  }

  measure: number_liquid_1 {
    type: number
    sql: {% parameter liquid_number_test_1 %} * 10;;
  }


  #ceil - rounds a number up to the nearest integer, e.g. {{ 4.6 | ceil }} #=> 5


   ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################


  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_name,
      day_of_week_index,
      day_of_week,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

dimension: testtttt {
  type: yesno
  sql: ${created_date};;
}


#   dimension: date_formatted {
#    label: "Date_formatted"
#     sql: ${created_date} ;;
#     html:
#     {% if _user_attributes['region'] == 'EU' %}
#     {{ rendered_value | date: "%b %d, %y" }}
#      {% endif %}
#      {% if _user_attributes['region'] == 'USA' %}
#      {{ rendered_value | date:  "%a, %b %d, %y" }}
#     {% else %}
#     {{ rendered_value | date: "%y %d, %b" }}
#     {% endif %};;
#   }






  dimension: week_formatted {
    label: "Week"
    sql: ${created_week} ;;
    html: {{ rendered_value | date: "%A, %B %e, %Y" }};;
  }

  dimension: month_formatted {
    label: "Month"
    sql: ${created_month} ;;
    html: {{ rendered_value | append: "-01" |  date: "%B %Y" }};;
  }


dimension: yes_test {
  type: yesno
  sql: ${age}>30 ;;
}
  dimension: yes_test1 {
    type: yesno
    sql: ${age}<30 ;;
  }
  dimension: yes_test2 {
    type: yesno
    sql: ${state}='Texas' ;;
  }

dimension: test_dimension {
  type: string
  sql: CASE
  WHEN ${yes_test} = FALSE
  THEN "Reviews Only"
  ELSE NULL END;;
}

#   dimension: segments {
#     type: string
#     sql: CASE
#     WHEN ${review_feedback_patterns.reviews_user_year} > 0.5
#     AND cast(${meetings_segment.meetings_over_median} as string) = "No"
#     AND ${meetings_segment.praises_over_median} = "No"
#     AND ${objectives_segment.objectives_over_median} = "No" THEN "Reviews Only"
#       ELSE NULL END;;
# }

######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################





######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################  ######################




###################################################HTML


  dimension: state {
    label: "Daves Test"
    view_label: ""
    type: string
    sql: ${TABLE}.state ;;
    html: <center><mark>{{ value }}<mark></center> ;;
  }

#   dimension: long_string {
#     type: string
#     sql: '13423994_4860367_Involve Asia Technologies Sdn Bhd_8732022_dee0904d43aa11e9826d031f0a18050d' ;;
#   }
#
#   dimension: long_string_split_liquid {
#     type: string
#     sql:   {% assign words = users.long_string._value | split: '_' %}
#            {% for word in words %}
#            {{ word }}
#           {% endfor %} ;;
#   }
#
#   dimension: long_string_split_sql {
#     type: string
#     sql: substring_index(${long_string}, '_', n);;
#   }
#






  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    html: <center><i><font face="romain" size="10" color="red">{{ value }}</font></i></center> ;;
  }

  dimension: whitespace {
    type: string
    sql: concat(' ', ${TABLE}.country );;

  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    html: <center><b>{{ value }}</b><ins> State = {{ state }}  </ins></center> ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
    drill_fields: [detail*]
    html:
        <ol type="1">
          <li>
            Field: <p style="font-size: 30px">{{linked_value}}</p>
          </li>
          <li>
            Value:  {{ users.city._value }}
          </li>
      </ol>;;
  }
#{{ view_name.field_name._rendered_value }}

  measure: random_number {
    type: sum
    sql: round(rand() * 0.49 + 0.01, 10) ;;
    html:
        <ul>
          <li>
            value: {{ value }}
          </li>
          <li>
            rendered_value:
                {% if value < 0.1 %}
              <font color="darkgreen">{{ rendered_value }}</font>
                {% elsif value > 0.2 %}
              <font color="goldenrod">{{ rendered_value }}</font>
                {% else %}
              <font color="darkred">{{ rendered_value }}</font>
                {% endif %}
          </li>
        </ul> ;;
  }

  dimension: project_details {
    type: string
    sql: 1 ;;
    html:
        <ul style="list-style-type:number;">
          <li>
            model: {{ _model._name }}
          </li>
          <li>
            view: {{ _view._name }}
          </li>
          <li>
            explore: {{ _explore._name }}
          </li>
          <li>
            field: {{ _field._name }}
          </li>
          <li>
            dialect: {{ _dialect._name }}
          </li>
        </ul> ;;
  }


  dimension: gender_img {
    sql: ${TABLE}.gender ;;
    html:
      {% if value == 'f' %}
         <p><img src="https://findicons.com/files/icons/827/livejournal/128/user_female.png" height=20 width=20></p>
      {% elsif value == 'm' %}
        <p><img src="https://findicons.com/files/icons/61/dragon_soft/128/user.png" height=20 width=20></p>
      {% else %}
        <p><img src="http://findicons.com/files/icons/719/crystal_clear_actions/64/cancel.png" height=20 width=20></p>
      {% endif %}
;;
  }





#   dimension: gender {
#     sql: ${TABLE}.gender ;;
#     html: {% if value == 'Shipped' or value == 'Complete' %}
#          <p><img src="http://findicons.com/files/icons/573/must_have/48/check.png" height=20 width=20></p>
#       {% elsif value == 'Processing' %}
#         <p><img src="http://findicons.com/files/icons/1681/siena/128/clock_blue.png" height=20 width=20></p>
#       {% else %}
#         <p><img src="http://findicons.com/files/icons/719/crystal_clear_actions/64/cancel.png" height=20 width=20></p>
#       {% endif %}
# ;;
#   }


#       <li> access filter: {{ _access_filters['company.name'] }} </li>
#       <li> user attribute: {{ _user_attributes['region'] }} </li>
#       <li> query timezone: {{ _query._query_timezone }} </li>
#       <li> filters: {{ _filters['order.total_order_amount'] }} </li>



#  html: {{ rendered_value | date: "%b %d, %y" }}



  measure: ontime_count{
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id]
  }

  measure: value_measure {
    type: number
    sql: 100.0 * ${count}/NULLIF(${count},0) ;;
    value_format_name: usd_0
  }

#   measure: ontime_facts {
#     type: number
#     sql: ${percent_ontime} ;;
#     html: |
#         <div style="width:100%; text-align: right;">
#         Ontime Count: {{ ontime_count._linked_value }}
#         <br/>
#         Percent Ontime: {{ percent_ontime._linked_value }}
#         </div> ;;
#   }





###################################################HTML

measure: new_age {
  type: number
  sql: ${TABLE}.age ;;
}




  #https://discourse.looker.com/t/easy-date-formatting-with-liquid/8087




  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
    html:
    {% if value == 'm' %}
    <h1 style="color: blue; background-color: black; font-size:100px; text-align:center">{{ value }}</h1>
    {% elsif value == 'f' %}
    <h1 style="color: pink; background-color: black; font-size:100px; text-align:center">{{ value }}</h1>
    {% endif %}
    ;;
  }


#   dimension: status {
#     sql: ${TABLE}.status ;;
#     html: {% if value == 'Paid' %}
#       <p style="color: black; background-color: lightblue; font-size:100%; text-align:center"></p>
#     {% elsif value == 'Shipped' %}
#       <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center"></p>
#     {% else %}
#       <p style="color: black; background-color: orange; font-size:100%; text-align:center"></p>
#     {% endif %}
# ;;
#   }



  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: html_test {
    type: string
   sql:  ${TABLE}.last_name ;;
    html: <p style="color: black; background-color: lightblue; font-size:50px; text-align:center"> {{ value }} </p> ;;
  }




  measure: test_measure {
    type: number
    sql: case when ${age} > 50  then 1 else 0;;
  }

#   dimension: test_deminsion {
#     type: string
#     sql:  case when ${test_measure} > 1 then "Good" else "Bad" ;;
#
#   }

#
#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }

#   measure: count {
#     type: count
#
#   }



  measure: is_over40 {
    type: yesno
    sql:${age} > 40 ;;
  }


measure: L90BD_LOL_CNT {
sql: (${TABLE}.age) ;;
type: sum
drill_fields: [detail*]
    html:
    <a href="#drillmenu" target="_self">
      {% if value > 10000 %}
        <font color="#42a338 ">{{ rendered_value }}</font>
      {% elsif value > 5000 %}
        <font color="#ffb92e ">{{ rendered_value }}</font>
      {% else %}
        <font color="#fa4444 ">{{ rendered_value }}</font>
      {% endif %}
    </a>;;
}

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      state,
    ]
  }



  # dimension: date_format {
  #   sql:
  #     CASE
  #     WHEN '{{ _user_attributes["locale"] }}' = 'en_gb' THEN '%Y-%d-%m'
  #     WHEN '{{ _user_attributes["locale"] }}' = 'en' THEN '%A %d %B %Y'
  #     ELSE '%Y-%m-%d'
  #     END ;;
  # }

  # dimension: lcd_formatted {
  #   type: date
  #   label: "{{ _localization['users.lcd_formatted']}}"
  #   sql: ${created_date};;
  #   html: {{ rendered_value | date: {{date_format}} ;;
  # }

  dimension_group: created_test {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_name,
      day_of_week_index,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }


#   filter: created_test_filter {
#     type: date
#   }
#
#   dimension: hidden_created_test_filter {
#     hidden: yes
#     type: yesno
#     sql: {% condition created_test_filter %} ${created_test_date} {% endcondition %} ;;
#   }
#
#   measure: changeable_count_measure {
#     type: number
#     sql: sum(${count}) ;;
#     filters: {
#       field: hidden_created_test_filter
#       value: "Yes"
#     }
#   }

  parameter: date_filter {
    type: date_time
    allowed_value: {
      label: "Yesterday"
      value: "Yesterday"
    }
    allowed_value: {
      label: "Week to date"
      value: "This week"
    }
    allowed_value: {
      label: "Last week"
      value: "Last Week"
    }
    allowed_value: {
      label: "Month to date"
      value: "This Month"
    }
    allowed_value: {
      label: "Last month"
      value: "Last Month"
    }
    allowed_value: {
      label: "Quarter to date"
      value: "This Quarter"
    }
    allowed_value: {
      label: "Last quarter"
      value: "Last Quarter"
    }
    allowed_value: {
      label: "Year to date"
      value: "This Year"
    }
    allowed_value: {
      label: "Full year LY"
      value: "Last Year"
    }
  }



  dimension: month_incomplete {
    type: yesno
    sql: ${created_month_name} = "April" ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: country_name_status {
    type: number
    sql: case when ${month_incomplete} then 1 else 0 end ;;
   html: {{users.state_name._rendered_value}} ;;
  }


  measure: age_1 {
    sql: ${TABLE}.age ;;
    html:
    {% if value <= 50 %}
      <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value > 50 %}
      <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
      <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
;;
  }

dimension: state_html {
  type: string
  sql: ${TABLE}.state ;;
}

measure: test_html {
  sql: ${TABLE}.state ;;
  html:
{% if ${state_html._value} == "Florida" %} <p style="color: red;">{{ rendered_value }}</p>
{% elsif ${state_html._value} == "Ohio" %} <p style="color: yellow;">{{ rendered_value }}</p>
{% else %} <p style="color: green;">{{ rendered_value }}</p>
{% endif %};;}



  dimension: Criteria{
  type: number
  sql: 1,2,3,4 ;;
  }

###############################################################################
#   dimension: cpc_prod_group_name{
#     view_label: "Product Detail"
#     label: "cpc_product_group name"
#     hidden: yes
#     type: string
#     sql: ${TABLE}.state  ;;
#     drill_fields: [zip]}



#   dimension: vertical_prod_group {
#     label: "Vertical Product Group"
#     view_label: "Product Detail"
#     #description: "Vertical Group drill down level 1 (Auto, CDs, Checking, Home Equity, MMA and Savings, Mortgages, Personal Loans)"
#     drill_fields: [vertical_prod_group, zip]
#     sql: CASE WHEN ${cpc_prod_group_name} like '%Maine%' THEN 'CDs'
#               WHEN ${cpc_prod_group_name} like '%New York%' THEN 'MMA and Savings'
#               ELSE ${cpc_prod_group_name}
#               END;;
#   }
#
#
#   measure: dave_test2 {
#     type: number
#     sql:      case
#               when ${vertical_prod_group}='MMA and Savings' and ${age} >=(50+1)    then 11111
#               when ${vertical_prod_group}='CDs'             and ${age} >=(50+2)    then 22222
#               when ${vertical_prod_group}='Mortgages'       and ${age} >=(50*3)    then 333333
#               else null End  ;;}
#

  ###############################################################################

  dimension: display_text {
    type: string
    html:
        Date: {{ _filters['users.created_date'] }}
      <br>
      {% if _filters['users.state_name'] == "" %}
         Brand:Any Value
      {% else %}
       {{ _filters['users.state_name'] }}
      {% endif %}
    <br>
     {% if _filters['users.country'] == "" %}
        Country: Any Value
    {% else %}
       {{ _filters['users.country'] }}
      {% endif %}
      ;;
    sql: 1 ;;}





# {% else %}
#       {{ _filters['users.state_name'] }}
#       {% endif %}
#       <br>
#       Country: {% if _filters['digital_info.country_name'] == "" %}
#       Any Value
#       {% else %}
#      {{ _filters['digital_info.country_name'] }}


#   dimension: display_text {
#     html: Date: {{ _filters['combined_engagement_date.engagement_date'] }}
#       <br>
#       Brand: {% if _filters['digital_info.brand_name'] == "" %}
#       Any Value
#       {% else %}
#       {{ _filters['digital_info.brand_name'] }}
#       {% endif %}
#       <br>
#       Country: {% if _filters['digital_info.country_name'] == "" %}
#       Any Value
#       {% else %}
#       {{ _filters['digital_info.country_name'] }}
#       {% endif %}
#       ;;
#     sql: 1 ;;



  dimension_group: created_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_name,
      day_of_week_index,
      week_of_year,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

#   parameter: jb_month_of{
#     type: string
#     allowed_value: { value: "Address provided" }
#     allowed_value: { value: "Delivery" }
#     allowed_value: { value: "Auctoins" }
#     allowed_value: { value: "Deals" }
#     allowed_value: { value: "GMV" }
#   }
#
#
#   dimension: jb_date_picker{
#     label_from_parameter: jb_month_of
#     type: date
#     sql:
#       CASE
#       WHEN {% parameter jb_month_of %} = 'Address provided' THEN
#       ${users.created_date_date}::text
#       WHEN {% parameter jb_month_of %} = 'Delivery' THEN
#       ${users.created_date_time}::text
#       WHEN {% parameter jb_month_of %} = 'Auctions' THEN
#       ${users.created_date_day_of_month}::text
#       WHEN {% parameter jb_month_of %} = 'Deals' THEN
#       ${users.created_date_month_name}::text
#       WHEN {% parameter jb_month_of %} = 'GMV' THEN
#       ${users.created_date_day_of_week_index}::text
#       ELSE
#       NULL
#       END ;;
#   }




  dimension_group: created_A {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_name,
      day_of_week_index,
      week_of_year,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }


  dimension_group: test_date_formatted {
    sql:  ${created_A_date} ;;
    html: {{ rendered_value | date: "%b %d, %H%p" }};;
  }

  dimension: created_financial_quarter_first_day {
    type: date
    sql: DATE_TRUNC('w',DATEADD('w',1,DATEADD(day,-1,DATE_TRUNC('qtr', ${created_A_raw})))) ;;
  }

#   dimension: 445_financial_month {
#     datatype: date
#     sql:
#     CASE WHEN ${created_A_week_of_year} = 1
#     AND ${created_A_date} < ${created_financial_quarter_first_day}
#     OR ${created_A_week_of_year} = 1
#     AND ${created_A_date} > DATEADD('y',-1,${created_A_date})
#     THEN 'FM' || 12
#     WHEN ${created_A_week_of_year} between 1 AND 4 THEN 'FM ' || 1
#     WHEN ${created_A_week_of_year} between 5 AND 8 THEN 'FM ' || 2
#     WHEN ${created_A_week_of_year} between 9 AND 13 THEN 'FM ' || 3
#     WHEN ${created_A_week_of_year} between 14 AND 17 THEN 'FM ' || 4
#     WHEN ${created_A_week_of_year} between 18 AND 21 THEN 'FM ' || 5
#     WHEN ${created_A_week_of_year} between 22 AND 26 THEN 'FM ' || 6
#     WHEN ${created_A_week_of_year} between 27 AND 30 THEN 'FM ' || 7
#     WHEN ${created_A_week_of_year} between 31 AND 34 THEN 'FM ' || 8
#     WHEN ${created_A_week_of_year} between 35 AND 39 THEN 'FM ' || 9
#     WHEN ${created_A_week_of_year} between 40 AND 43 THEN 'FM ' || 10
#     WHEN ${created_A_week_of_year} between 44 AND 47 THEN 'FM ' || 11
#     ELSE 'FM' || 12
#     END ;;
#   }



#   dimension: test_checker {
#     type: string
#     sql: ${city} ;;
#     html:
#         {% if users.state == " " %}
#       "Blank"
#     {% elsif users.state == "Texas" %}
#       "Not blank"
#     {% else %}
#         "booooooooooooooo"
#     {% endif %}
#     ;;
#   }
#
  dimension: test_checker {
    type:  number
    sql: ${age_11} ;;
    html:
    {% if ${age_11} == 50 %}
      "1"
    {% elsif ${age_11} == "' '" %}
      "0"
    {% else %}
      "999"
    {% endif %}
;;
  }

  dimension: age_11 {
    type: number
    sql: case when ${TABLE}.age > 50 then "' '" else ${TABLE}.age end ;;
  }




  dimension_group: created_B {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      day_of_month,
      month_name,
      day_of_week_index,
      week_of_year,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  parameter: test_filter {
    type: string
    default_value: "12 weeks"
    allowed_value: {
      label: "12 weeks"
      value: "12 weeks"
    }
    allowed_value: {
      label: "6 months"
      value: "6 months"
    }
  }


# filter: test_dave {
#   suggest_dimension: users.state
# }
#
#   dimension: date_check {
#     type: yesno
#     sql: ( case when {% parameter test_filter %} = "6 months" then  ${created_B_date} > DATE_SUB(now(), INTERVAL 6 MONTH)
#       when {% parameter test_filter %} = "12 weeks" then  ${created_B_date} > DATE_SUB(now(), INTERVAL 30 WEEK) end ) ;;
#   }
#
#   dimension: date_check_test {
#     type: string
#     sql: CASE WHEN ${users.date_check} = 'yes'
#        THEN "This is Good"
#        ELSE "This is Bad"
#        END ;;
#
#   }


  measure: test_1 {#hello
    type:  number
    sql: -6.12345 ;;
  }

  measure: test_2 {
    type:  number
    sql: -6.12345 ;;
  }

  measure: test_3 {
    type:  number
    sql: -6.12345 ;;
  }




#   measure: test_count {
#       type: count
#       filters: {
#         field: date_check
#         value: "yes"
#       }
#     }


  dimension: age_test {
    type: number
    sql: ${TABLE}.age ;;
    link: {
      label: "{{ value }} Analytics Dashboard"
      url: "https://dcltraining.dev.looker.com/dashboards/24"
  }
    link: {
      label: "{{ age }} Analytics Dashboard"
      url: "https://dcltraining.dev.looker.com/dashboards/24"
    }}


  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  link: {
    label: "{{ age }} Analytics Dashboard"
    url: "https://dcltraining.dev.looker.com/dashboards/24"
  }


  }
}
