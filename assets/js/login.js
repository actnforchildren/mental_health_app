if (document.getElementsByClassName("pin")) {
  const pin_inputs = Array.from(document.getElementsByClassName("pin"))

  pin_inputs.map((el, i) => {
    el.onkeyup = () => {
      if (el.value.length == el.maxLength) {
        pin_inputs[i + 1].focus()
      }
    }
  })
}
