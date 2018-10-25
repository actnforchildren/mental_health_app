if (document.getElementsByClassName("pin")) {
  const pinInputs = Array.from(document.getElementsByClassName("pin"))
  const loginBtn = document.getElementById("login-btn")
  const elemArr = pinInputs.concat(loginBtn)

  pinInputs.map((el, i) => {
    el.onkeydown = (e) => {
      if (el.value.length >= 1 && (e.keyCode !== 8)) {
        e.preventDefault()
      }
    }

    el.onkeyup = (e) => {
      if (el.value.length >= 1 && (e.keyCode !== 8)) {
        elemArr[i + 1].focus();
      }
    }
  })
}
