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

ActiveRecord::Schema.define(version: 2019_03_28_213955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
  end

end