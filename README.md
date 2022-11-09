# Art Survey
![](https://img.shields.io/badge/Ruby%20Version-3.1.2-red) ![](https://img.shields.io/badge/Rails%20Version-7.0.4-red)![](https://img.shields.io/badge/Ruby%20Version-3.1.2-red) ![](https://img.shields.io/badge/Postgresql%20Version-14.4-red)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Art Survey is used to enter information about valuable departmentally owned art. In this context, we use “art” to include all valuable objects. These might range from a painting, to valuable gems, to antique instruments, and might be on display or stored in the back of a cupboard. 
This listing does not apply to collections in LSA's research or public museums. Mounted posters and pictures, book covers and other such items that do not have significant value (nominally under $1000) should not be entered.

## Getting Started (Mac)

### Prerequisites
- homebrew
- git
- postgresql
- make sure your ruby version is correct 
  - use Ruby virtual environments tools (rbenv, for example) to manage ruby versions 
- make sure you have write permissions for the ruby gems directory
- correct version of bundler
```
gem install bundler:2.2.26
```

To get a local copy up and running clone the repo, navigate to the local instance and start the application
```
git clone git@github.com:lsa-mis/art_survey.git
cd art_survey
bundle
bin/rails db:create
bin/rails db:migrate
bin/dev
```

  ## Authentication
  - Omniauth-SAML
    - Shibboleth + DUO
    - Devise
 ## Authorization
 - ldap_lookup - to gather user group affiliation
 - pundit gem - use policies to give access to records and actions based on user's role


## Deployment

## Support / Questions
  Please email the [LSA W&ADS Rails Team](mailto:lsa-was-rails-devs@umich.edu)