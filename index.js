import RevealOnRadioButton from "./app/javascript/components/RevealOnRadioButton";
import { initAll } from "govuk-frontend";
import "govuk-frontend/dist/govuk/assets/images/favicon.ico"
import "govuk-frontend/dist/govuk/assets/images/favicon.svg"
import "govuk-frontend/dist/govuk/assets/images/govuk-icon-mask.svg"
import "govuk-frontend/dist/govuk/assets/images/govuk-icon-180.png"

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
        initAll();
        Components.RevealOnRadioButton.init();
    }
    document.addEventListener("turbolinks:load", onPageLoad);
};
export { EtGdsDesignSystem, Components };
