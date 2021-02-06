const GOVUKFrontend = require("govuk-frontend/govuk/all")
require.context('govuk-frontend/govuk/assets/images', true)
require('turbolinks').start();
import './stylesheet'
const EtGdsDesignSystem = {
    Components: Components
};
EtGdsDesignSystem.initAll = () => {
    console.log("EdGdsDesignSystem.initAll was called");
    const onPageLoad = () => {
        document.body.className = ((document.body.className) ? document.body.className + ' js-enabled' : 'js-enabled');

        GOVUKFrontend.initAll();
        EtGdsDesignSystem.Components.Reveal.init();
    }
    document.addEventListener("turbolinks:load", onPageLoad);
};
export { EtGdsDesignSystem };
