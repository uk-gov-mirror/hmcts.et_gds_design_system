if EtGdsDesignSystem::VERSION =~ /^[0-9]+\.[0-9]+\.[0-9]+$/
  say "Installing all JavaScript dependencies [#{EtGdsDesignSystem::VERSION}]"
  run "yarn add https://github.com/hmcts/et_gds_design_system.git#{EtGdsDesignSystem::VERSION}"
else
  say "Installing all JavaScript dependencies [from prerelease]"
  run "yarn add https://github.com/hmcts/et_gds_design_system.git"
end

say "EtGdsDesignSystem successfully installed 🎉 🍰", :green
