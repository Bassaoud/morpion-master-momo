require 'bundler'
require 'json'
require 'colorize'
require 'word_wrap/core_ext'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/Game'
require 'app/Board'
require 'app/Player'
require 'app/BoardCase'
require 'app/Application'
require 'views/Show'

app = Application.new
app.play_app
