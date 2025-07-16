document.addEventListener("turbo:load", function () {
  const checkbox = document.getElementById("toggle-password");
  const passwordField = document.getElementById("password");

  if (checkbox && passwordField) {
    checkbox.addEventListener("change", function () {
      if (this.checked) {
        passwordField.type = "text";
      } else {
        passwordField.type = "password";
      }
    });
  }
});

document.addEventListener("turbo:load", function () {
  const checkbox = document.getElementById("toggle-password_confirmation");
  const passwordField = document.getElementById("password_confirmation");

  if (checkbox && passwordField) {
    checkbox.addEventListener("change", function () {
      if (this.checked) {
        passwordField.type = "text";
      } else {
        passwordField.type = "password";
      }
    });
  }
});
