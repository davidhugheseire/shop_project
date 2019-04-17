view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }


  measure: count {
    type: count
    drill_fields: [age, id]
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
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
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }



  dimension: date_formatted {
   label: "Date_formatted"
    sql: ${created_date} ;;
    html:
    {% if _user_attributes['region'] == 'EU' %}
    {{ rendered_value | date: "%b %d, %y" }}
     {% endif %}
     {% if _user_attributes['region'] == 'USA' %}
     {{ rendered_value | date:  "%a, %b %d, %y" }}
    {% else %}
    {{ rendered_value | date: "%y %d, %b" }}
    {% endif %};;
  }

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
        <ol>
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
        <ul style="list-style-type:square;">
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

  measure: percent_ontime {
    type: number
    sql: 100.0 * ${count}/NULLIF(${count},0) ;;
    value_format: "#.00\%"
  }

  measure: ontime_facts {
    type: number
    sql: ${percent_ontime} ;;
    html: |
        <div style="width:100%; text-align: right;">
        Ontime Count: {{ ontime_count._linked_value }}
        <br/>
        Percent Ontime: {{ percent_ontime._linked_value }}
        </div> ;;
  }




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




}
