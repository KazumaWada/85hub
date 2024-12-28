// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
///!!!!アプリ全体ののエントリーポイント!!!!!///stimulusのエントリーポイントはcontroller/index

import "@hotwired/turbo-rails";
//import Turbo from '@hotwired/turbo-rails';
//import "popper"
import "controllers/example_controller"; //stimulus. $ rails g stimulus example
//↑app/javascript/controllers/index.jsを参照している。

//bin/rails assets:clobber && bin/rails assets:precompile


