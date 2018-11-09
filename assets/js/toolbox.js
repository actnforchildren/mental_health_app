const toolboxOpenBtn = document.getElementById("toolbox-open-btn")
const toolboxCloseBtn = document.getElementById("toolbox-close-btn")
const toolboxModal = document.getElementById("toolbox-modal")
const autoformChecklist = document.getElementById("autoform-checklist")
const toolboxSections = document.getElementsByClassName("toolbox-title-section");


if (toolboxOpenBtn) {
  toolboxOpenBtn.onclick = () => {
    toolboxModal.classList.toggle("dn")
    autoformChecklist.classList.toggle("dn")
  }
  toolboxCloseBtn.onclick = () => {
    toolboxModal.classList.toggle("dn")
    autoformChecklist.classList.toggle("dn")
  }
}

// see https://github.com/actnforchildren/mental_health_app/issues/111

if (toolboxSections.length > 0) {
  Array.from(toolboxSections).forEach(function(e) {
    e.addEventListener( 'change', function() {
        if(this.checked) {
          const selectedItems = document.getElementsByClassName("selected-items");
          Array.from(selectedItems).forEach(function(i) {
            i.checked = false;
            i.classList.remove("selected-items")
          })
          this.classList.add("selected-items");
        } else {
          this.classList.remove("selected-items");
        }
    });
  })
}
