document.addEventListener("turbo:load", () => {
  const toggleBtn = document.getElementById("toggle-calendar");
  const calendar = document.getElementById("calendar-container");

  if (!toggleBtn || !calendar) return;

  const isOpen = localStorage.getItem("calendarOpen") === "true";
  calendar.style.display = isOpen ? "block" : "none";
  toggleBtn.textContent = isOpen ? "カレンダーを非表示" : "カレンダーを表示（日別の投稿件数を確認できます）";

  toggleBtn.onclick = () => {
    if (calendar.style.display === "none") {
      calendar.style.display = "block";
      toggleBtn.textContent = "カレンダーを非表示";
      localStorage.setItem("calendarOpen", "true");
    } else {
      calendar.style.display = "none";
      toggleBtn.textContent = "カレンダーを表示（日別の投稿件数を確認できます）";
      localStorage.setItem("calendarOpen", "false");
    }
  };
});
