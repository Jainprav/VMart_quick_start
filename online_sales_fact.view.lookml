- view: online_sales_fact
  sql_table_name: online_sales.online_sales_fact
  fields:

  - dimension: call_center_key
    type: int
    sql: ${TABLE}.call_center_key

  - dimension: cost_dollar_amount
    type: number
    sql: ${TABLE}.cost_dollar_amount
    hidden: true
    
  - dimension: customer_key
    type: int
    sql: ${TABLE}.customer_key

  - dimension: gross_profit_dollar_amount
    type: number
    sql: ${TABLE}.gross_profit_dollar_amount
    hidden: true

  - dimension: net_dollar_amount
    type: number
    sql: ${TABLE}.net_dollar_amount

  - dimension: online_page_key
    type: int
    sql: ${TABLE}.online_page_key

  - dimension: pos_transaction_number
    type: int
    sql: ${TABLE}.pos_transaction_number

  - dimension: product_key
    type: int
    sql: ${TABLE}.product_key

  - dimension: product_version
    type: int
    sql: ${TABLE}.product_version

  - dimension: promotion_key
    type: int
    sql: ${TABLE}.promotion_key

  - dimension: sale_date_key
    type: int
    sql: ${TABLE}.sale_date_key
    hidden: true

  - dimension: sales_dollar_amount
    type: number
    sql: ${TABLE}.sales_dollar_amount
    hidden: true
    
  - dimension: sales_quantity
    type: int
    sql: ${TABLE}.sales_quantity

  - dimension: ship_date_key
    type: int
    sql: ${TABLE}.ship_date_key

  - dimension: ship_dollar_amount
    type: number
    sql: ${TABLE}.ship_dollar_amount

  - dimension: shipping_key
    type: int
    sql: ${TABLE}.shipping_key

  - dimension: transaction_type
    sql: ${TABLE}.transaction_type

  - dimension: warehouse_key
    type: int
    sql: ${TABLE}.warehouse_key

  - measure: count
    type: count
    drill_fields: []
  
  - measure: total_sales
    type: sum
    sql: ${sales_dollar_amount}
    value_format: '$#,##0.00'
    drill_fields: [promotion_dimension.ad_type, total_sales]
    
  - measure: total_cost
    type: sum
    sql: ${cost_dollar_amount}
    value_format: '$#,##0.00'
    
  - measure: total_profit
    type: sum
    sql: ${gross_profit_dollar_amount}
    value_format: '$#,##0.00'
      
  - measure: total_quantity
    type: sum
    sql: ${sales_quantity}
    
  - filter: measure_type
    suggestions: [Cost, Sales, Profit, Quantity]

  - measure: measure_total
    type: number
    sql: |
      case
        when {% parameter measure_type %} = 'Cost' then ${total_cost}
        when {% parameter measure_type %} = 'Sales' then ${total_sales}
        when {% parameter measure_type %} = 'Profit' then ${total_profit}
        when {% parameter measure_type %} = 'Quantity' then ${total_quantity}
      end

    