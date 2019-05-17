- dashboard: table_next_lookml_dashboard
  title: Table_Next_Dash
  layout: newspaper
  elements:
  - title: Table_Next_look
    name: Table_Next_look
    model: shop_project
    explore: orders
    type: looker_grid
    fields: [orders.created_month, orders.count, orders.status, orders.accum]
    sorts: [orders.created_month, orders.status]
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    row: 0
    col: 0
    width: 24
    height: 10
