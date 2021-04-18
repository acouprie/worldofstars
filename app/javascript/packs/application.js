// jquery must be first
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require formvalidation/formValidation
//= require formvalidation/bootstrap4.min
// tree must be last
//= require_tree .

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

// import "channels"
import 'jquery'
import 'bootstrap';
// import './stylesheets.scss';
import '../src/javascript/update_resources.js';

Rails.start()
Turbolinks.start()
ActiveStorage.start()