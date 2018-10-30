const toolboxOpenBtn = document.getElementById("toolbox-open-btn")
const toolboxCloseBtn = document.getElementById("toolbox-close-btn")
const toolboxModal = document.getElementById("toolbox-modal")
const autoformChecklist = document.getElementById("autoform-checklist")

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
