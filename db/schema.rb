

ActiveRecord::Schema.define(version: 2020_05_02_015915) do

  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_date"
    t.string "status"
    t.integer "priority"
    t.index ["name"], name: "index_tasks_on_name"
  end

end
