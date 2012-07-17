# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120717160703) do

  create_table "budgets", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.decimal  "beginning_balance"
    t.integer  "user_id"
  end

  create_table "expense_values", :force => true do |t|
    t.integer  "expense_id"
    t.decimal  "amount"
    t.text     "comment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "expense_date"
    t.boolean  "is_paid"
  end

  create_table "expenses", :force => true do |t|
    t.datetime "expense_date"
    t.decimal  "amount"
    t.string   "frequency"
    t.string   "title"
    t.string   "shortcode"
    t.integer  "budget_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "isfixed"
    t.integer  "auto_withdrawal", :default => 0
    t.string   "status"
  end

  create_table "income_values", :force => true do |t|
    t.date     "income_date"
    t.decimal  "amount"
    t.integer  "income_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "incomes", :force => true do |t|
    t.date     "income_date"
    t.decimal  "amount"
    t.string   "frequency"
    t.string   "title"
    t.integer  "sort_weight"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "budget_id"
  end

  create_table "periods", :force => true do |t|
    t.integer  "budget_id"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "beginning_balance"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
