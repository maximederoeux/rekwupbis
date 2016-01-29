json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :doc_number, :offer_id, :client_id, :doc_invoice, :doc_credit
  json.url invoice_url(invoice, format: :json)
end
