if EtGdsDesignSystem::VERSION =~ /^[0-9]+\.[0-9]+\.[0-9]+$/
  say "Installing all JavaScript dependencies [#{EtGdsDesignSystem::VERSION}]"
  run "yarn add https://github.com/hmcts/et_gds_design_system.git#v#{EtGdsDesignSystem::VERSION}"
else
  say "Installing all JavaScript dependencies [from prerelease]"
  run "yarn add https://github.com/hmcts/et_gds_design_system.git"
end

if File.exists?("app/javascript/packs/application.js")
  append_to_file "app/javascript/packs/application.js" do
    <<-EOS
\n
import {EtGdsDesignSystem } from "et_gds_design_system"
import "et_gds_design_system/stylesheet"
EtGdsDesignSystem.initAll();
EOS
  end
end

say "EtGdsDesignSystem successfully installed 🎉 🍰", :green
