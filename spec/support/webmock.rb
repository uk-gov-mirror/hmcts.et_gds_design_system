require 'webmock/rspec'
WebMock.disable_net_connect! allow_localhost: true,
                             allow: [
                               'chromedriver.storage.googleapis.com',
                               'github.com',
                               'github-production-release-asset-2e65be.s3.amazonaws.com',
                               'github-releases.githubusercontent.com',
                               'objects.githubusercontent.com',
                               'googlechromelabs.github.io',
                               'edgedl.me.gvt1.com'
                             ]
