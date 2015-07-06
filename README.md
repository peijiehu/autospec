# Autospec

## Gem prototype abstracted from [automation-rspec](https://github.com/peijiehu/automation-rspec)

## Installation and Usage

Install this gem and require it in your spec_helper.rb. Then add the following lines:
```

    # set default js enabled driver based on user input(env variable),
    # which applies to all tests marked with :type => :feature
    # default is :selenium, and selenium uses :firefox by default
    driver_helper = Autospec::DriverHelper.new("#{Dir.pwd}/config/autospec/saucelabs.yml")
    driver_to_use = driver_helper.driver
    Capybara.javascript_driver = driver_to_use.to_sym

    # sets app_host based on user input(env variable)
    app_host = ENV['r_env'] || begin
      Autospec.logger.debug "r_env is not set, using default env 'qa'"
      'qa'
    end
    env_yaml = YAML.load_file("#{Dir.pwd}/config/autospec/env.yml")
    Capybara.app_host = env_yaml[app_host]

```

#### config/autospec/saucelabs.yml

```

    ---
    driver: 'remote'
    hub:
        url: 'http://ondemand.saucelabs.com/wd/hub'
        user: 'qa'
        pass: 'key'

    timeouts:
        driver: 120
        implicit_wait: 120
        page_load: 60
        script_timeout: 120

    overrides:
        peijie:
            hub:
                user: 'peijiehu'
                pass: 'key'

        smoke:
            hub:
                user:  'smoketest'
                pass:  'key'

        # Platforms and browsers we support
        android_4_phone:
            archetype: 'android'
            capabilities:
                browserName: 'Browser'
                platformVersion: '4.4'
                appium-version: '1.2.2'
                platformName: 'Android'
                deviceName: 'Android Emulator'
                device-orientation: 'portrait'

        osx10_safari8:
            archetype: 'safari'
            capabilities:
                version: '8'
                platform: 'OS X 10.9'
                screen-resolution: '1600x1200'
                safariIgnoreFraudWarning: true

        win7_ff38:
            archetype: 'firefox'
            capabilities:
                version: '38'
                platform: 'Windows 7'
                screen-resolution: '1600x1200'

```

#### config/autospec/env.yml
```

    ---
    qa: 'http://www.qa.xxx.com'
    prod: 'http://www.xxx.com'
    duck: 'https://duckduckgo.com'

```