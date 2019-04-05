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

ActiveRecord::Schema.define(version: 2019_04_04_164330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "faceoff_results", force: :cascade do |t|
    t.integer "team1_id"
    t.decimal "team1_percent_chance_win", precision: 10, scale: 2
    t.integer "team2_id"
    t.decimal "team2_percent_chance_win", precision: 10, scale: 2
    t.decimal "mean_absolute_error", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.string "status"
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
    t.decimal "ptPctg", precision: 10, scale: 2
    t.decimal "goalsPerGame", precision: 10, scale: 2
    t.decimal "goalsAgainstPerGame", precision: 10, scale: 2
    t.decimal "evGGARatio", precision: 10, scale: 2
    t.decimal "powerPlayPercentage", precision: 10, scale: 2
    t.integer "powerPlayGoals"
    t.integer "powerPlayGoalsAgainst"
    t.integer "powerPlayOpportunities"
    t.decimal "penaltyKillPercentage", precision: 10, scale: 2
    t.decimal "shotsPerGame", precision: 10, scale: 2
    t.decimal "shotsAllowed", precision: 10, scale: 2
    t.decimal "winScoreFirst", precision: 10, scale: 2
    t.decimal "winOppScoreFirst", precision: 10, scale: 2
    t.decimal "winLeadFirstPer", precision: 10, scale: 2
    t.decimal "winLeadSecondPer", precision: 10, scale: 2
    t.decimal "winOutshootOpp", precision: 10, scale: 2
    t.decimal "winOutshotByOpp", precision: 10, scale: 2
    t.integer "faceOffsTaken"
    t.integer "faceOffsWon"
    t.integer "faceOffsLost"
    t.decimal "faceOffWinPercentage", precision: 10, scale: 2
    t.decimal "shootingPctg", precision: 10, scale: 2
    t.decimal "savePctg", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season"
    t.integer "team_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
