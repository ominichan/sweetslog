// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import jquery from "jquery"

window.$ = jquery;
window.jQuery = $;

document.addEventListener("turbo:load", function() {
  $(".slider").slick({
    variableWidth: true,
    centerMode: true, // スライドを中心に表示して部分的に前後のスライドが見えるように設定（奇数番号のスライドに使用）
    dots: true, // ドットインジケーターの表示
    autoplay: true, // 自動再生を設定
    autoplaySpeed: 3000, // 自動再生のスピード（ミリ秒単位）
    speed: 1000, // スライド/フェードアニメーションの速度を設定
    infinite: true
  });
});

document.addEventListener("turbo:load", () => {
  const toggleBtn = document.getElementById("toggle-calendar");
  const calendar = document.getElementById("calendar-container");

  if (toggleBtn && calendar) {
    toggleBtn.addEventListener("click", () => {
      if (calendar.style.display === "none" || calendar.style.display === "") {
        calendar.style.display = "block";
        toggleBtn.textContent = "カレンダーを非表示";
      } else {
        calendar.style.display = "none";
        toggleBtn.textContent = "カレンダーを表示";
      }
    });
  }
});