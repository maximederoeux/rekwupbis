json.array!(@return_boxes) do |return_box|
  json.extract! return_box, :id, :delivery_id, :return_time, :is_back, :receptionist, :ctrl_time, :ctrler, :is_controlled
  json.url return_box_url(return_box, format: :json)
end
