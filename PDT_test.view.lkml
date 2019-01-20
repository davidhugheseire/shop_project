# If necessary, uncomment the line below to include explore_source.
# include: "shop_project.model.lkml"

view: pdt_AA {
  derived_table: {
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroupA
    persist_for: "5 minutes"
  }
  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}

view: pdt_BB {
  derived_table: {
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroupB
    persist_for: "5 minutes"
  }
  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}

view: pdt_CC {
  derived_table: {
    explore_source: orders {
      column: city { field: users.city }
      column: country { field: users.country }
      column: last_name { field: users.last_name }
      column: count { field: users.count }
    }
    datagroup_trigger: datagroupC
    persist_for: "5 minutes"
  }
  dimension: city {}
  dimension: country {}
  dimension: last_name {}
  dimension: count {
    type: number
  }
}
