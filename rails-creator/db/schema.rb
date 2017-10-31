# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171018231935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "company_name"
    t.string   "corporate_email"
    t.string   "corporate_phone"
    t.string   "corporate_associates"
    t.string   "corporate_website"
    t.string   "corporate_location_address"
    t.string   "corporate_location_city"
    t.integer  "corporate_location_state"
    t.string   "corporate_location_zipcode"
    t.text     "general_notes"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_companies_on_user_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_update_id"
    t.datetime "user_create"
    t.datetime "last_user_update"
    t.string   "name"
    t.string   "location_address"
    t.string   "location_city"
    t.string   "location_zipcode"
    t.string   "mobile_phone_number"
    t.string   "other_phone"
    t.string   "email_address"
    t.text     "general_notes"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "contact_class"
    t.integer  "location_state"
    t.string   "opportunity_size"
    t.string   "opportunity_status"
    t.jsonb    "shopify_associations"
    t.index ["user_id"], name: "index_contacts_on_user_id", using: :btree
    t.index ["user_update_id"], name: "index_contacts_on_user_update_id", using: :btree
  end

  create_table "device_brands", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "device_carriers", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "device_colors", force: :cascade do |t|
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_condition_prices", force: :cascade do |t|
    t.decimal  "amount",                 precision: 10, scale: 2
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "rl_device_condition_id"
    t.integer  "device_id"
    t.integer  "device_carrier_id"
    t.integer  "device_size_id"
    t.index ["device_carrier_id"], name: "index_device_condition_prices_on_device_carrier_id", using: :btree
    t.index ["device_id"], name: "index_device_condition_prices_on_device_id", using: :btree
    t.index ["device_size_id"], name: "index_device_condition_prices_on_device_size_id", using: :btree
    t.index ["rl_device_condition_id"], name: "index_device_condition_prices_on_rl_device_condition_id", using: :btree
  end

  create_table "device_sizes", force: :cascade do |t|
    t.string   "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.jsonb    "image_id",          default: "{}"
    t.integer  "brand_id"
    t.jsonb    "device_carrier_id", default: "{}"
    t.jsonb    "device_size_id",    default: "{}"
    t.jsonb    "device_color_id",   default: "{}"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["user_id"], name: "index_devices_on_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "url"
  end

  create_table "lcd_buyback_conditions", force: :cascade do |t|
    t.string   "condition"
    t.string   "description"
    t.string   "type"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lcd_buyback_edit_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lcd_buyback_lots_id"
    t.jsonb    "lot_data",            default: "{}"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "lcd_count"
    t.jsonb    "price_analysis",      default: "{}"
    t.index ["lcd_buyback_lots_id"], name: "index_lcd_buyback_edit_histories_on_lcd_buyback_lots_id", using: :btree
    t.index ["user_id"], name: "index_lcd_buyback_edit_histories_on_user_id", using: :btree
  end

  create_table "lcd_buyback_lots", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lcd_count"
    t.boolean  "flag",                  default: false
    t.boolean  "transaction_complete"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.jsonb    "lot_data",              default: "{}"
    t.integer  "associated_user_id"
    t.integer  "associated_contact_id"
    t.boolean  "admin_initialized",     default: false
    t.index ["user_id"], name: "index_lcd_buyback_lots_on_user_id", using: :btree
  end

  create_table "lcd_buyback_price_analyses", force: :cascade do |t|
    t.integer  "device_id"
    t.decimal  "lcd_cost",    precision: 10, scale: 2
    t.decimal  "part_cost",   precision: 10, scale: 2
    t.decimal  "labor_cost",  precision: 10, scale: 2
    t.decimal  "break_rate",  precision: 10, scale: 2
    t.decimal  "redo_rate",   precision: 10, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.jsonb    "sales_price"
    t.index ["device_id"], name: "index_lcd_buyback_price_analyses_on_device_id", using: :btree
  end

  create_table "lcd_refurb_conditions", force: :cascade do |t|
    t.string   "condition"
    t.string   "description"
    t.string   "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "status"
  end

  create_table "lcd_refurb_edit_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lcd_refurb_lots_id"
    t.integer  "lcd_count"
    t.jsonb    "lot_data",           default: "{}"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.jsonb    "price_analysis",     default: "{}"
    t.index ["lcd_refurb_lots_id"], name: "index_lcd_refurb_edit_histories_on_lcd_refurb_lots_id", using: :btree
    t.index ["user_id"], name: "index_lcd_refurb_edit_histories_on_user_id", using: :btree
  end

  create_table "lcd_refurb_lots", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "lcd_count"
    t.boolean  "flag"
    t.boolean  "transaction_complete"
    t.jsonb    "lot_data",              default: "{}"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "return_state"
    t.integer  "associated_user_id"
    t.integer  "associated_contact_id"
    t.boolean  "admin_initialized",     default: false
    t.index ["user_id"], name: "index_lcd_refurb_lots_on_user_id", using: :btree
  end

  create_table "lcd_refurb_price_analyses", force: :cascade do |t|
    t.integer  "device_id"
    t.decimal  "lcd_cost",    precision: 10, scale: 2
    t.decimal  "part_cost",   precision: 10, scale: 2
    t.decimal  "labor_cost",  precision: 10, scale: 2
    t.decimal  "break_rate",  precision: 10, scale: 2
    t.decimal  "redo_rate",   precision: 10, scale: 2
    t.decimal  "sales_price", precision: 10, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["device_id"], name: "index_lcd_refurb_price_analyses_on_device_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.integer  "template_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["template_id"], name: "index_pages_on_template_id", using: :btree
  end

  create_table "prepaid2017s", force: :cascade do |t|
    t.string   "sms_phone"
    t.string   "name"
    t.string   "email"
    t.string   "given_phone"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "website"
  end

  create_table "rl_device_conditions", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rl_devices", force: :cascade do |t|
    t.integer  "vendor_package_id"
    t.string   "uuid"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["vendor_package_id"], name: "index_rl_devices_on_vendor_package_id", using: :btree
  end

  create_table "rl_inspection_lists", force: :cascade do |t|
    t.string   "inspection_category"
    t.string   "inspection_detail"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.boolean  "expected_value"
  end

  create_table "rl_lots", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contact_id"
    t.jsonb    "lot_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_rl_lots_on_contact_id", using: :btree
    t.index ["user_id"], name: "index_rl_lots_on_user_id", using: :btree
  end

  create_table "rma_order_credits", force: :cascade do |t|
    t.integer  "rma_order_id"
    t.decimal  "credit_when_ordered", precision: 8, scale: 2
    t.decimal  "current_credit",      precision: 8, scale: 2
    t.jsonb    "line_items",                                  default: "{}"
    t.boolean  "paid_out",                                    default: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.index ["rma_order_id"], name: "index_rma_order_credits_on_rma_order_id", using: :btree
  end

  create_table "rma_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.bigint   "original_order_id"
    t.bigint   "rma_order_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "date_verification"
    t.integer  "shipment_type"
    t.integer  "item_count"
    t.bigint   "draft_order_id"
    t.boolean  "item_validation"
    t.jsonb    "item_validation_details"
    t.string   "shopify_email"
    t.integer  "original_order_number"
    t.index ["user_id"], name: "index_rma_orders_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "admin",                             default: false
    t.boolean  "overview_dashboard",                default: false
    t.boolean  "armordilo_dashboard",               default: false
    t.boolean  "parts_dashboard",                   default: false
    t.boolean  "reverse_logistics_dashboard",       default: false
    t.boolean  "sales_dashboard",                   default: false
    t.boolean  "lcd_buyback_dashboard",             default: false
    t.boolean  "lcd_refurb_dashboard",              default: false
    t.boolean  "armordilo_claims_create",           default: false
    t.boolean  "armordilo_claims_read",             default: false
    t.boolean  "armordilo_claims_update",           default: false
    t.boolean  "armordilo_clients_create",          default: false
    t.boolean  "armordilo_clients_read",            default: false
    t.boolean  "armordilo_clients_update",          default: false
    t.boolean  "parts_create",                      default: false
    t.boolean  "parts_read",                        default: false
    t.boolean  "parts_update",                      default: false
    t.boolean  "parts_archive",                     default: false
    t.boolean  "reverse_logistics_create",          default: false
    t.boolean  "reverse_logistics_read",            default: false
    t.boolean  "reverse_logistics_update",          default: false
    t.boolean  "reverse_logistics_archive",         default: false
    t.boolean  "sales_contacts_create",             default: false
    t.boolean  "sales_contacts_read",               default: false
    t.boolean  "sales_contacts_update",             default: false
    t.boolean  "sales_shopify_read",                default: false
    t.boolean  "sales_client_chat_create",          default: false
    t.boolean  "sales_client_chat_read",            default: false
    t.boolean  "sales_client_chat_update",          default: false
    t.boolean  "lcd_buyback_create",                default: false
    t.boolean  "lcd_buyback_read",                  default: false
    t.boolean  "lcd_buyback_update",                default: false
    t.boolean  "lcd_refurb_create",                 default: false
    t.boolean  "lcd_refurb_read",                   default: false
    t.boolean  "lcd_refurb_update",                 default: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "god_mode",                          default: false
    t.boolean  "devices_create",                    default: false
    t.boolean  "devices_read",                      default: false
    t.boolean  "devices_update",                    default: false
    t.boolean  "devices_archive",                   default: false
    t.boolean  "general_corporate_accounts_create", default: false
    t.boolean  "general_corporate_accounts_read",   default: false
    t.boolean  "general_corporate_accounts_update", default: false
    t.boolean  "individual_store_accounts_create",  default: false
    t.boolean  "individual_store_accounts_read",    default: false
    t.boolean  "individual_store_accounts_update",  default: false
    t.boolean  "prepaid_expo_2017",                 default: false
    t.boolean  "rma_admin",                         default: false
    t.boolean  "rl_device_conditions_create",       default: false
    t.boolean  "rl_lot_create",                     default: false
    t.boolean  "rl_lot_read",                       default: false
    t.boolean  "rl_lot_update",                     default: false
    t.boolean  "rl_lot_archive",                    default: false
    t.index ["user_id"], name: "index_roles_on_user_id", using: :btree
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title"
    t.integer  "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_sections_on_page_id", using: :btree
  end

  create_table "sendgrid_custom_emails", force: :cascade do |t|
    t.string   "sendgrid_message_id"
    t.integer  "contact_id"
    t.jsonb    "events"
    t.string   "subject"
    t.jsonb    "content"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["contact_id"], name: "index_sendgrid_custom_emails_on_contact_id", using: :btree
  end

  create_table "sendgrid_default_emails", force: :cascade do |t|
    t.string   "sendgrid_message_id"
    t.integer  "contact_id"
    t.jsonb    "events"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["contact_id"], name: "index_sendgrid_default_emails_on_contact_id", using: :btree
  end

  create_table "shipping_labels", force: :cascade do |t|
    t.integer  "model_id"
    t.string   "model_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "tracking_number"
  end

  create_table "shippings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopify_customers", force: :cascade do |t|
    t.bigint   "shopify_id"
    t.jsonb    "shopify_data",            default: "{}"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "receives_credit_for_rma", default: false
  end

  create_table "shopify_orders", force: :cascade do |t|
    t.bigint   "shopify_id"
    t.jsonb    "shopify_data", default: "{}"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "shopify_products", force: :cascade do |t|
    t.bigint   "shopify_id"
    t.jsonb    "shopify_data", default: "{}"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "stripe_customers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_stripe_customers_on_user_id", using: :btree
  end

  create_table "supports", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "user_class"
    t.string   "support_reason"
    t.text     "support_description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_supports_on_user_id", using: :btree
  end

  create_table "templates", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_templates_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "agreement_termspp",      default: false
    t.string   "full_name"
    t.string   "phone_number"
    t.text     "extra_details"
    t.string   "user_address"
    t.string   "user_city"
    t.string   "user_state"
    t.string   "user_zipcode"
    t.string   "stripe_customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "vendor_packages", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "original_total"
    t.integer  "running_total"
    t.jsonb    "devices"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.jsonb    "inspection_data"
    t.datetime "date_received"
    t.decimal  "payout",          precision: 8, scale: 2
    t.boolean  "paid",                                    default: false
    t.index ["contact_id"], name: "index_vendor_packages_on_contact_id", using: :btree
  end

  create_table "weights", force: :cascade do |t|
    t.integer  "model_id"
    t.string   "model_type"
    t.decimal  "pounds"
    t.decimal  "ounces"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "companies", "users"
  add_foreign_key "contacts", "users"
  add_foreign_key "device_condition_prices", "device_carriers"
  add_foreign_key "device_condition_prices", "device_sizes"
  add_foreign_key "device_condition_prices", "devices"
  add_foreign_key "device_condition_prices", "rl_device_conditions"
  add_foreign_key "devices", "users"
  add_foreign_key "lcd_buyback_edit_histories", "lcd_buyback_lots", column: "lcd_buyback_lots_id"
  add_foreign_key "lcd_buyback_edit_histories", "users"
  add_foreign_key "lcd_buyback_lots", "users"
  add_foreign_key "lcd_refurb_edit_histories", "lcd_refurb_lots", column: "lcd_refurb_lots_id"
  add_foreign_key "lcd_refurb_edit_histories", "users"
  add_foreign_key "lcd_refurb_lots", "users"
  add_foreign_key "rl_devices", "vendor_packages"
  add_foreign_key "rma_orders", "users"
  add_foreign_key "roles", "users"
  add_foreign_key "sendgrid_custom_emails", "contacts"
  add_foreign_key "sendgrid_default_emails", "contacts"
  add_foreign_key "stripe_customers", "users"
  add_foreign_key "supports", "users"
  add_foreign_key "templates", "users"
  add_foreign_key "vendor_packages", "contacts"
end
