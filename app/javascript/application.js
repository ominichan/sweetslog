// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import jquery from "jquery"
import "./place_autocomplete.js"
import "./toggle_calendar.js"

window.$ = jquery;
window.jQuery = $;

document.addEventListener("turbo:load", function() {
  $(".slider").slick({
    variableWidth: true,
    centerMode: true,
    dots: true,
    autoplay: true,
    autoplaySpeed: 3000,
    speed: 1000,
    infinite: true
  });
});

$(window).on("scroll load", function(){
  var scroll = $(this).scrollTop();
  var windowHeight = $(window).height();
  $(".fadeIn").each(function(){
    var cntPos = $(this).offset().top;
    if(scroll > cntPos - windowHeight + windowHeight / 3){
      $(this).addClass("active");
    }
  });
});

$(function(){
  const hamburger = $('#js-hamburger');
  const drawer = $('#js-drawer');
  hamburger.on('click',function(){
    hamburger.toggleClass("is-checked")
    drawer.toggleClass("is-checked")
  })
})
