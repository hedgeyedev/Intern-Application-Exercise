class Comment < ApplicationRecord
  http_basic_authenticate_with name: "username", password: "password", except: [:index, :show]

  belongs_to :post
end
