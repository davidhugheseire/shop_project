# If necessary, uncomment the line below to include explore_source.
# include: "shop_project.model.lkml"

view: pdt_AAA {
  derived_table: {
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroupA
    persist_for: "1 minute"
  }
  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}

view: pdt_BBB {
  derived_table: {
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroupB
    persist_for: "1 minute"
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
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroupC
    persist_for: "1 minute"
  }
  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}
