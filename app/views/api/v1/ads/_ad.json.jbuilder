json.extract! ad, :id

json.advertiser ad.advertiser, :id, :name, :description, :url

json.extract! ad, :title, :content, :url, :image_url, :created_at, :updated_at
