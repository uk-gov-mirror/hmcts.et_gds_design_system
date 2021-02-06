import RevealOnRadioButton from "./app/javascript/components/RevealOnRadioButton";

const GOVUKFrontend = require("govuk-frontend/govuk/all")
require.context('govuk-frontend/govuk/assets/images', true)
require('turbolinks').start();
import './stylesheet'
import Components from './app/javascript/components'
const EtGdsDesignSystem = {
    Components: Components
};
EtGdsDesignSystem.initAll = () => {
    console.log("EdGdsDesignSystem.initAll was called");
    const onPageLoad = () => {
        document.body.className = ((document.body.className) ? document.body.className + ' js-enabled' : 'js-enabled');

        GOVUKFrontend.initAll();
    }
    document.addEventListener("turbolinks:load", onPageLoad);
};
export { EtGdsDesignSystem, Components, Components.RevealOnRadioButton };
