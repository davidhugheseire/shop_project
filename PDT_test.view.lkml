# If necessary, uncomment the line below to include explore_source.
# include: "shop_project.model.lkml"

view: PDT_1 {
  derived_table: {
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroup1
  }
  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}

view: PDT_2 {
  derived_table: {
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroup2
  }
  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}

view: PDT_3 {
  derived_table: {
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroup3
  }
  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}
