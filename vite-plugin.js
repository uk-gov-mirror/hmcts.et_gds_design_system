import path from "path";

export default function EtGdsDesignSystemPlugin() {
    return {
        name: "et-gds-design-system",
        config: (config) => {
            config.resolve = config.resolve || {};
            config.resolve.alias = config.resolve.alias || {};

            config.resolve.alias["@govuk-assets"] = path.resolve(
                process.cwd(), // app root
                "node_modules/govuk-frontend/dist/govuk/assets",
            );

            return config;
        },
    };
}
