document.addEventListener("turbo:load", () => {
  const dropdown = document.getElementById("notificationDropdown");

  if (dropdown) {
    dropdown.addEventListener("toggle", () => {
      if (dropdown.open) {
        fetch("/notifications/mark_as_read", {
          method: "PATCH",
          headers: {
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
          }
        }).then(() => {
          const countEl = document.getElementById("notification-count");
          if (countEl) {
            countEl.style.display = "none";
          }
        });
      }
    });
  }
});