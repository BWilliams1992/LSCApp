function toggle() {
  let toggler = document.querySelector("#toggler")
  if (toggler.style.display === "none") {
    toggler.style.display = "block"
  } else {
    toggler.style.display = "none"
  }
}

document.addEventListener('turbolinks:load', () => {
  const clickButton = document.querySelector("#toggleButton");
  if (clickButton != null) {
    console.log(clickButton)
    clickButton.addEventListener('click', (e) => {
        toggle()
    });
  }
});