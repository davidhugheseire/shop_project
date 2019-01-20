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
