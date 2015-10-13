# Autospec

[ ![Codeship Status for peijiehu/autospec](https://codeship.com/projects/0c9c8b50-1a09-0133-cb47-0a73787dedef/status?branch=master)](https://codeship.com/projects/94307)

Gem prototype abstracted from [automation-rspec](https://github.com/peijiehu/automation-rspec).

Demo [autospec-demo](https://github.com/peijiehu/autospec-demo)

## Installation

You can skip the installation and download the demo above instead.

Install this gem - add following to your Gemfile.

    gem 'autospec'

In your spec_helper.rb, add the following lines before Rspec.configure:

    require 'capybara'
    require 'capybara/rspec'
    require 'site_prism'
    require 'autospec'

    # if you want to include Autospec::PageHelperModule for your pages
    # require 'page_objects/all_page_objects'

    Capybara.run_server = false

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

And, add this in your Rspec.configure in spec_helper.rb,

    config.before :each do |example|
      example_full_description = example.full_description
      begin
        driver_helper.set_sauce_session_name(example_full_description) if driver_to_use.include?('saucelabs') && !driver_to_use.nil?
        Autospec.logger.debug "Finished setting saucelabs session name for #{example_full_description}"
      rescue
        Autospec.logger.debug "Failed setting saucelabs session name for #{example_full_description}"
      end
      page.driver.allow_url '*' if driver_to_use == 'webkit'
    end

#### config/autospec/saucelabs.yml

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

#### config/autospec/env.yml

    ---
    qa: 'http://www.qa.xxx.com'
    prod: 'http://www.xxx.com'
    duck: 'https://duckduckgo.com'

#### logs/autospec.log
(empty file, add it to gitignore)

#### reports/
(empty directory for storing test results)

#### .rspec_parallel
when running specs through 'parallel_rspec', options in .rspec_parallel will be used, instead of .rspec. Results should be recorded in JUnit format under reports/, so CI like Jenkins can read and publish. Your .rspec_parallel should look like this:
```

--color
--require spec_helper
--format progress
--format RspecJunitFormatter
--out reports/ci_result_<%= ENV['TEST_ENV_NUMBER'] %>.xml

```

## Usage
To run specs

    r_env=duck rspec                  # to run all specs, on duckduckgo.com
    r_driver=saucelabs rspec          # run all specs on saucelabs, with default OS and browser
    r_driver=saucelabs:peijie:win7_ff38 rspec # see config/autospec/saucelabs.yml for available user, os and browsers

If your test doesn't care browser compatibility, but you still want javascript support, then go with headless webkit,
run:
```
r_driver=webkit rspec
```
To run specs in parallel, with serialized stdout printing out after all specs are done
(note that when running specs through 'parallel_rspec', options in .rspec_parallel will be used, instead of .rspec)
```
parallel_rspec --serialize-stdout -n 15 spec/
```
