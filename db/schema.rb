# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_12_022349) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "alquilers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hours"
    t.integer "status"
  end

  create_table "billeteras", force: :cascade do |t|
    t.float "saldo", default: 0.0, null: false
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_billeteras_on_usuario_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.integer "card_type"
    t.string "digits"
    t.string "security_code"
    t.date "exp_date"
    t.float "money", default: 0.0, null: false
    t.integer "billetera_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billetera_id"], name: "index_cards_on_billetera_id"
  end

  create_table "compras", force: :cascade do |t|
    t.string "medio_de_pago"
    t.string "datos_cuenta"
    t.float "monto", default: 0.0, null: false
    t.integer "billetera_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billetera_id"], name: "index_compras_on_billetera_id"
  end

  create_table "cvus", force: :cascade do |t|
    t.string "name"
    t.string "digits"
    t.string "alias"
    t.float "money", default: 0.0, null: false
    t.integer "billetera_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billetera_id"], name: "index_cvus_on_billetera_id"
  end

  create_table "penalties", force: :cascade do |t|
    t.string "motivo"
    t.string "descripcion"
    t.integer "tarifa"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_penalties_on_usuario_id"
  end

  create_table "rates", force: :cascade do |t|
    t.string "rent_name"
    t.integer "rent_price"
    t.string "extension_name"
    t.integer "extension_price"
    t.string "penalty_name"
    t.integer "penalty_price"
    t.string "gas_name"
    t.integer "gas_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string "subject"
    t.string "message"
    t.integer "status", default: 0
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_reports_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname"
    t.integer "dni"
    t.date "birthdate"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.string "unlock_token"
    t.boolean "valid_license", default: false
    t.date "license_expiration_date"
    t.float "latitude", default: -34.903445
    t.float "longitude", default: -57.938195
    t.boolean "validated"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_usuarios_on_unlock_token", unique: true
  end

  create_table "vehiculos", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.string "color"
    t.string "fuel_type"
    t.integer "capacity"
    t.string "transmission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "proximity", default: 100.0
    t.string "license_plate"
    t.float "latitude"
    t.float "longitude"
    t.boolean "enable", default: true
    t.string "address"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
