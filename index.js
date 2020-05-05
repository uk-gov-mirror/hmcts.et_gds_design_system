const GOVUKFrontend = require("govuk-frontend/govuk/all")
require.context('govuk-frontend/govuk/assets/images', true)
import './stylesheet'
const EtGdsDesignSystem = {};
EtGdsDesignSystem.initAll = () => {
    console.log("EdGdsDesignSystem.initAll was called");
    const onPageLoad = () => {
        document.body.className = ((document.body.className) ? document.body.className + ' js-enabled' : 'js-enabled');

        GOVUKFrontend.initAll()
    }
    document.addEventListener("turbolinks:load", onPageLoad);
};
export { EtGdsDesignSystem };
