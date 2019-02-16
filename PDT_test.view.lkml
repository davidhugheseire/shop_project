# If necessary, uncomment the line below to include explore_source.
# include: "shop_project.model.lkml"

view: pdt_AAA {
  derived_table: {
    indexes: ["city"]
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }

    datagroup_trigger: datagroupA
  }




  dimension: city {}

  dimension: country {}

  dimension: last_name {}

  dimension: count {
    type: number
  }

#   dimension : dynamic_date {
#     type: date
#     sql:  {% if table2.period_type._parameter_value == 'first_name' %}
#           ${users.first_name}
#           {% elsif table2.period_type._parameter_value == 'last_name' %}
#           ${users.last_name};;
#
#   }


}












view: pdt_BBB {
  derived_table: {
    indexes: ["city"]
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroupB
  }
  parameter: Last_Name {
    type: unquoted
    allowed_value: {
      label: "Heck"
      value: "Heck"
    }
    allowed_value: {
      label: "Raabe"
      value: "Raabe"
    }
  }


  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}

view: pdt_CCC {
  derived_table: {
    indexes: ["city"]
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroupC
  }
  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}
