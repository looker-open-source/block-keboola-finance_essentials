connection: "@{connection}"

# include all the views
include: "/views/**/*.view"

datagroup: keboola_block_xero_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: keboola_block_xero_default_datagroup

explore: account {}

explore: account_balance {
  join: account {
    type: left_outer
    sql_on: ${account_balance.account_id} = ${account.account_id} ;;
    relationship: many_to_one
  }
}

explore: contact {}

explore: invoice {
  join: contact {
    type: left_outer
    sql_on: ${invoice.contact_id} = ${contact.contact_id} ;;
    relationship: many_to_one
  }
}

explore: invoice_item {
  join: invoice {
    type: left_outer
    sql_on: ${invoice_item.invoice_id} = ${invoice.invoice_id} ;;
    relationship: many_to_one
  }

  join: contact {
    type: left_outer
    sql_on: ${invoice.contact_id} = ${contact.contact_id} ;;
    relationship: many_to_one
  }
}
