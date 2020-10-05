// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
import {channel} from "./socket"
//
import "phoenix_html"

import $ from 'jquery'

import 'bootstrap';


const form = $('.js-inn-form')
const message_list = $('.js-message-list')
const sample = $('.js-inn-result-sample').first();

form.on('submit', function() {
  const input = $(this).find('input.js-inn-input').first()
  if (input.val().trim() != "") {
    channel.push('new_check', {inn: input.val()})
    input.val('')
  }
  return false
})

channel.on('new_message', payload => {
  console.log(payload)
  const node = sample.clone()
  node.find('.js-date').text(payload.datetime)
  node.find('.js-inn').text(payload.inn)
  node.find('.js-status').text(payload.is_correct ? 'корректен' : 'некорректен')
  message_list.prepend(node)
  node.removeClass('js-inn-result-sample').css('display', '')
  node.addClass(payload.is_correct ? 'correct' : 'incorrect')
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })
