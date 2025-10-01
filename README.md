# Art Survey
![](https://img.shields.io/badge/Ruby%20Version-3.3.4-red) ![](https://img.shields.io/badge/Rails%20Version-7.2.2.1-red) ![](https://img.shields.io/badge/Postgresql%20Version-14.4-red)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Art Survey is used to enter information about valuable departmentally owned art. In this context, we use “art” to include all valuable objects. These might range from a painting, to valuable gems, to antique instruments, and might be on display or stored in the back of a cupboard.

## Getting Started (Mac)

### Prerequisites
- Postgresql
- University of Michigan Shibboleth + DUO authentication
- 'ldap_lookup' gem requires a proper configuration to be in place

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

## Support / Questions
  Please email the [LSA W&ADS Rails Team](mailto:lsa-was-rails-devs@umich.edu)
