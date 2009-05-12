## Gems ##

gem 'mislav-will_paginate',
  :lib => 'will_paginate',  :source => 'http://gems.github.com'
  
gem 'rubyist-aasm',
 :lib => 'aasm', :source => 'http://gems.github.com'

gem 'activemerchant',
  :lib => 'active_merchant'

gem 'prawn',
  :lib => 'prawn', :source => 'http://gems.github.com'
  

# install necessary gems
rake 'gems:install'



## Plugins ##

plugin 'prawnto',
  :git => 'git://github.com/thorny-sun/prawnto.git'

plugin 'restful-authentication', 
  :git => 'git://github.com/technoweenie/restful-authentication.git'

plugin 'role_requirement',
  :git => 'git://github.com/bricooke/role_requirement.git'

plugin 'acts_as_tree',
  :git => 'git://github.com/rails/acts_as_tree.git'

plugin 'acts_as_list',
  :git => 'git://github.com/rails/acts_as_list.git'



## Generate Authentication ##
generate("authenticated", "User Session --aasm")
generate("roles", "UserRole User")
  


### Opensteam Application Template ####
require 'opensteam/template'


# generate opensteam
# using the authenticated 'User' model
opensteam :webshop, :user => "User" do
  
  # generate the catalog (products, properties and inventories controller/views for the admin-backend)
  catalog do
    product
    property
    inventory
  end
  
  # generate a sample frontend
  frontend :url => "ivellio_vellin"

  # generate the sales namespace (order, invoice and shipment controller/views for the admin-backend)
  # installs the opensteam_order, opensteam_shipment and opensteam_invoice plugins from github (http://github.com/opensteam)
  sales do
    order
    invoice
    shipment
  end
  
  # generate the config namespace
  config do
    # install the opensteam_shipping_rates plugin from github
    shipping_rates
  end
  

end

# generate a new opensteam product model called 'Notebook'
generate 'opensteam_product', 'Notebook'

# generate two new opensteam property models called 'Display' and 'Ram'
generate 'opensteam_property', 'Display'
generate 'opensteam_property', 'Ram'


# create and migrate the database
rake 'db:create:all'
rake 'db:migrate'

# bootstrap opensteam (creates an admin user and some dummy data for shipping_rates and payment_types)
rake 'opensteam:bootstrap'

log 'opensteam', "Successfully generated opensteam sample application\nGoto '/admin' (usr: admin, pwd: opensteam) to configure your store!"



