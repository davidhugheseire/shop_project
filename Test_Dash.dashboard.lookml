- dashboard: test_dash
  title: EmbedTest
  layout: newspaper
  elements:
  - title: Gender State
    name: Gender State
    model: shop_project
    explore: users
    type: looker_pie
    fields:
    - users.count
    - users.gender
    filters: {}
    sorts:
    - users.count desc
    - users.gender
    limit: 2
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      State: users.state
    row: 3
    col: 0
    width: 16
    height: 7
  - title: State
    name: State
    model: shop_project
    explore: users
    type: single_value
    fields:
    - users.state
    filters: {}
    sorts:
    - users.state
    limit: 1
    column_limit: 50
    custom_color_enabled: true
    custom_color: "#538c26"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      State: users.state
    row: 0
    col: 0
    width: 8
    height: 3
  - title: No Of Users
    name: No Of Users
    model: shop_project
    explore: users
    type: single_value
    fields:
    - users.count
    filters: {}
    limit: 1
    column_limit: 50
    custom_color_enabled: true
    custom_color: "#538c26"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    listen:
      State: users.state
    row: 0
    col: 8
    width: 8
    height: 3
  - title: New Tile
    name: New Tile
    model: shop_project
    explore: users
    type: single_value
    fields:
    - users.age
    - users.count
    - users.random_number_2
    sorts:
    - users.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    row: 0
    col: 16
    width: 8
    height: 6
  - title: New Tile
    name: New Tile
    model: shop_project
    explore: users
    type: single_value
    fields:
    - users.age
    - users.random_number_2
    - users.count
    sorts:
    - users.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    row: 6
    col: 16
    width: 8
    height: 6
  - title: New Tile
    name: New Tile
    model: shop_project
    explore: users
    type: single_value
    fields:
    - users.age
    - users.ontime_count
    - users.count
    - users.random_number_2
    sorts:
    - users.count desc
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    row: 10
    col: 0
    width: 8
    height: 6
  filters:
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: shop_project
    explore: users
    listens_to_filters: []
    field: users.state
