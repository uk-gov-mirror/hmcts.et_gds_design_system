import RevealOnRadioButton from "./app/javascript/components/RevealOnRadioButton";
import { initAll } from "govuk-frontend";
import TurboLinks from "turbolinks"
TurboLinks.start();
import './stylesheet.scss'
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
