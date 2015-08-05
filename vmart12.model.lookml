- connection: vmart

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards


- explore: store_sales_fact
  fields: [ALL_FIELDS*, -product_dimension.department_description]
  joins:
    - join: customer_dimension
      foreign_key: customer_key
      type: inner
    
    - join: date_dimension
      foreign_key: date_key
      type: inner
    
    - join: product_dimension
      sql_on: store_sales_fact.product_key = product_dimension.product_key and store_sales_fact.product_version = product_dimension.product_version
      relationship: many_to_one
      type: inner
    
    - join: promotion_dimension
      foreign_key: promotion_key
      type: inner
      
    - join: employee_dimension
      foreign_key: employee_key
      #view_label: ""
      type: inner
    
    - join: store_dimension
      foreign_key: store_key
      #view_label: ""
      type: inner
      
- explore: online_sales_fact
  fields: [ALL_FIELDS*, -product_dimension.store_department_description]
  joins: 
    - join: customer_dimension
      foreign_key: customer_key
      type: inner
    
    - join: date_dimension_sales
      from: date_dimension
      foreign_key: sale_date_key
      type: inner
    
    - join: date_dimension_ship
      from: date_dimension
      foreign_key: ship_date_key
      type: inner
    
    - join: product_dimension
      sql_on: online_sales_fact.product_key = product_dimension.product_key and online_sales_fact.product_version = product_dimension.product_version
      relationship: many_to_one
      type: inner
      
    - join: call_center_dimension
      foreign_key: call_center_key
      type: inner
    
    - join: promotion_dimension
      foreign_key: promotion_key
      type: inner
      
    - join: shipping_dimension
      foreign_key: shipping_key
      type: inner
      
    - join: warehouse_dimension
      foreign_key: warehouse_key
      type: inner
       
- explore: store_orders_fact
  joins:
    - join: vendor_dimension
      foreign_key: vendor_key
      type: inner

    - join: store_dimension
      foreign_key: store_key
      type: inner


- explore: inventory_fact
  joins:
    - join: product_dimension
      sql_on: inventory_fact.product_key = product_dimension.product_key and inventory_fact.product_version = product_dimension.product_version
      relationship: many_to_one
      type: inner
      
    - join: date_dimension
      foreign_key: date_key
      type: inner      
    
    - join: warehouse_dimension
      foreign_key: inventory_fact.warehouse_key
      type: inner
    
    - join: latest_date_fact
      sql_on: ${date_dimension.date_date} = ${latest_date_fact.latest_date}
      relationship: many_to_one
