RevealOnRadioButton = {
  init: function RevealOnRadioButton() {
    const nodes = Array.from(document.querySelectorAll('[data-module="et-gds-design-system-reveal-on-radio-button"]'));
    document.addEventListener('change', function(e) {
      const node = nodes.find((node) => {
        return e.target.matches(node.attributes['data-reveal-on-selector'].value);
      });
      if (!node) {
        return;
      }

      const value = JSON.parse(node.attributes['data-reveal-on-value'].value);
      if((e.target.value === value || (Array.isArray(value) && value.indexOf(e.target.value) >= 0)) && e.target.checked) {
        showNode(node);
      } else {
        hideNode(node);
      }
    });
    setInitialStates(nodes);
  }
}

/**
 *
 * Hides or shows (reveals) an element based on a radio button group
 * @param node {Element} The element to hide or show
 * @param selector {String} A css selector to identify the radio button group
 * @param value {String} The value that the radio button group must be set to in order to show the element
 */
export default RevealOnRadioButton
function showNode(node) {
  node.style.display = 'block';
}

function hideNode(node) {
  node.style.display = 'none';
}

function setInitialStates(nodes) {
  nodes.forEach((node) => {
    const selector = node.attributes['data-reveal-on-selector'].value;
    const value = JSON.parse(node.attributes['data-reveal-on-value'].value);
    if(isCorrectValue(node, selector, value)) {
      showNode(node);
    } else {
      hideNode(node);
    }
  });
}

function isCorrectValue(node, selector, value) {
  let isChecked = false;
  document.querySelectorAll(selector).forEach(function(radioButton) {
    if(radioButton.value == value  && radioButton.checked) {
      isChecked = true
      return;
    }

  });
  return isChecked;
}
