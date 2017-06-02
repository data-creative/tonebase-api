json.extract! ad, :id

json.advertiser ad.advertiser, :id, :name, :description, :url

json.extract! ad, :title, :content, :url, :image_url, :created_at, :updated_at

json.instruments ad.instruments, :id, :name, :description

json.extract! ad, :created_at, :updated_at
