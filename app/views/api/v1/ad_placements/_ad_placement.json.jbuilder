json.extract! ad_placement, :id

json.ad ad_placement.ad, :id, :title, :content, :url, :image_url

json.extract! ad_placement, :start_date, :end_date, :price, :created_at, :updated_at
