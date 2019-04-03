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

ActiveRecord::Schema.define(version: 2019_04_02_152729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.date "gameDate"
    t.integer "awayID"
    t.integer "awayScore"
    t.string "awayName"
    t.integer "homeID"
    t.integer "homeScore"
    t.string "homeName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "migrations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "batch"
    t.datetime "migration_time"
  end

  create_table "migrations_lock", id: false, force: :cascade do |t|
    t.integer "is_locked"
  end

  create_table "past_teams", force: :cascade do |t|
    t.integer "season"
    t.integer "team_id"
    t.string "name"
    t.integer "gamesPlayed"
    t.integer "wins"
    t.integer "losses"
    t.integer "ot"
    t.integer "pts"
    t.decimal "ptPctg", precision: 15, scale: 10
    t.decimal "goalsPerGame", precision: 15, scale: 10
    t.decimal "goalsAgainstPerGame", precision: 15, scale: 10
    t.decimal "evGGARatio", precision: 15, scale: 10
    t.decimal "powerPlayPercentage", precision: 15, scale: 10
    t.integer "powerPlayGoals"
    t.integer "powerPlayGoalsAgainst"
    t.integer "powerPlayOpportunities"
    t.decimal "penaltyKillPercentage", precision: 15, scale: 10
    t.decimal "shotsPerGame", precision: 15, scale: 10
    t.decimal "shotsAllowed", precision: 15, scale: 10
    t.decimal "winScoreFirst", precision: 15, scale: 10
    t.decimal "winOppScoreFirst", precision: 15, scale: 10
    t.decimal "winLeadFirstPer", precision: 15, scale: 10
    t.decimal "winLeadSecondPer", precision: 15, scale: 10
    t.decimal "winOutshootOpp", precision: 15, scale: 10
    t.decimal "winOutshotByOpp", precision: 15, scale: 10
    t.decimal "faceOffsTaken", precision: 15, scale: 10
    t.integer "faceOffsWon"
    t.integer "faceOffsLost"
    t.decimal "faceOffWinPercentage", precision: 15, scale: 10
    t.decimal "shootingPctg", precision: 15, scale: 10
    t.decimal "savePctg", precision: 15, scale: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "gamesPlayed"
    t.integer "wins"
    t.integer "losses"
    t.integer "ot"
    t.integer "pts"
    t.decimal "ptPctg", precision: 4, scale: 2
    t.decimal "goalsPerGame", precision: 4, scale: 2
    t.decimal "goalsAgainstPerGame", precision: 4, scale: 2
    t.decimal "evGGARatio", precision: 4, scale: 2
    t.decimal "powerPlayPercentage", precision: 4, scale: 2
    t.integer "powerPlayGoals"
    t.integer "powerPlayGoalsAgainst"
    t.integer "powerPlayOpportunities"
    t.decimal "penaltyKillPercentage", precision: 4
    t.decimal "shotsPerGame", precision: 4
    t.decimal "shotsAllowed", precision: 4
    t.decimal "winScoreFirst", precision: 4
    t.decimal "winOppScoreFirst", precision: 4
    t.decimal "winLeadFirstPer", precision: 4
    t.decimal "winLeadSecondPer", precision: 4
    t.decimal "winOutshootOpp", precision: 4
    t.decimal "winOutshotByOpp", precision: 4
    t.decimal "faceOffsTaken", precision: 4
    t.integer "faceOffsWon"
    t.integer "faceOffsLost"
    t.decimal "faceOffWinPercentage", precision: 4
    t.decimal "shootingPctg", precision: 4
    t.decimal "savePctg", precision: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
